using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Apress.EF6Recipes.Concurrency.Recipe3
{
    public static class Recipe3Program
    {
        public static void Run()
        {
            using (var context = new Recipe3Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.Employee");
                context.SaveChanges();

                using (var scope1 = new TransactionScope())
                {
                    // save, but don't commit
                    var outerEmp = new Employee { Name = "Karen Stanfield" };
                    Console.WriteLine("Outer employee: {0}", outerEmp.Name);
                    context.Employees.Add(outerEmp);
                    context.SaveChanges();

                    // second transaction for read uncommitted
                    using (var innerContext = new Recipe3Context())
                    {
                        using (var scope2 = new TransactionScope(
                            TransactionScopeOption.RequiresNew,
                            new TransactionOptions
                            {
                                IsolationLevel = IsolationLevel.ReadUncommitted
                            }))
                        {
                            var innerEmp = innerContext.Employees
                                            .First(e => e.Name == "Karen Stanfield");
                            Console.WriteLine("Inner employee: {0}", innerEmp.Name);
                            scope1.Complete();
                            scope2.Complete();
                        }
                    }
                }
            }
            
        }
    }
}

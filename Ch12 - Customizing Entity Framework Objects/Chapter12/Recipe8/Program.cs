using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe8
{
    class Program
    {
        static void Main(string[] args)
        {
            RunExample();
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var emp1 = new Employee { Name = "Roger Smith", Salary = 108000M };
                var emp2 = new Employee { Name = "Jane Hall", Salary = 81500M };
                context.Employees.Add(emp1);
                context.Employees.Add(emp2);
                context.SaveChanges();
                emp1.Salary = emp1.Salary * 1.5M;
                try
                {
                    context.SaveChanges();
                }
                catch (Exception)
                {
                    Console.WriteLine("Oops, tried to increase a salary too much!");
                }
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine();
                Console.WriteLine("Employees");
                foreach (var emp in context.Employees)
                {
                    Console.WriteLine("{0} makes {1}/year", emp.Name,
                                       emp.Salary.ToString("C"));
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
    }

    public partial class EFRecipesEntities
    {
        public override int SaveChanges()
        {
            var entries = this.ChangeTracker.Entries().Where(e => e.Entity is Employee && e.State == System.Data.Entity.EntityState.Modified);
            foreach (var entry in entries)
            {
                var originalSalary = Convert.ToDecimal(
                                entry.OriginalValues["Salary"]);
                var currentSalary = Convert.ToDecimal(
                                entry.CurrentValues["Salary"]);
                if (originalSalary != currentSalary)
                {
                    if (currentSalary > originalSalary * 1.1M)
                        throw new ApplicationException(
                                    "Can't increase salary more than 10%");
                }
            }
            return base.SaveChanges();
        }
    }
}
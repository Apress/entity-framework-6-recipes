using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe2
{
    public static class Recipe2Program
    {
        public static void Run()
        {
            using (var context = ContextFactory.CreateContext())
            {
                context.Customers.AddObject(
                      new Customer { Name = "Jill Nickels" });
                context.Customers.AddObject(
                      new Customer { Name = "Robert Cole" });
                context.SaveChanges();
            }

            using (var context = ContextFactory.CreateContext())
            {
                Console.WriteLine("Customers");
                Console.WriteLine("---------");
                foreach (var customer in context.Customers)
                {
                    Console.WriteLine("{0}", customer.Name);
                }
            }            
        }


    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe1
{
    public static class Recipe1Program
    {
        public static void Run()
        {
            //Add customers to the database that we will query with our stored procedure.
            using (var context = new Recipe1Context())
            {
                var c1 = new Customer
                {
                    Name = "Robin Steele",
                    Company = "GoShopNow.com",
                    ContactTitle = "CEO"
                };
                var c2 = new Customer
                {
                    Name = "Orin Torrey",
                    Company = "GoShopNow.com",
                    ContactTitle = "Sales Manager"
                };
                var c3 = new Customer
                {
                    Name = "Robert Lancaster",
                    Company = "GoShopNow.com",
                    ContactTitle = "Sales Manager"
                };
                var c4 = new Customer
                {
                    Name = "Julie Stevens",
                    Company = "GoShopNow.com",
                    ContactTitle = "Sales Manager"
                };
                context.Customers.Add(c1);
                context.Customers.Add(c2);
                context.Customers.Add(c3);
                context.Customers.Add(c4);
                context.SaveChanges();
            }

            using (var context = new Recipe1Context())
            {
                var allCustomers = context.GetCustomers("GoShopNow.com", "Sales Manager");
                Console.WriteLine("Customers that are Sales Managers at GoShopNow.com");
                foreach (var c in allCustomers)
                {
                    Console.WriteLine("Customer: {0}", c.Name);
                }
            }
            
        }
    }
}

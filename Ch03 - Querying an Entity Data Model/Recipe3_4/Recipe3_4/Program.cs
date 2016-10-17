using System;
using System.Data;
using System.Data.Entity.Core.EntityClient;
using System.Data.Entity.Infrastructure;

namespace Recipe3_4
{
    class Program
    {
        static void Main()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.customer");                
                // add new test data
                var cus1 = new Customer
                {
                    Name = "Robert Stevens",
                    Email = "rstevens@mymail.com"
                };
                var cus2 = new Customer
                {
                    Name = "Julia Kerns",
                    Email = "julia.kerns@abc.com"
                };
                var cus3 = new Customer
                {
                    Name = "Nancy Whitrock",
                    Email = "nrock@myworld.com"
                };
                context.Customers.Add(cus1);
                context.Customers.Add(cus2);
                context.Customers.Add(cus3);
                context.SaveChanges();
            }

            // using object services from ObjectContext object
            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Querying Customers with eSQL Leveraging Object Services...");
                string esql = "select value c from Customers as c";
                // cast the DbContext to the underlying ObjectContext, as DbContext does not 
                // provide direct support for EntitySQL queries
                var customers = ((IObjectContextAdapter)context).ObjectContext.CreateQuery<Customer>(esql);
                foreach (var customer in customers)
                {
                    Console.WriteLine("{0}'s email is: {1}",
                                       customer.Name, customer.Email);
                }
            }

            Console.WriteLine(System.Environment.NewLine);

            // using EntityClient
            using (var conn = new EntityConnection("name=EFRecipesEntities"))
            {
                Console.WriteLine("Customers Customers with eSQL Leveraging Entity Client...");
                var cmd = conn.CreateCommand();
                conn.Open();
                cmd.CommandText = "select value c from EFRecipesEntities.Customers as c";
                using (var reader = cmd.ExecuteReader(CommandBehavior.SequentialAccess))
                {
                    while (reader.Read())
                    {
                        Console.WriteLine("{0}'s email is: {1}",
                                           reader.GetString(1), reader.GetString(2));
                    }
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}

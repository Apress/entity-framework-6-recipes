using System;

namespace Recipe1
{
    internal class Program
    {
        private static void Main()
        {
            Cleanup();
            RunExample();
        }

        private static void Cleanup()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.customeremail");
                context.Database.ExecuteSqlCommand("delete from chapter5.customer");
                context.Database.ExecuteSqlCommand("delete from chapter5.customertype");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var web = new CustomerType {Description = "Web Customer", CustomerTypeId = 1};
                var retail = new CustomerType {Description = "Retail Customer", CustomerTypeId = 2};
                var customer = new Customer {Name = "Joan Smith", CustomerType = web};
                customer.CustomerEmails.Add(new CustomerEmail {Email = "jsmith@gmail.com"});
                customer.CustomerEmails.Add(new CustomerEmail {Email = "joan@smith.com"});
                context.Customers.Add(customer);
                customer = new Customer {Name = "Bill Meyers", CustomerType = retail};
                customer.CustomerEmails.Add(new CustomerEmail {Email = "bmeyers@gmail.com"});
                context.Customers.Add(customer);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var customers = context.Customers;
                Console.WriteLine("Customers");
                Console.WriteLine("=========");

                // Only information from the Customer entity is requested
                foreach (var customer in customers)
                {
                    Console.WriteLine("Customer name is {0}", customer.Name);
                }

                // Now, application is requesting information from the related entities, CustomerType 
                // and CustomerEmail, resulting in Entity Framework generating separate queries to each 
                // entity object in order to obtain the requested information.
                foreach (var customer in customers)
                {
                    Console.WriteLine("{0} is a {1}, email address(es)", customer.Name,
                                      customer.CustomerType.Description);
                    foreach (var email in customer.CustomerEmails)
                    {
                        Console.WriteLine("\t{0}", email.Email);
                    }
                }

                // Extra credit:
                // If you enable SQL Server Profiler, the following query will not requery the database
                // for related data. Instead, it will return the in-memory data from the prior
                // query.
                foreach (var customer in customers)
                {
                    Console.WriteLine("{0} is a {1}, email address(es)", customer.Name,
                                      customer.CustomerType.Description);
                    foreach (var email in customer.CustomerEmails)
                    {
                        Console.WriteLine("\t{0}", email.Email);
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
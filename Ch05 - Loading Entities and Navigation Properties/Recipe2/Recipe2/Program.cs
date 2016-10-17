using System;
using System.Data.Entity;
using System.Linq;

namespace Recipe2
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
                // Include() method with a string-based query path to the
                // corresponding navigation properties
                var customers = context.Customers
                                       .Include("CustomerType")
                                       .Include("CustomerEmails");
                Console.WriteLine("Customers");
                Console.WriteLine("=========");
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

            using (var context = new EFRecipesEntities())
            {
                // Include() method with a strongly-typed query path to the 
                // corresponding navigation properties 
                var customerTypes = context.CustomerTypes
                                           .Include(x => x.Customers
                                                          .Select(y => y.CustomerEmails));

                Console.WriteLine("\nCustomers by Type");
                Console.WriteLine("=================");
                foreach (var customerType in customerTypes)
                {
                    Console.WriteLine("Customer type: {0}", customerType.Description);
                    foreach (var customer in customerType.Customers)
                    {
                        Console.WriteLine("{0}", customer.Name);
                        foreach (var email in customer.CustomerEmails)
                        {
                            Console.WriteLine("\t{0}", email.Email);
                        }
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
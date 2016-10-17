using System;

namespace Recipe14
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
                context.Database.ExecuteSqlCommand("delete from chapter5.invoice");
                context.Database.ExecuteSqlCommand("delete from chapter5.client");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var client1 = new Client {Name = "Karen Standfield", ClientId = 1};
                var invoice1 = new Invoice {InvoiceDate = DateTime.Parse("4/1/10"), Amount = 29.95M};
                var invoice2 = new Invoice {InvoiceDate = DateTime.Parse("4/2/10"), Amount = 49.95M};
                var invoice3 = new Invoice {InvoiceDate = DateTime.Parse("4/3/10"), Amount = 102.95M};
                var invoice4 = new Invoice {InvoiceDate = DateTime.Parse("4/4/10"), Amount = 45.99M};

                // Add invoice to client's collection
                client1.Invoices.Add(invoice1);

                // Assign the foreign key directly
                invoice2.ClientId = 1;

                // Attach() and existing row using a "fake" entity
                context.Database.ExecuteSqlCommand("insert into chapter5.client values (2, 'Phil Marlowe')");
                var client2 = new Client {ClientId = 2};
                context.Clients.Attach(client2);
                invoice3.Client = client2;

                // Using the ClientReference
                invoice4.Client = client1;

                // Save the changes
                context.Clients.Add(client1);
                context.Invoices.Add(invoice2);
                context.Invoices.Add(invoice3);
                context.Invoices.Add(invoice4);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var client in context.Clients)
                {
                    Console.WriteLine("Client: {0}", client.Name);
                    foreach (var invoice in client.Invoices)
                    {
                        Console.WriteLine("\t{0} for {1}", invoice.InvoiceDate.ToShortDateString(),
                                          invoice.Amount.ToString("C"));
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
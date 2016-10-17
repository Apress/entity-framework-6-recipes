using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe7
{
    public static class Recipe7Program
    {
        public static void Run()
        {
            using (var context = new Recipe7Context())
            {

                var invoice1 = new Invoice
                                   {
                                       BilledTo = "Julie Kerns",
                                       InvoiceDate = DateTime.Parse("9/19/2013")
                                   };
                var invoice2 = new Invoice
                                   {
                                       BilledTo = "Jim Stevens",
                                       InvoiceDate = DateTime.Parse("9/21/2013")
                                   };
                var invoice3 = new Invoice
                                   {
                                       BilledTo ="Juanita James",
                                       InvoiceDate = DateTime.Parse("9/23/2013")
                                   };
                context.LineItems.Add(new LineItem
                                          {
                                              Cost = 99.29M,
                                              Invoice = invoice1
                                          });
                context.LineItems.Add(new LineItem
                                          {
                                              Cost = 29.95M,
                                              Invoice = invoice1
                                          });
                context.LineItems.Add(new LineItem
                                          {
                                              Cost = 109.95M,
                                              Invoice = invoice2
                                          });
                context.LineItems.Add(new LineItem
                                          {
                                              Cost = 49.95M,
                                              Invoice = invoice3
                                          });
                context.SaveChanges();

                // display the line items
                Console.WriteLine("Original set of line items...");
                DisplayLineItems();

                // remove a line item from invoice 1's collection
                var item = invoice1.LineItems.ToList().First();
                invoice1.LineItems.Remove(item);
                context.SaveChanges();
                Console.WriteLine("\nAfter removing a line item from an invoice...");
                DisplayLineItems();

                // remove invoice2
                context.Invoices.Remove(invoice2);
                context.SaveChanges();
                Console.WriteLine("\nAfter removing an invoice...");
                DisplayLineItems();

                // remove a single line item
                context.LineItems.Remove(invoice1.LineItems.First());
                context.SaveChanges();
                Console.WriteLine("\nAfter removing a line item...");
                DisplayLineItems();

                // update a single line item
                var item2 = invoice3.LineItems.ToList().First();
                item2.Cost = 39.95M;
                context.SaveChanges();
                Console.WriteLine("\nAfter updating a line item from an invoice …");
                DisplayLineItems();
            }
        }

        static void DisplayLineItems()
        {
            bool found = false;
            using (var context = new Recipe7Context())
            {
                foreach (var lineitem in context.LineItems)
                {
                    Console.WriteLine("Line item: Cost {0}", 
                                       lineitem.Cost.ToString("C"));
                    found = true;
                }
            }
            if (!found)
                Console.WriteLine("No line items found!");
        }

    }
}

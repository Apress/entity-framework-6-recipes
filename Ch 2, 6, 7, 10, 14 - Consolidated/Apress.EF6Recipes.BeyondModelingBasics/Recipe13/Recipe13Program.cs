using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe13
{
    public class Recipe13Program
    {
        public static void Run()
        {
            using (var context = new Recipe13Context())
            {
                context.Invoices.Add(new Invoice
                {
                    Amount = 19.95M,
                    Description = "Oil Change",
                    Date = DateTime.Parse("4/11/13")
                });
                context.Invoices.Add(new Invoice
                {
                    Amount = 129.95M,
                    Description = "Wheel Alignment",
                    Date = DateTime.Parse("4/01/13")
                });
                context.Invoices.Add(new DeletedInvoice
                {
                    Amount = 39.95M,
                    Description = "Engine Diagnosis",
                    Date = DateTime.Parse("4/01/13")
                });
                context.SaveChanges();
            }

            using (var context = new Recipe13Context())
            {
                foreach (var invoice in context.Invoices)
                {
                    var isDeleted = invoice as DeletedInvoice;
                    Console.WriteLine("{0} Invoice",
                                      isDeleted == null ? "Active" : "Deleted");
                    Console.WriteLine("Description: {0}", invoice.Description);
                    Console.WriteLine("Amount: {0:C}", invoice.Amount);
                    Console.WriteLine("Date: {0}", invoice.Date.ToShortDateString());
                    Console.WriteLine();
                }
            }
            
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe11
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
                context.ParkingTickets.Add(new ParkingTicket { Amount = 132.0M, Paid = false });
                context.ParkingTickets.Add(new ParkingTicket { Amount = 255.0M, Paid = false });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var ticket in context.ParkingTickets)
                {
                    Console.WriteLine("Ticket: {0}", ticket.TicketId);
                    Console.WriteLine("Date: {0}", ticket.CreateDate.ToShortDateString());
                    Console.WriteLine("Amount: {0}", ticket.Amount.ToString("C"));
                    Console.WriteLine("Paid: {0}",
                                ticket.PaidDate.HasValue ?
                                ticket.PaidDate.Value.ToShortDateString() : "Not Paid");
                    Console.WriteLine();
                    ticket.Paid = true; // just paid ticket!
                }

                // save all those Paid flags
                context.SaveChanges();
                foreach (var ticket in context.ParkingTickets)
                {
                    Console.WriteLine("Ticket: {0}", ticket.TicketId);
                    Console.WriteLine("Date: {0}", ticket.CreateDate.ToShortDateString());
                    Console.WriteLine("Amount: {0}", ticket.Amount.ToString("C"));
                    Console.WriteLine("Paid: {0}",
                                ticket.PaidDate.HasValue ?
                                ticket.PaidDate.Value.ToShortDateString() : "Not Paid");
                    Console.WriteLine();
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
    }
}
using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;

namespace Recipe5
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
            using (var context = new Recipe5Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter13.payment");
                context.Database.ExecuteSqlCommand("delete from chapter13.account");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe5Context())
            {
                var watch = new Stopwatch();
                watch.Start();
                for (var i = 0; i < 5000; i++)
                {
                    var account = new Account { Name = "Test" + i, Balance = 10M, 
                        Payments = new Collection<Payment> { new Payment {PaidTo = "Test" + (i + 1), Paid = 5M }},} ;
                    context.Accounts.Add(account);
                    Console.WriteLine("Adding Account {0}", i);
                }
                context.SaveChanges();
                watch.Stop();
                Console.WriteLine("Time to insert: {0} seconds", watch.Elapsed.TotalSeconds);
            }

            using (var context = new Recipe5Context())
            {
                var watch = new Stopwatch();
                watch.Start();
                var accounts = context.Accounts.Include("Payments").ToList();
                watch.Stop();
                Console.WriteLine("Time to read: {0} seconds", watch.Elapsed.TotalSeconds);

                watch.Restart();
                foreach (var account in accounts)
                {
                    account.Balance += 10M;
                    account.Payments.First().Paid += 1M;
                }
                context.SaveChanges();
                watch.Stop();
                Console.WriteLine("Time to update: {0} seconds", watch.Elapsed.TotalSeconds);
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
using System;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Apress.EF6Recipes.Concurrency.Recipe5
{
    public static class Recipe5Program
    {
        public static void Run()
        {
            using (var context = new Recipe5Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.Account");
                context.SaveChanges();
            }

            using (var context = new Recipe5Context())
            {
                context.Accounts.Add(new Account
                {
                    AccountNumber = "8675309",
                    Balance = 100M,
                    Name = "Robin Rosen"
                });
                context.Accounts.Add(new Account
                {
                    AccountNumber = "8535937",
                    Balance = 25M,
                    Name = "Steven Bishop"
                });
                context.SaveChanges();
            }

            using (var context = new Recipe5Context())
            {
                // get the account
                var account = context.Accounts.First(a => a.AccountNumber == "8675309");
                Console.WriteLine("Account for {0}", account.Name);
                Console.WriteLine("\tPrevious Balance: {0}", account.Balance.ToString("C"));

                // some other process updates the balance
                Console.WriteLine("[Rogue process updates balance!]");
                context.Database.ExecuteSqlCommand(@"update chapter14.account set balance = 1000 
                                   where accountnumber = '8675309'");

                // update the account balance
                account.Balance = 10M;

                try
                {
                    Console.WriteLine("\tNew Balance: {0}", account.Balance.ToString("C"));
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    Console.WriteLine("Exception: {0}", ex.Message);
                }
            }
        }
    }
}
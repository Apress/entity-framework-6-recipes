using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe9
{
    public static class Recipe9Program
    {
        public static async Task Run()
        {
            using (var context = new Recipe9Context())
            {
                var account1 = new Account
                {
                    AccountHolder = "Robert Dewey",
                    Transactions = new HashSet<Transaction>()
                                                          {
                                                              new Transaction
                                                                  {
                                                                      TransactionDate = Convert.ToDateTime("07/05/2013"),
                                                                      Amount = 104.00M
                                                                  },
                                                             new Transaction
                                                                 {
                                                                     TransactionDate = Convert.ToDateTime("07/12/2013"),
                                                                     Amount = 104.00M
                                                                 },
                                                             new Transaction
                                                                 {
                                                                     TransactionDate = Convert.ToDateTime("07/19/2013"),
                                                                     Amount = 104.00M
                                                                 }
                                                          }
                };
                var account2 = new Account
                {
                    AccountHolder = "James Cheatham",
                    Transactions = new List<Transaction>
                                                          {
                                                              new Transaction
                                                                  {
                                                                      TransactionDate = Convert.ToDateTime("08/01/2013"),
                                                                      Amount = 900.00M
                                                                  },
                                                              new Transaction
                                                                  {
                                                                      TransactionDate = Convert.ToDateTime("08/02/2013"),
                                                                      Amount = -42.00M
                                                                  }
                                                          }
                };
                var account3 = new Account
                {
                    AccountHolder = "Thurston Howe",
                    Transactions = new List<Transaction>
                                                          {
                                                              new Transaction
                                                                  {
                                                                      TransactionDate = Convert.ToDateTime("08/05/2013"),
                                                                      Amount = 100.00M
                                                                  }
                                                          }
                };

                context.Accounts.Add(account1);
                context.Accounts.Add(account2);
                context.Accounts.Add(account3);
                context.SaveChanges();

                //Add monthly service charges for each account.
                foreach (var account in context.Accounts)
                {
                    var transactions = new List<Transaction>
                                       {
                                           new Transaction
                                               {
                                                   TransactionDate = Convert.ToDateTime("08/09/2013"),
                                                   Amount = -5.00M
                                               },
                                           new Transaction
                                               {
                                                   TransactionDate = Convert.ToDateTime("08/09/2013"),
                                                   Amount = -2.00M
                                               }
                                       };

                    Task saveTask = SaveAccountTransactionsAsync(account.AccountNumber, transactions);

                    Console.WriteLine("Account Transactions for the account belonging to {0} (acct# {1})", account.AccountHolder, account.AccountNumber);
                    await saveTask;
                    await ShowAccountTransactionsAsync(account.AccountNumber);
                }


            }
            
        }

        private static async Task SaveAccountTransactionsAsync(int accountNumber, ICollection<Transaction> transactions)
        {
            using (var context = new Recipe9Context())
            {
                var account = new Account { AccountNumber = accountNumber };
                context.Accounts.Attach(account);
                context.Entry(account).Collection(a => a.Transactions).Load();

                foreach (var transaction in transactions.OrderBy(t => t.TransactionDate))
                {
                    account.Transactions.Add(transaction);
                }

                await context.SaveChangesAsync();

            }

        }

        private static async Task ShowAccountTransactionsAsync(int accountNumber)
        {
            Console.WriteLine("TxNumber\tDate\tAmount");
            using (var context = new Recipe9Context())
            {
                var transactions = context.Transactions.Where(t => t.AccountNumber == accountNumber);
                await transactions.ForEachAsync(t => Console.WriteLine("{0}\t{1}\t{2}", t.TransactionNumber, t.TransactionDate, t.Amount));
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe9
{
    public static class Recipe9Program
    {
        public static void Run()
        {
            using (var context = new Recipe9Context())
            {
                context.Database.ExecuteSqlCommand(@"insert into chapter2.account
            (DeletedOn,AccountHolderId) values ('2/10/2009',1728)");

                var account = new Account { AccountHolderId = 2320 };
                context.Accounts.Add(account);
                account = new Account { AccountHolderId = 2502 };
                context.Accounts.Add(account);
                account = new Account { AccountHolderId = 2603 };
                context.Accounts.Add(account);
                context.SaveChanges();
            }

            using (var context = new Recipe9Context())
            {
                foreach (var account in context.Accounts)
                {
                    Console.WriteLine("Account Id = {0}",
                                       account.AccountHolderId.ToString());
                }
            }
            
        }
    }
}

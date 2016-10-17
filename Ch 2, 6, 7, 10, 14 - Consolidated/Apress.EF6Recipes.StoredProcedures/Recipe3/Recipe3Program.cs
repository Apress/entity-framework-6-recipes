using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe3
{
    public static class Recipe3Program
    {
        public static void Run()
        {
            using (var context = new Recipe3Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter10.ATMWithdrawal");
                context.Database.ExecuteSqlCommand("delete from chapter10.ATMMachine");
                context.SaveChanges();
            }
            
            DateTime today = DateTime.Parse("5/7/2013");
            DateTime yesterday = DateTime.Parse("5/6/2013");
            using (var context = new Recipe3Context())
            {
                var atm = new ATMMachine { ATMId = 17, Location = "12th and Main" };

                //context.ATMMachines.Add(atm);
                //context.SaveChanges();

                atm.ATMWithdrawals.Add(new ATMWithdrawal { Amount = 20.00M, Date = today });
                atm.ATMWithdrawals.Add(new ATMWithdrawal { Amount = 100.00M, Date = today });
                atm.ATMWithdrawals.Add(new ATMWithdrawal { Amount = 75.00M, Date = yesterday });
                atm.ATMWithdrawals.Add(new ATMWithdrawal { Amount = 50.00M, Date = today });
                context.ATMMachines.Add(atm);
                var result = context.SaveChanges();
            }

            using (var context = new Recipe3Context())
            {
                var forToday = context.GetWithdrawals(17, today).FirstOrDefault();
                var forYesterday = context.GetWithdrawals(17, yesterday).FirstOrDefault();
                var atm = context.ATMMachines.Where(o => o.ATMId == 17).FirstOrDefault();
                Console.WriteLine("ATM Withdrawals for ATM at {0} at {1}",
                         atm.ATMId.ToString(), atm.Location);
                Console.WriteLine("\t{0} Total Withdrawn = {1}",
                         yesterday.ToShortDateString(), forYesterday.Value.ToString("C"));
                Console.WriteLine("\t{0} Total Withdrawn = {1}", today.ToShortDateString(),
                         forToday.Value.ToString("C"));
            }
            
        }
    }
}

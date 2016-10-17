using System;
using System.Linq;

namespace Recipe3_19
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.[order]");
                context.Database.ExecuteSqlCommand("delete from chapter3.account");
                // add new test data
                var account1 = new Account {City = "Raytown", State = "MO"};
                account1.Orders.Add(new Order
                {
                    Amount = 223.09M,
                    ShipCity = "Raytown",
                    ShipState = "MO"
                });
                account1.Orders.Add(new Order
                {
                    Amount = 189.32M,
                    ShipCity = "Olathe",
                    ShipState = "KS"
                });

                var account2 = new Account {City = "Kansas City", State = "MO"};
                account2.Orders.Add(new Order
                {
                    Amount = 99.29M,
                    ShipCity = "Kansas City",
                    ShipState = "MO"
                });

                var account3 = new Account {City = "North Kansas City", State = "MO"};
                account3.Orders.Add(new Order
                {
                    Amount = 102.29M,
                    ShipCity = "Overland Park",
                    ShipState = "KS"
                });
                context.Accounts.Add(account1);
                context.Accounts.Add(account2);
                context.Accounts.Add(account3);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var orders = from o in context.Orders
                    join a in context.Accounts on
                        // use annonymous class construct to create composite search expression
                        new {Id = o.AccountId, City = o.ShipCity, State = o.ShipState}
                        equals
                        new {Id = a.AccountId, City = a.City, State = a.State}
                    select o;

                Console.WriteLine("Orders shipped to the account's city, state...");
                foreach (var order in orders)
                {
                    Console.WriteLine("\tOrder {0} for {1}", order.AccountId.ToString(),
                        order.Amount.ToString());
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
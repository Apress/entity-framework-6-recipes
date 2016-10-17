using System;
using System.Linq;

namespace Recipe10
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
            using (var context = new Recipe10Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.orderitem");
                context.Database.ExecuteSqlCommand("delete from chapter5.[order]");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe10Context())
            {
                var order = new Order {CustomerName = "Jenny Craig", OrderDate = DateTime.Parse("3/12/2010")};

                var item1 = new OrderItem {Order = order, Shipped = 3, SKU = 2827, UnitPrice = 12.95M};
                var item2 = new OrderItem {Order = order, Shipped = 1, SKU = 1918, UnitPrice = 19.95M};
                var item3 = new OrderItem {Order = order, Shipped = 3, SKU = 392, UnitPrice = 8.95M};

                order.OrderItems.Add(item1);
                order.OrderItems.Add(item2);
                order.OrderItems.Add(item3);

                context.Orders.Add(order);
                context.SaveChanges();
            }

            using (var context = new Recipe10Context())
            {
                // Assume we have an instance of Order
                var order = context.Orders.First();

                // Get the total order amount
                var amt = context.Entry(order)
                    .Collection(x => x.OrderItems)
                    .Query()
                    .Sum(y => y.Shipped*y.UnitPrice);

                Console.WriteLine("Order Number: {0}", order.OrderId);
                Console.WriteLine("Order Date: {0}", order.OrderDate.ToShortDateString());
                Console.WriteLine("Order Total: {0}", amt.ToString("C"));
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
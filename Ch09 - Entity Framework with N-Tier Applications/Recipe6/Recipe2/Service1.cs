using System;
using System.Collections;
using System.Data.Entity.Core;
using System.Data.SqlTypes;
using System.Linq;

namespace Recipe2
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class Service1 : IService1
    {
        public Order InsertOrder()
        {
            using (var context = new EFRecipesEntities())
            {
                // remove previous test data
                context.Database.ExecuteSqlCommand("delete from chapter9.[order]");

                var order = new Order {Product = "Camping Tent", Quantity = 3, Status = "Received"};
                context.Orders.Add(order);
                context.SaveChanges();
                return order;
            }
        }

        public void UpdateOrderWithoutRetrieving(Order order)
        {
            using (var context = new EFRecipesEntities())
            {
                try
                {
                    context.Orders.Attach(order);
                    if (order.Status == "Received")
                    {
                        context.Entry(order).Property(x => x.Quantity).IsModified = true;
                        context.SaveChanges();
                    }
                }
                catch (OptimisticConcurrencyException ex)
                {
                    // Handle OptimisticConcurrencyException     
                    
                }
            }
        }

        public void UpdateOrderByRetrieving(Order order)
        {
            using (var context = new EFRecipesEntities())
            {
                // fetch current entity from database
                var dbOrder = context.Orders.Single(o => o.OrderId == order.OrderId);
                if (dbOrder != null &&
                    // execute concurrency check
                    StructuralComparisons.StructuralEqualityComparer.Equals(order.TimeStamp, dbOrder.TimeStamp))
                {
                    dbOrder.Quantity = order.Quantity;
                    context.SaveChanges();
                }
            }
        }
    }
}
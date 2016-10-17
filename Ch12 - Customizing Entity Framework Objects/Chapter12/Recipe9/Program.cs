using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.Core;
namespace CustomEFRecipe9
{
    class Program
    {
        static void Main(string[] args)
        {
            Cleanup();
            RunExample();
        }

        static void Cleanup()
        {
            using (var context = new EFRecipesEntities())
            {
                context.ExecuteStoreCommand("delete from chapter12.[order]");
                context.ExecuteStoreCommand("delete from chapter12.orderstatus");
            }
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                // static order status
                var assemble = new OrderStatus
                {
                    OrderStatusId = 1,
                    Status = "Assemble"
                };
                var test = new OrderStatus
                {
                    OrderStatusId = 2,
                    Status = "Test"
                };
                var ship = new OrderStatus
                {
                    OrderStatusId = 3,
                    Status = "Ship"
                };
                context.OrderStatus.AddObject(assemble);
                context.OrderStatus.AddObject(test);
                context.OrderStatus.AddObject(ship);

                var order = new Order
                {
                    Description = "HAL 9000 Supercomputer",
                    OrderStatus = assemble
                };
                context.Orders.AddObject(order);
                context.SaveChanges();
                order.OrderStatus = ship;
                try
                {
                    context.SaveChanges();
                }
                catch (Exception)
                {
                    Console.WriteLine("Oops...better test first.");
                }
                order.OrderStatus = test;
                context.SaveChanges();
                order.OrderStatus = ship;
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var order in context.Orders)
                {
                    Console.WriteLine("Order {0} [{1}], status = {2}",
                                        order.OrderId.ToString(),
                                        order.Description,
                                        order.OrderStatus.Status);
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
    }

    public partial class EFRecipesEntities
    {

        partial void OnContextCreated()
        {
            this.SavingChanges += new EventHandler(EFRecipesEntities_SavingChanges);
        }

        void EFRecipesEntities_SavingChanges(object sender, EventArgs e)
        {
            this.DetectChanges();
            // all the tracked orders
            var orders = this.ObjectStateManager.GetObjectStateEntries(EntityState.Modified | EntityState.Unchanged).Where(entry => entry.Entity is Order).Select(entry => entry.Entity as Order);

            foreach (var order in orders)
            {
                var deletedEntry = this.ObjectStateManager.GetObjectStateEntries(EntityState.Deleted).Where(entry => entry.IsRelationship && entry.EntitySet.Name == order.OrderStatusReference.RelationshipSet.Name).FirstOrDefault();
                if (deletedEntry != null)
                {
                    EntityKey deletedKey = null;
                    if ((EntityKey)deletedEntry.OriginalValues[0] == order.EntityKey)
                    {
                        deletedKey = deletedEntry.OriginalValues[1] as EntityKey;
                    }
                    else if ((EntityKey)deletedEntry.OriginalValues[1] == order.EntityKey)
                    {
                        deletedKey = deletedEntry.OriginalValues[0] as EntityKey;
                    }
                    if (deletedKey != null)
                    {
                        var oldStatus = this.GetObjectByKey(deletedKey) as OrderStatus;

                        // better be going to the next status
                        if (oldStatus.OrderStatusId + 1 != order.OrderStatus.OrderStatusId)
                            throw new ApplicationException("Can't transition to that order status!");
                    }
                }
            }
        }
    }
}

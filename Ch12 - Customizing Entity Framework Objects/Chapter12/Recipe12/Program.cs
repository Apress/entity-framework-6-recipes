using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace CustomEFRecipe12
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
                context.Database.ExecuteSqlCommand("delete from chapter12.salesorder");
                context.Database.ExecuteSqlCommand("delete from chapter12.customer");
            }
        }

        static void RunExample()
        {
            // bad order date
            using (var context = new EFRecipesEntities())
            {
                var customer = new Customer { Name = "Phil Marlowe" };
                var order = new SalesOrder
                {
                    OrderDate = DateTime.Parse("3/12/18"),
                    Amount = 19.95M,
                    Status = "Approved",
                    ShippingCharge = 3.95M,
                    Customer = customer
                };
                context.SalesOrders.Add(order);
                try
                {
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            // order shipped before it was ordered
            using (var context = new EFRecipesEntities())
            {
                var customer = new Customer { Name = "Phil Marlowe" };
                var order = new SalesOrder
                {
                    OrderDate = DateTime.Parse("3/12/13"),
                    Amount = 19.95M,
                    Status = "Approved",
                    ShippingCharge = 3.95M,
                    Customer = customer
                };
                context.SalesOrders.Add(order);
                context.SaveChanges();
                try
                {
                    order.Shipped = true;
                    order.ShippedDate = DateTime.Parse("3/10/13");
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            // order shipped, but not approved
            using (var context = new EFRecipesEntities())
            {
                var customer = new Customer { Name = "Phil Marlowe" };
                var order = new SalesOrder
                {
                    OrderDate = DateTime.Parse("3/12/13"),
                    Amount = 19.95M,
                    Status = "Pending",
                    ShippingCharge = 3.95M,
                    Customer = customer
                };
                context.SalesOrders.Add(order);
                context.SaveChanges();
                try
                {
                    order.Shipped = true;
                    order.ShippedDate = DateTime.Parse("3/13/13");
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            // order over $5,000 and shipping not free
            using (var context = new EFRecipesEntities())
            {
                var customer = new Customer { Name = "Phil Marlowe" };
                var order = new SalesOrder
                {
                    OrderDate = DateTime.Parse("3/12/13"),
                    Amount = 6200M,
                    Status = "Approved",
                    ShippingCharge = 59.95M,
                    Customer = customer
                };
                context.SalesOrders.Add(order);
                context.SaveChanges();
                try
                {
                    order.Shipped = true;
                    order.ShippedDate = DateTime.Parse("3/13/13");
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            // order deleted after it was shipped
            using (var context = new EFRecipesEntities())
            {
                var customer = new Customer { Name = "Phil Marlowe" };
                var order = new SalesOrder
                {
                    OrderDate = DateTime.Parse("3/12/13"),
                    Amount = 19.95M,
                    Status = "Approved",
                    ShippingCharge = 3.95M,
                    Customer = customer
                };
                context.SalesOrders.Add(order);
                context.SaveChanges();
                order.Shipped = true;
                order.ShippedDate = DateTime.Parse("3/13/13");
                context.SaveChanges();
                try
                {
                    context.SalesOrders.Remove(order);
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
    }

    public partial class EFRecipesEntities
    {
        public override int SaveChanges()
        {
            var entries = this.ChangeTracker.Entries().Where(e => e.Entity is IValidator).ToList();    
            foreach (var entry in entries)
            {
                var entity = entry.Entity as IValidator;
                entity.Validate(entry);
            }
            return base.SaveChanges();
        }
    }    
}

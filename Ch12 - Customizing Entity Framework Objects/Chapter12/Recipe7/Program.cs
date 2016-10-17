using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe7
{
    class Program
    {
        static void Main(string[] args)
        {
            RunExample();
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                context.PurchaseOrders.Add(
                                  new PurchaseOrder { Amount = 109.98M });
                context.PurchaseOrders.Add(
                                  new PurchaseOrder { Amount = 20.99M });
                context.PurchaseOrders.Add(
                                  new PurchaseOrder { Amount = 208.89M });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Purchase Orders");
                foreach (var po in context.PurchaseOrders)
                {
                    Console.WriteLine("Purchase Order: {0}",
                                       po.PurchaseOrderId.ToString(""));
                    Console.WriteLine("\tPaid: {0}", po.Paid ? "Yes" : "No");
                    Console.WriteLine("\tAmount: {0}", po.Amount.ToString("C"));
                    Console.WriteLine("\tCreated On: {0}",
                                       po.CreateDate.ToShortTimeString());
                    Console.WriteLine("\tModified at: {0}",
                                       po.ModifiedDate.ToShortTimeString());
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
            var changeSet = this.ChangeTracker.Entries().Where(e => e.Entity is PurchaseOrder);
            if (changeSet != null)
            {
                foreach (var order in changeSet.Where(c => c.State == System.Data.Entity.EntityState.Added).Select(a => a.Entity as PurchaseOrder))
                {
                    order.PurchaseOrderId = Guid.NewGuid();
                    order.CreateDate = DateTime.UtcNow;
                    order.ModifiedDate = DateTime.UtcNow;
                }
                foreach (var order in changeSet.Where(c => c.State == System.Data.Entity.EntityState.Modified).Select(a => a.Entity as PurchaseOrder))
                {
                    order.ModifiedDate = DateTime.UtcNow;
                }
            }
            return base.SaveChanges();
        }
    }
}
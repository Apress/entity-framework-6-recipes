using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe1
{
    public static class Recipe1Program
    {
        public static void Run()
        {
            using (var context = new Recipe1Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.product");
                context.SaveChanges();
            }
            
            using (var context = new Recipe1Context())
            {
                context.Products.Add(new Product
                {
                    Name = "High Country Backpacking Tent",
                    UnitPrice = 199.95M
                });

                context.SaveChanges();
            }

            using (var context = new Recipe1Context())
            {
                // get the product
                var product = context.Products.SingleOrDefault();
                Console.WriteLine("{0} Unit Price: {1}", product.Name,
                                   product.UnitPrice.ToString("C"));

                // update out of band
                context.Database.ExecuteSqlCommand(@"update chapter14.product set 
                        unitprice = 229.95 where productId = @p0", product.ProductId);

                // update the product the via the model
                product.UnitPrice = 239.95M;
                Console.WriteLine("Changing {0}'s Unit Price to: {1}", product.Name,
                                   product.UnitPrice.ToString("C"));

                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    Console.WriteLine("Concurrency Exception! {0}", ex.Message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception! {0}", ex.Message);
                }
            }
            
        }
    }
}

using System;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe3_10
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.topselling");
                context.Database.ExecuteSqlCommand("delete from chapter3.product");
                // add new test data
                // note that p1 has no associated TopSelling entity as do the other products
                var p1 = new Product { Name = "Trailrunner Backpack" };
                var p2 = new Product
                {
                    Name = "Green River Tent",
                    TopSelling = new TopSelling { Rating = 3 }
                };
                var p3 = new Product
                {
                    Name = "Prairie Home Dutch Oven",
                    TopSelling = new TopSelling { Rating = 4 }
                };
                var p4 = new Product
                {
                    Name = "QuickFire Fire Starter",
                    TopSelling = new TopSelling { Rating = 2 }
                };
                context.Products.Add(p1);
                context.Products.Add(p2);
                context.Products.Add(p3);
                context.Products.Add(p4);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var products = from p in context.Products
                               orderby p.TopSelling.Rating descending
                               select p;
                Console.WriteLine("All products, including those without ratings");

                foreach (var product in products)
                {
                    Console.WriteLine("\t{0} [rating: {1}]", product.Name,
                        product.TopSelling == null ? "0" 
                            : product.TopSelling.Rating.ToString());
                }
            }

            using (var context = new EFRecipesEntities())
            {
                var products = from p in context.Products
                               join t in context.TopSellings on
                               // note how we project the results together into another
                               // sequence, entitled 'g' and apply the DefaultIfEmpty method
                                  p.ProductID equals t.ProductID into g
                               from tps in g.DefaultIfEmpty()
                               orderby tps.Rating descending
                               select new
                               {
                                   Name = p.Name,
                                   Rating = tps.Rating == null ? 0 : tps.Rating
                               };

                Console.WriteLine("\nAll products, including those without ratings");
                foreach (var product in products)
                {
                    Console.WriteLine("\t{0} [rating: {1}]", product.Name,
                        product.Rating.ToString());
                }
            }

            using (var context = new EFRecipesEntities())
            {
                var esql = @"select value p from products as p
                 order by case when p.TopSelling is null then 0
                                    else p.TopSelling.Rating end desc";
                var products = ((IObjectContextAdapter)context).ObjectContext.CreateQuery<Product>(esql);
                Console.WriteLine("\nAll products, including those without ratings");
                foreach (var product in products)
                {
                    Console.WriteLine("\t{0} [rating: {1}]", product.Name,
                        product.TopSelling == null ? "0"
                            : product.TopSelling.Rating.ToString());
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}

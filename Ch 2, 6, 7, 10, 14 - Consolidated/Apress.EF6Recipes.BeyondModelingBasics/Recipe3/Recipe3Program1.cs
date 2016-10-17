using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe3
{
    public static class Recipe3Program1
    {
        public static void Run()
        {
            using (var context = new Recipe3Context())
            {
                var product1 = new Product { Name = "Pole", Price = 12.97M };
                var product2 = new Product { Name = "Tent", Price = 199.95M };
                var product3 = new Product { Name = "Ground Cover", Price = 29.95M };
                product2.RelatedProducts.Add(product3);
                product1.RelatedProducts.Add(product2);
                context.Products.Add(product1);
                context.SaveChanges();
            } using (var context = new Recipe3Context())
            {
                var product2 = context.Products.First(p => p.Name == "Tent");
                Console.WriteLine("Product: {0} ... {1}", product2.Name,
                                   product2.Price.ToString("C"));
                Console.WriteLine("Related Products");
                foreach (var prod in product2.RelatedProducts)
                {
                    Console.WriteLine("\t{0} ... {1}", prod.Name, prod.Price.ToString("C"));
                }
                foreach (var prod in product2.OtherRelatedProducts)
                {
                    Console.WriteLine("\t{0} ... {1}", prod.Name, prod.Price.ToString("C"));
                }
            }
            
        }
    }
}

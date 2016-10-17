using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe3
{
    public static class Recipe3Program2
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
            }

            using (var context = new Recipe3Context())
            {
                var product1 = context.Products.First(p => p.Name == "Pole");
                Dictionary<int, Product> t = new Dictionary<int, Product>();
                GetRelated(context, product1, t);
                Console.WriteLine("Products related to {0}", product1.Name);
                foreach (var key in t.Keys)
                {
                    Console.WriteLine("\t{0}", t[key].Name);
                }
            }
            
        }

        static void GetRelated(DbContext context, Product p, Dictionary<int, Product> t)
        {
            context.Entry(p).Collection(ep => ep.RelatedProducts).Load();
            foreach (var relatedProduct in p.RelatedProducts)
            {
                if (!t.ContainsKey(relatedProduct.ProductId))
                {
                    t.Add(relatedProduct.ProductId, relatedProduct);
                    GetRelated(context, relatedProduct, t);
                }
            }
            context.Entry(p).Collection(ep => ep.OtherRelatedProducts).Load();
            foreach (var otherRelated in p.OtherRelatedProducts)
            {
                if (!t.ContainsKey(otherRelated.ProductId))
                {
                    t.Add(otherRelated.ProductId, otherRelated);
                    GetRelated(context, otherRelated, t);
                }
            }
        }

    }
}

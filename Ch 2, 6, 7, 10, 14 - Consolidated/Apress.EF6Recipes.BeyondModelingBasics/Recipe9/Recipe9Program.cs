using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe9
{
    public static class Recipe9Program
    {
        public static void Run()
        {
            using (var context = new Recipe9Context())
            {
                context.Database.ExecuteSqlCommand(@"insert into chapter6.toy
             (Name,ForDonationOnly) values ('RagDoll',1)");
                var toy = new Toy { Name = "Fuzzy Bear", Price = 9.97M };
                var refurb = new RefurbishedToy
                {
                    Name = "Derby Car",
                    Price = 19.99M,
                    Quality = "Ok to sell"
                };
                context.Toys.Add(toy);
                context.Toys.Add(refurb);
                context.SaveChanges();
            }

            using (var context = new Recipe9Context())
            {
                Console.WriteLine("All Toys");
                Console.WriteLine("========");
                foreach (var toy in context.Toys)
                {
                    Console.WriteLine("{0}", toy.Name);
                }
                Console.WriteLine("\nRefurbished Toys");
                foreach (var toy in context.Toys.OfType<RefurbishedToy>())
                {
                    Console.WriteLine("{0}, Price = {1}, Quality = {2}", toy.Name,
                                       toy.Price, ((RefurbishedToy)toy).Quality);
                }
            }
            
        }
    }
}

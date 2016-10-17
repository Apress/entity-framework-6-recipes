using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe10
{
    public static class Recipe10Program
    {
        public static void Run()
        {
            using (var context = new Recipe10Context())
            {
                var book1 = new Book
                {
                    Title = "A Day in the Life",
                    Publisher = "Colorful Press"
                };
                var book2 = new Book
                {
                    Title = "Spring in October",
                    Publisher = "AnimalCover Press"
                };
                var dvd1 = new DVD { Title = "Saving Sergeant Pepper", Rating = "G" };
                var dvd2 = new DVD { Title = "Around The Block", Rating = "PG-13" };
                context.Products.Add(book1);
                context.Products.Add(book2);
                context.Products.Add(dvd1);
                context.Products.Add(dvd2);
                context.SaveChanges();

                // update a book and delete a dvd
                book1.Title = "A Day in the Life of Sergeant Pepper";
                context.Products.Remove(dvd2);
                context.SaveChanges();
            }

            using (var context = new Recipe10Context())
            {
                Console.WriteLine("All Products");
                Console.WriteLine("============");
                foreach (var product in context.Products)
                {
                    if (product is Book)
                        Console.WriteLine("'{0}' published by {1}",
                              product.Title, ((Book)product).Publisher);
                    else if (product is DVD)
                        Console.WriteLine("'{0}' is rated {1}",
                              product.Title, ((DVD)product).Rating);
                }
            }
            
        }
    }
}

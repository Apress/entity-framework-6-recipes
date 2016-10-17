using System;
using System.Linq;

namespace Recipe13
{
    internal class Program
    {
        private static void Main()
        {
            Cleanup();
            RunExample();
        }

        private static void Cleanup()
        {
            using (var context = new Recipe13Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.movie");
                context.Database.ExecuteSqlCommand("delete from chapter5.category");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe13Context())
            {
                var cat1 = new Category {Name = "Science Fiction", ReleaseType = "DVD"};
                var cat2 = new Category {Name = "Thriller", ReleaseType = "Blu-Ray"};
                var movie1 = new Movie {Name = "Return to the Moon", Category = cat1, Rating = "PG-13"};
                var movie2 = new Movie {Name = "Street Smarts", Category = cat2, Rating = "PG-13"};
                var movie3 = new Movie {Name = "Alien Revenge", Category = cat1, Rating = "R"};
                var movie4 = new Movie {Name = "Saturday Nights", Category = cat1, Rating = "PG-13"};
                context.Categories.Add(cat1);
                context.Categories.Add(cat2);
                context.Movies.Add(movie1);
                context.Movies.Add(movie2);
                context.Movies.Add(movie3);
                context.Movies.Add(movie4);
                context.SaveChanges();
            }

            using (var context = new Recipe13Context())
            {
                // filter on ReleaseType and Rating
                // create collection of anonymous types
                var cats = from c in context.Categories
                           where c.ReleaseType == "DVD"
                           select new
                               {
                                   category = c,
                                   movies = c.Movies.Where(m => m.Rating == "PG-13")
                               };

                Console.WriteLine("PG-13 Movies Released on DVD");
                Console.WriteLine("============================");
                foreach (var cat in cats)
                {
                    var category = cat.category;
                    Console.WriteLine("Category: {0}", category.Name);
                    foreach (var movie in cat.movies)
                    {
                        Console.WriteLine("\tMovie: {0}", movie.Name);
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
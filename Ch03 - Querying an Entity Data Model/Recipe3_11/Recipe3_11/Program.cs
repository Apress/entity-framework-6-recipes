using System;
using System.Linq;

namespace Recipe3_11
{
    internal class Program
    {
        private static void Main()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.Media");
                // add new test data
                context.Media.Add(new Article
                {
                    Title = "Woodworkers' Favorite Tools"
                });
                context.Media.Add(new Article
                {
                    Title = "Building a Cigar Chair"
                });
                context.Media.Add(new Video
                {
                    Title = "Upholstering the Cigar Chair"
                });
                context.Media.Add(new Video
                {
                    Title = "Applying Finish to the Cigar Chair"
                });
                context.Media.Add(new Picture
                {
                    Title = "Photos of My Cigar Chair"
                });
                context.Media.Add(new Video
                {
                    Title = "Tour of My Woodworking Shop"
                });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var allMedium = from m in context.Media
                    let mediumtype = m is Article
                        ? 1
                        : m is Video ? 2 : 3
                    orderby mediumtype
                    select m;
                Console.WriteLine("All Medium sorted by type...\n");
                foreach (var medium in allMedium)
                {
                    Console.WriteLine("Title: {0} [{1}]", medium.Title, medium.GetType().Name);
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
using System;
using System.Linq;

namespace Recipe2
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
            using (var context = new Recipe2Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter13.painting");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe2Context())
            {
                context.Paintings.Add(new Painting
                {
                    AccessionNumber = "PN001",
                    Name = "Sunflowers",
                    Artist = "Rosemary Golden",
                    LastSalePrice = 1250M
                });
            }

            using (var context = new Recipe2Context())
            {
                // LINQ query always fetches entity from database, even if it already exists in context
                var paintingFromDatabase = context.Paintings.FirstOrDefault(x => x.AccessionNumber == "PN001"); 
                
                // Find() method fetches entity from context object
                var paintingFromContext = context.Paintings.Find("PN001");
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
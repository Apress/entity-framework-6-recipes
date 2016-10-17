using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe11
{
    public static class Recipe11Program
    {
        public static void Run()
        {
            using (var context = new Recipe11Context())
            {
                var park = new Park
                {
                    Name = "11th Street Park",
                    Address = "801 11th Street",
                    City = "Aledo",
                    State = "TX",
                    ZIPCode = "76106"
                };
                var loc = new Location
                {
                    Address = "501 Main",
                    City = "Weatherford",
                    State = "TX",
                    ZIPCode = "76201"
                };
                park.Office = loc;
                context.Locations.Add(park);
                park = new Park
                {
                    Name = "Overland Park",
                    Address = "101 High Drive",
                    City = "Springtown",
                    State = "TX",
                    ZIPCode = "76081"
                };
                loc = new Location
                {
                    Address = "8705 Range Lane",
                    City = "Springtown",
                    State = "TX",
                    ZIPCode = "76081"
                };
                park.Office = loc;
                context.Locations.Add(park);
                context.SaveChanges();
            }

            using (var context = new Recipe11Context())
            {
                context.Configuration.LazyLoadingEnabled = true;
                Console.WriteLine("-- All Locations -- ");
                foreach (var l in context.Locations)
                {
                    Console.WriteLine("{0}, {1}, {2} {3}", l.Address, l.City,
                                        l.State, l.ZIPCode);
                }

                Console.WriteLine("--- Parks ---");
                foreach (var p in context.Locations.OfType<Park>())
                {
                    Console.WriteLine("{0} is at {1} in {2}", p.Name, p.Address, p.City);
                    Console.WriteLine("\tOffice: {0}, {1}, {2} {3}", p.Office.Address,
                                        p.Office.City, p.Office.State, p.Office.ZIPCode);
                }
            }
            
        }
    }
}

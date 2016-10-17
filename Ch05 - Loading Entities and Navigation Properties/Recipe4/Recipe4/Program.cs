using System;
using System.Linq;

namespace Recipe4
{
    internal class Program
    {
        private static void Main()
        {
            {
                Cleanup();
                RunExample();
            }
        }

        private static void Cleanup()
        {
            using (var context = new Recipe4Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.event");
                context.Database.ExecuteSqlCommand("delete from chapter5.club");
            }
        }

        private static void RunExample()
        {
            int desertSunId;

            using (var context = new Recipe4Context())
            {
                var starCity = new Club {Name = "Star City Chess Club", City = "New York"};
                var desertSun = new Club {Name = "Desert Sun Chess Club", City = "Phoenix"};
                var palmTree = new Club {Name = "Palm Tree Chess Club", City = "San Diego"};

                context.Clubs.Add(starCity);
                context.Clubs.Add(desertSun);
                context.Clubs.Add(palmTree);

                context.SaveChanges();

                desertSunId = desertSun.ClubId;
            }

            using (var context = new Recipe4Context())
            {
                Console.WriteLine("\nLocal Collection Behavior");
                Console.WriteLine("=================");

                Console.WriteLine("\nNumber of Clubs Contained in Local Collection: {0}", context.Clubs.Local.Count);
                Console.WriteLine("=================");

                Console.WriteLine("\nClubs Retrieved from Context Object");
                Console.WriteLine("=================");
                foreach (var club in context.Clubs.Take(2))
                {
                    Console.WriteLine("{0} is located in {1}", club.Name, club.City);
                }

                Console.WriteLine("\nClubs Contained in Context Local Collection");
                Console.WriteLine("=================");
                foreach (var club in context.Clubs.Local)
                {
                    Console.WriteLine("{0} is located in {1}", club.Name, club.City);
                }

                context.Clubs.Find(desertSunId);

                Console.WriteLine("\nClubs Retrieved from Context Object - Revisted");
                Console.WriteLine("=================");
                foreach (var club in context.Clubs)
                {
                    Console.WriteLine("{0} is located in {1}", club.Name, club.City);
                }

                Console.WriteLine("\nClubs Contained in Context Local Collection - Revisted");
                Console.WriteLine("=================");
                foreach (var club in context.Clubs.Local)
                {
                    Console.WriteLine("{0} is located in {1}", club.Name, club.City);
                }

                // Get reference to local observable collection 
                var localClubs = context.Clubs.Local;

                // Add new Club
                var lonesomePintId = -999;
                localClubs.Add(new Club
                    {
                        City = "Portland",
                        Name = "Lonesome Pine",
                        ClubId = lonesomePintId
                    });

                // Remove Desert Sun club
                localClubs.Remove(context.Clubs.Find(desertSunId));

                Console.WriteLine("\nClubs Contained in Context Object - After Adding and Deleting");
                Console.WriteLine("=================");
                foreach (var club in context.Clubs)
                {
                    Console.WriteLine("{0} is located in {1} with a Entity State of {2}",
                                      club.Name, club.City, context.Entry(club).State);
                }

                Console.WriteLine("\nClubs Contained in Context Local Collection - After Adding and Deleting");
                Console.WriteLine("=================");
                foreach (var club in localClubs)
                {
                    Console.WriteLine("{0} is located in {1} with a Entity State of {2}",
                                      club.Name, club.City, context.Entry(club).State);
                }

                Console.WriteLine("\nPress <enter> to continue...");
                Console.ReadLine();
            }
        }
    }
}
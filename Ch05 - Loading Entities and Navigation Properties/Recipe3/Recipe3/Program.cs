using System;
using System.Linq;

namespace Recipe3
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
            using (var context = new Recipe3Context())
            {
                // Clear out prior test data
                context.Database.ExecuteSqlCommand("delete from chapter5.event");
                context.Database.ExecuteSqlCommand("delete from chapter5.club");
            }
        }

        private static void RunExample()
        {
            int starCityId;
            int desertSunId;
            int palmTreeId;

            using (var context = new Recipe3Context())
            {
                var starCity = new Club {Name = "Star City Chess Club", City = "New York"};
                var desertSun = new Club {Name = "Desert Sun Chess Club", City = "Phoenix"};
                var palmTree = new Club {Name = "Palm Tree Chess Club", City = "San Diego"};

                context.Clubs.Add(starCity);
                context.Clubs.Add(desertSun);
                context.Clubs.Add(palmTree);
                context.SaveChanges();

                // SaveChanges() returns newly created Id value for each club
                starCityId = starCity.ClubId;
                desertSunId = desertSun.ClubId;
                palmTreeId = palmTree.ClubId;
            }

            using (var context = new Recipe3Context())
            {
                var starCity = context.Clubs.SingleOrDefault(x => x.ClubId == starCityId);
                starCity = context.Clubs.SingleOrDefault(x => x.ClubId == starCityId);
                starCity = context.Clubs.Find(starCityId);
                var desertSun = context.Clubs.Find(desertSunId);
                var palmTree = context.Clubs.AsNoTracking().SingleOrDefault(x => x.ClubId == palmTreeId);
                palmTree = context.Clubs.Find(palmTreeId);
                var lonesomePintId = -999;
                context.Clubs.Add(new Club {City = "Portland", Name = "Lonesome Pine", ClubId = lonesomePintId,});
                var lonesomePine = context.Clubs.Find(lonesomePintId);
                var nonexistentClub = context.Clubs.Find(10001);
            }

            Console.WriteLine("Please run this application using SQL Server Profiler...");
            Console.ReadLine();
        }
    }
}
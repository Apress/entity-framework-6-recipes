using System;
using System.Data.Entity;
using System.Threading.Tasks;

namespace AsyncEntityFramework
{
    internal class Program
    {
        private static void Main()
        {
            Cleanup().Wait();
            LoadData().Wait();
            RunExample().Wait();
        }

        private static async Task Cleanup()
        {
            using (var context = new Recipe15Context())
            {
                await context.Database.ExecuteSqlCommandAsync("delete from chapter5.event");
                await context.Database.ExecuteSqlCommandAsync("delete from chapter5.club");
            }
        }

        private static async Task LoadData()
        {
            using (var context = new Recipe15Context())
            {
                var club = new Club {Name = "Star City Chess Club", City = "New York"};
                club.Events.Add(new Event
                    {
                        EventName = "Mid Cities Tournament",
                        EventDate = DateTime.Parse("1/09/2010"),
                        Club = club
                    });
                club.Events.Add(new Event
                    {
                        EventName = "State Finals Tournament",
                        EventDate = DateTime.Parse("2/12/2010"),
                        Club = club
                    });
                club.Events.Add(new Event
                    {
                        EventName = "Winter Classic",
                        EventDate = DateTime.Parse("12/18/2009"),
                        Club = club
                    });

                var club2 = new Club {Name = "Beach Front Chess Club", City = "Los Angeles"};
                club2.Events.Add(new Event
                    {
                        EventName = "Freeway Tournament",
                        EventDate = DateTime.Parse("1/09/2010"),
                        Club = club2
                    });
                club2.Events.Add(new Event
                    {
                        EventName = "Hollywood Bowl Tournament",
                        EventDate = DateTime.Parse("2/12/2010"),
                        Club = club2
                    });

                context.Clubs.Add(club);
                context.Clubs.Add(club2);

                //context.SaveChanges();
                await context.SaveChangesAsync();
            }
        }

        private static async Task RunExample()
        {
            using (var context = new Recipe15Context())
            {
                Console.WriteLine("Async Call");
                Console.WriteLine("=========");

                await context.Clubs.Include(x => x.Events).ForEachAsync(x =>
                    {
                        Console.WriteLine("\nHere are the events for Club {0}:", x.Name);

                        foreach (var clubEvent in x.Events)
                        {
                            Console.WriteLine("\t{0}", clubEvent.EventName);
                        }
                    });
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
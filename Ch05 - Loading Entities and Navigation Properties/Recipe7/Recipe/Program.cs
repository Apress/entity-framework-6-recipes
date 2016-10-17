using System;
using System.Data.Entity;
using System.Linq;

namespace Recipe7
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
            using (var context = new Recipe7Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.event");
                context.Database.ExecuteSqlCommand("delete from chapter5.club");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe7Context())
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

                context.Clubs.Add(club);

                context.SaveChanges();
            }

            using (var context = new Recipe7Context())
            {
                var events = from ev in context.Events
                             where ev.Club.City == "New York"
                             group ev by ev.Club
                             into g
                             select g.FirstOrDefault(e1 => e1.EventDate == g.Min(evt => evt.EventDate));

                var eventWithClub = events.Include("Club").First();

                Console.WriteLine("The next New York club event is:");
                Console.WriteLine("\tEvent: {0}", eventWithClub.EventName);
                Console.WriteLine("\tDate: {0}", eventWithClub.EventDate.ToShortDateString());
                Console.WriteLine("\tClub: {0}", eventWithClub.Club.Name);
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
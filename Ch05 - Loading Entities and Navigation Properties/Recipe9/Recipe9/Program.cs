using System;
using System.Data.Entity;
using System.Linq;

namespace Recipe6
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
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.reservation");
                context.Database.ExecuteSqlCommand("delete from chapter5.executivesuite");
                context.Database.ExecuteSqlCommand("delete from chapter5.room");
                context.Database.ExecuteSqlCommand("delete from chapter5.hotel");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var hotel = new Hotel {Name = "Grand Seasons Hotel"};
                var r101 = new Room {Rate = 79.95M, Hotel = hotel};
                var es201 = new ExecutiveSuite {Rate = 179.95M, Hotel = hotel};
                var es301 = new ExecutiveSuite {Rate = 299.95M, Hotel = hotel};

                var res1 = new Reservation
                    {
                        StartDate = DateTime.Parse("3/12/2010"),
                        EndDate = DateTime.Parse("3/14/2010"),
                        ContactName = "Roberta Jones",
                        Room = es301
                    };
                var res2 = new Reservation
                    {
                        StartDate = DateTime.Parse("1/18/2010"),
                        EndDate = DateTime.Parse("1/28/2010"),
                        ContactName = "Bill Meyers",
                        Room = es301
                    };
                var res3 = new Reservation
                    {
                        StartDate = DateTime.Parse("2/5/2010"),
                        EndDate = DateTime.Parse("2/6/2010"),
                        ContactName = "Robin Rosen",
                        Room = r101
                    };

                es301.Reservations.Add(res1);
                es301.Reservations.Add(res2);
                r101.Reservations.Add(res3);

                hotel.Rooms.Add(r101);
                hotel.Rooms.Add(es201);
                hotel.Rooms.Add(es301);

                context.Hotels.Add(hotel);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // Assume we have an instance of hotel
                var hotel = context.Hotels.First();

                // Explicit loading with Load() provides opportunity to filter related data 
                // obtained from the Include() method 
                context.Entry(hotel)
                       .Collection(x => x.Rooms)
                       .Query()
                       .Include(y => y.Reservations)
                       .Where(y => y is ExecutiveSuite && y.Reservations.Any())
                       .Load();

                Console.WriteLine("Executive Suites for {0} with reservations", hotel.Name);

                foreach (var room in hotel.Rooms)
                {
                    Console.WriteLine("\nExecutive Suite {0} is {1} per night", room.RoomId,
                                      room.Rate.ToString("C"));
                    Console.WriteLine("Current reservations are:");
                    foreach (var res in room.Reservations.OrderBy(r => r.StartDate))
                    {
                        Console.WriteLine("\t{0} thru {1} ({2})", res.StartDate.ToShortDateString(),
                                          res.EndDate.ToShortDateString(), res.ContactName);
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
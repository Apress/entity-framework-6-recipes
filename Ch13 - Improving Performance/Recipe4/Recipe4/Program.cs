using System;
using System.Linq;

namespace Recipe4
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
            using (var context = new Recipe4Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter13.reservation");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe4Context())
            {
                context.Reservations.Add(new Reservation {Name = "James Jordan", ResDate = DateTime.Parse("4/18/10")});
                context.Reservations.Add(new Reservation {Name = "Katie Marlowe", ResDate = DateTime.Parse("3/22/10")});
                context.Reservations.Add(new Reservation {Name = "Roger Smith", ResDate = DateTime.Parse("4/18/10")});
                context.Reservations.Add(new Reservation {Name = "James Jordan", ResDate = DateTime.Parse("5/12/10")});
                context.Reservations.Add(new Reservation {Name = "James Jordan", ResDate = DateTime.Parse("6/22/10")});
                context.SaveChanges();
            }

            using (var context = new Recipe4Context())
            {
                DateTime? searchDate = null;
                var searchName = "James Jordan";

                Console.WriteLine("More complex SQL...");
                var query2 = from reservation in context.Reservations
                    let dateMatches = searchDate == null || reservation.ResDate == searchDate
                    let nameMatches = searchName == string.Empty || reservation.Name.Contains(searchName)
                    where dateMatches && nameMatches
                    select reservation;
                foreach (var reservation in query2)
                {
                    Console.WriteLine("Found reservation for {0} on {1}", reservation.Name,
                        reservation.ResDate.ToShortDateString());
                }

                Console.WriteLine("Cleaner SQL...");
                var query1 = from reservation in context.Reservations
                    where (searchDate == null || reservation.ResDate == searchDate)
                          &&
                          (searchName == string.Empty || reservation.Name.Contains(searchName))
                    select reservation;
                foreach (var reservation in query1)
                {
                    Console.WriteLine("Found reservation for {0} on {1}", reservation.Name,
                        reservation.ResDate.ToShortDateString());
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
using System;
using System.Data.Entity;
using System.Linq;

namespace Recipe3_13
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.registration");
                // add new test data
                context.Registrations.Add(new Registration
                {
                    StudentName = "Jill Rogers",
                    RegistrationDate = DateTime.Parse("12/03/2009 9:30 pm")
                });
                context.Registrations.Add(new Registration
                {
                    StudentName = "Steven Combs",
                    RegistrationDate = DateTime.Parse("12/03/2009 10:45 am")
                });
                context.Registrations.Add(new Registration
                {
                    StudentName = "Robin Rosen",
                    RegistrationDate = DateTime.Parse("12/04/2009 11:18 am")
                });
                context.Registrations.Add(new Registration
                {
                    StudentName = "Allen Smith",
                    RegistrationDate = DateTime.Parse("12/04/2009 3:31 pm")
                });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var groups = from r in context.Registrations
                             // leverage built-in TruncateTime function tp extract date portion 
                             group r by DbFunctions.TruncateTime(r.RegistrationDate)
                                 into g
                                 select g;
                foreach (var element in groups)
                {
                    Console.WriteLine("\nRegistrations for {0}",
                           ((DateTime)element.Key).ToShortDateString());
                    foreach (var registration in element)
                    {
                        Console.WriteLine("\t{0}", registration.StudentName);
                    }
                }
            }
            
            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}

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
                context.Database.ExecuteSqlCommand("delete from chapter13.appointment");
                context.Database.ExecuteSqlCommand("delete from chapter13.doctor");
                context.Database.ExecuteSqlCommand("delete from chapter13.company");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe3Context())
            {
                var company = new Company {Name = "Paola Heart Center"};
                var doc1 = new Doctor {Name = "Jill Mathers", Company = company};
                var doc2 = new Doctor {Name = "Robert Stevens", Company = company};
                var app1 = new Appointment
                {
                    AppointmentDate = DateTime.Parse("3/18/2010"),
                    Patient = "Karen Rodgers",
                    Doctor = doc1
                };
                var app2 = new Appointment
                {
                    AppointmentDate = DateTime.Parse("3/20/2010"),
                    Patient = "Steven Cook",
                    Doctor = doc2
                };
                context.Doctors.Add(doc1);
                context.Doctors.Add(doc2);
                context.Appointments.Add(app1);
                context.Appointments.Add(app2);
                context.Companies.Add(company);
                context.SaveChanges();
            }

            using (var context = new Recipe3Context())
            {
                Console.WriteLine("Entities tracked in context for Doctors...");

                // execute query using the AsNoTracking() method
                context.Doctors.Include("Company").AsNoTracking().ToList();
                
                Console.WriteLine("Number of entities loaded into context with AsNoTracking: {0}", 
                    context.ChangeTracker.Entries().Count());

                // execute query without the AsNoTracking() method
                context.Doctors.Include("Company").ToList();

                Console.WriteLine("Number of entities loaded into context without AsNoTracking: {0}",
                    context.ChangeTracker.Entries().Count());
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
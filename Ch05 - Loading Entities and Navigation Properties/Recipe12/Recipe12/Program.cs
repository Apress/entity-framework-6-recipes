using System;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
//using System.Data.Objects;
using System.Runtime.Remoting.Contexts;

namespace Recipe12
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
                context.Database.ExecuteSqlCommand("delete from chapter5.appointment");
                context.Database.ExecuteSqlCommand("delete from chapter5.doctor");
                context.Database.ExecuteSqlCommand("delete from chapter5.patient");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var doc1 = new Doctor {Name = "Joan Meyers"};
                var doc2 = new Doctor {Name = "Steven Mills"};
                var pat1 = new Patient {Name = "Bill Rivers"};
                var pat2 = new Patient {Name = "Susan Stevenson"};
                var pat3 = new Patient {Name = "Roland Marcy"};

                var app1 = new Appointment
                    {
                        Date = DateTime.Today,
                        Doctor = doc1,
                        Fee = 109.92M,
                        Patient = pat1,
                        Reason = "Checkup"
                    };
                var app2 = new Appointment
                    {
                        Date = DateTime.Today,
                        Doctor = doc2,
                        Fee = 129.87M,
                        Patient = pat2,
                        Reason = "Arm Pain"
                    };
                var app3 = new Appointment
                    {
                        Date = DateTime.Today,
                        Doctor = doc1,
                        Fee = 99.23M,
                        Patient = pat3,
                        Reason = "Back Pain"
                    };

                context.Appointments.Add(app1);
                context.Appointments.Add(app2);
                context.Appointments.Add(app3);

                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // disable lazy-loading feature as we are explicitly loading 
                // child entities
                context.Configuration.LazyLoadingEnabled = false;
                
                var doctorJoan = context.Doctors.First(o => o.Name == "Joan Meyers");

                if (!context.Entry(doctorJoan).Collection(x => x.Appointments).IsLoaded)
                {
                    context.Entry(doctorJoan).Collection(x => x.Appointments).Load();
                    Console.WriteLine("Dr. {0}'s appointments were explicitly loaded.",
                                      doctorJoan.Name);
                }

                Console.WriteLine("Dr. {0} has {1} appointment(s).",
                                  doctorJoan.Name,
                                  doctorJoan.Appointments.Count());

                foreach (var appointment in context.Appointments)
                {
                    if (!context.Entry(appointment).Reference(x => x.Doctor).IsLoaded)
                    {
                        context.Entry(appointment).Reference(x => x.Doctor).Load();
                        Console.WriteLine("Dr. {0} was explicitly loaded.",
                                          appointment.Doctor.Name);
                    }
                    else
                        Console.WriteLine("Dr. {0} was already loaded.",
                                          appointment.Doctor.Name);
                }

                Console.WriteLine("There are {0} appointments for Dr. {1}",
                                  doctorJoan.Appointments.Count(),
                                  doctorJoan.Name);

                doctorJoan.Appointments.Clear();

                Console.WriteLine("Collection clear()'ed");
                Console.WriteLine("There are now {0} appointments for Dr. {1}",
                                  doctorJoan.Appointments.Count(),
                                  doctorJoan.Name);

                context.Entry(doctorJoan).Collection(x => x.Appointments).Load();

                Console.WriteLine("Collection loaded()'ed");

                Console.WriteLine("There are now {0} appointments for Dr. {1}",
                                  doctorJoan.Appointments.Count().ToString(),
                                  doctorJoan.Name);

                // Currently, there isn't an easy way to refresh entities with the DbContext API.
                // Instead, drop-down into the ObjectContext and perform the following actions
                var objectContext = ((IObjectContextAdapter) context).ObjectContext;
                var objectSet = objectContext.CreateObjectSet<Appointment>();
                objectSet.MergeOption = MergeOption.OverwriteChanges;
                objectSet.Load();

                Console.WriteLine("Collection loaded()'ed with MergeOption.OverwriteChanges");

                Console.WriteLine("There are now {0} appointments for Dr. {1}",
                                  doctorJoan.Appointments.Count(),
                                  doctorJoan.Name);
            }

            // Demonstrating loading part of the collection then Load()'ing the rest
            using (var context = new EFRecipesEntities())
            {
                // disable lazy-loading feature as we are explicitly loading 
                // child entities
                context.Configuration.LazyLoadingEnabled = false;

                // Load the first doctor and attach just the first appointment
                var doctorJoan = context.Doctors.First(o => o.Name == "Joan Meyers");

                context.Entry(doctorJoan).Collection(x => x.Appointments).Query().Take(1).Load();

                // note that IsLoaded returns false here since all related data has not been loaded into the context
                var appointmentsLoaded = context.Entry(doctorJoan).Collection(x => x.Appointments).IsLoaded;

                Console.WriteLine("Dr. {0} has {1} appointments loaded.",
                                  doctorJoan.Name,
                                  doctorJoan.Appointments.Count());

                // When we need all of the remaining appointments, simply Load() them
                context.Entry(doctorJoan).Collection(x => x.Appointments).Load();
                Console.WriteLine("Dr. {0} has {1} appointments loaded.",
                                  doctorJoan.Name,
                                  doctorJoan.Appointments.Count());
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
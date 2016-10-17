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
                context.Database.ExecuteSqlCommand("delete from chapter5.plumber");
                context.Database.ExecuteSqlCommand("delete from chapter5.foreman");
                context.Database.ExecuteSqlCommand("delete from chapter5.jobsite");
                context.Database.ExecuteSqlCommand("delete from chapter5.location");
                context.Database.ExecuteSqlCommand("delete from chapter5.tradesman");
                context.Database.ExecuteSqlCommand("delete from chapter5.phone");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var foreman1 = new Foreman {Name = "Carl Ramsey"};
                var foreman2 = new Foreman {Name = "Nancy Ortega"};
                var phone = new Phone {Number = "817 867-5309"};
                var jobsite = new JobSite
                    {
                        JobSiteName = "City Arena",
                        Address = "123 Main",
                        City = "Anytown",
                        State = "TX",
                        ZIPCode = "76082",
                        Phone = phone
                    };
                jobsite.Foremen.Add(foreman1);
                jobsite.Foremen.Add(foreman2);
                var plumber = new Plumber {Name = "Jill Nichols", Email = "JNichols@plumbers.com", JobSite = jobsite};
                context.Tradesmen.Add(plumber);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var plumber =
                    context.Tradesmen.OfType<Plumber>().Include("JobSite.Phone").Include("JobSite.Foremen").First();
                Console.WriteLine("Plumber's Name: {0} ({1})", plumber.Name, plumber.Email);
                Console.WriteLine("Job Site: {0}", plumber.JobSite.JobSiteName);
                Console.WriteLine("Job Site Phone: {0}", plumber.JobSite.Phone.Number);
                Console.WriteLine("Job Site Foremen:");
                foreach (var boss in plumber.JobSite.Foremen)
                {
                    Console.WriteLine("\t{0}", boss.Name);
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
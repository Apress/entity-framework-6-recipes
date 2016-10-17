using System;
using System.Linq;

namespace Recipe3_9
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.accident");
                context.Database.ExecuteSqlCommand("delete from chapter3.worker");
                // add new test data
                var worker1 = new Worker { Name = "John Kearney" };
                var worker2 = new Worker { Name = "Nancy Roberts" };
                var worker3 = new Worker { Name = "Karla Gibbons" };
                context.Accidents.Add(new Accident
                {
                    Description = "Cuts and contusions",
                    Severity = 3,
                    Worker = worker1
                });
                context.Accidents.Add(new Accident
                {
                    Description = "Broken foot",
                    Severity = 4,
                    Worker = worker1
                });
                context.Accidents.Add(new Accident
                {
                    Description = "Fall, no injuries",
                    Severity = 1,
                    Worker = worker2
                });
                context.Accidents.Add(new Accident
                {
                    Description = "Minor burn",
                    Severity = 3,
                    Worker = worker2
                });
                context.Accidents.Add(new Accident
                {
                    Description = "Back strain",
                    Severity = 2,
                    Worker = worker3
                });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // explicitly disable lazy loading
                context.Configuration.LazyLoadingEnabled = false;
                var query = from w in context.Workers
                            select new
                            {
                                Worker = w,
                                Accidents = w.Accidents.Where(a => a.Severity > 2)
                            };
                query.ToList();
                var workers = query.Select(r => r.Worker);
                Console.WriteLine("Workers with serious accidents...");
                foreach (var worker in workers)
                {
                    Console.WriteLine("{0} had the following accidents", worker.Name);
                    if (worker.Accidents.Count == 0)
                        Console.WriteLine("\t--None--");
                    foreach (var accident in worker.Accidents)
                    {
                        Console.WriteLine("\t{0}, severity: {1}",
                              accident.Description, accident.Severity.ToString());
                    }
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}

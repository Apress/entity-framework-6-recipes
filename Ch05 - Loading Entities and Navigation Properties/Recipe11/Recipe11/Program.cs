using System;
using System.Linq;

namespace Recipe11
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
            using (var context = new Recipe11Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.contractor");
                context.Database.ExecuteSqlCommand("delete from chapter5.project");
                context.Database.ExecuteSqlCommand("delete from chapter5.manager");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe11Context())
            {
                var man1 = new Manager {Name = "Jill Stevens"};
                var proj = new Project {Name = "City Riverfront Park", Manager = man1};
                var con1 = new Contractor {Name = "Robert Alvert", Project = proj};
                var con2 = new Contractor {Name = "Alan Jones", Project = proj};
                var con3 = new Contractor {Name = "Nancy Roberts", Project = proj};
                context.Projects.Add(proj);
                context.SaveChanges();
            }

            using (var context = new Recipe11Context())
            {
                var project = context.Projects.Include("Manager").First();

                if (context.Entry(project).Reference(x => x.Manager).IsLoaded)
                    Console.WriteLine("Manager entity is loaded.");
                else
                    Console.WriteLine("Manager entity is NOT loaded.");

                if (context.Entry(project).Collection(x => x.Contractors).IsLoaded)
                    Console.WriteLine("Contractors are loaded.");
                else
                    Console.WriteLine("Contractors are NOT loaded.");
                Console.WriteLine("Calling project.Contractors.Load()...");

                context.Entry(project).Collection(x => x.Contractors).Load();

                if (context.Entry(project).Collection(x => x.Contractors).IsLoaded)
                    Console.WriteLine("Contractors are now loaded.");
                else
                    Console.WriteLine("Contractors failed to load.");
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
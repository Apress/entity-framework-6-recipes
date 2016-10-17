using System;
using System.Linq;

namespace Recipe1
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
                context.Database.ExecuteSqlCommand("delete from chapter13.hourlyemployee");
                context.Database.ExecuteSqlCommand("delete from chapter13.salariedemployee");
                context.Database.ExecuteSqlCommand("delete from chapter13.employee");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Employees.Add(new SalariedEmployee {Name = "Robin Rosen", Salary = 89900M});
                context.Employees.Add(new HourlyEmployee {Name = "Steven Fuller", Rate = 11.50M});
                context.Employees.Add(new HourlyEmployee {Name = "Karen Steele", Rate = 12.95m});
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // a typical way to get Steven Fuller's entity
                var emp1 = context.Employees.Single(e => e.Name == "Steven Fuller");
                Console.WriteLine("{0}'s rate is: {1} per hour", emp1.Name, ((HourlyEmployee) emp1).Rate.ToString("C"));

                // slightly more efficient way if we know that Steven is an HourlyEmployee
                var emp2 = context.Employees.OfType<HourlyEmployee>().Single(e => e.Name == "Steven Fuller");
                Console.WriteLine("{0}'s rate is: {1} per hour", emp2.Name, emp2.Rate.ToString("C"));
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
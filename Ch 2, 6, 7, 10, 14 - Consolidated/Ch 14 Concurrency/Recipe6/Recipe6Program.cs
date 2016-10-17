using System;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Apress.EF6Recipes.Concurrency.Recipe6
{
    public static class Recipe6Program
    {
        public static void Run()
        {
            using (var context = new Recipe6Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.Student");
                context.Database.ExecuteSqlCommand("delete from chapter14.Instructor");
                context.SaveChanges();
            }

            using (var context = new Recipe6Context())
            {
                var student = new Student
                {
                    Name = "Joan Williams",
                    EnrollmentDate = DateTime.Parse("1/12/2010")
                };
                var instructor = new Instructor
                {
                    Name = "Rodger Keller",
                    HireDate = DateTime.Parse("7/14/1992")
                };
                context.People.Add(student);
                context.People.Add(instructor);
                context.SaveChanges();
            }

            using (var context = new Recipe6Context())
            {
                // find the student and update the enrollment date
                var student = context.People.OfType<Student>()
                    .First(s => s.Name == "Joan Williams");
                Console.WriteLine("Updating {0}'s enrollment date", student.Name);

                // out-of-band update occurs
                Console.WriteLine("[Apply rogue update]");
                context.Database.ExecuteSqlCommand(@"update chapter14.person set name = 'Joan Smith'
          where personId = 
          (select personId from chapter14.person where name = 'Joan Williams')");

                // change the enrollment date
                student.EnrollmentDate = DateTime.Parse("5/2/2010");
                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    Console.WriteLine("Exception: {0}", ex.Message);
                }
            }
        }
    }
}
using System;
using System.Data.Entity.Core.Objects;
using System.Linq;

namespace Recipe7
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
                context.Database.ExecuteSqlCommand("delete from chapter13.resume");
            }
        }

        private static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var r1 = new Resume
                {
                    Title = "C# Developer",
                    Name = "Sally Jones",
                    Body = "...very long resume goes here..."
                };
                context.Resumes.Add(r1);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // using SqlQuery()
                var result1 =
                    context.Resumes.SqlQuery("select ResumeId, Title, Name,'' Body from chapter13.Resume",
                        "Resumes", MergeOption.AppendOnly).Single();
                Console.WriteLine("Resume body: {0}", result1.Body);

                var result2 =
                    context.Database.SqlQuery<Resume>("select * from chapter13.Resume", "Resumes",
                        MergeOption.OverwriteChanges).Single();
                Console.WriteLine("Resume body: {0}", result2.Body);
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
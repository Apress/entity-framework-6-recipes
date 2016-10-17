    using System;
using System.Data.Common;
using System.Data.SqlClient;

namespace Recipe3_3
{
    internal class Program
    {
        private static void Main()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.student");

                // insert student data
                context.Students.Add(new Student
                    {
                        FirstName = "Robert",
                        LastName = "Smith",
                        Degree = "Masters"
                    });
                context.Students.Add(new Student
                    {
                        FirstName = "Julia",
                        LastName = "Kerns",
                        Degree = "Masters"
                    });
                context.Students.Add(new Student
                    {
                        FirstName = "Nancy",
                        LastName = "Stiles",
                        Degree = "Doctorate"
                    });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var sql = "select * from Chapter3.Student where Degree = @Major";
                var parameters = new DbParameter[]
                    {
                        new SqlParameter {ParameterName = "Major", Value = "Masters"}
                    };
                var students = context.Database.SqlQuery<Student>(sql, parameters);
                Console.WriteLine("Students...");
                foreach (var student in students)
                {
                    Console.WriteLine("{0} {1} is working on a {2} degree",
                                      student.FirstName, student.LastName, student.Degree);
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
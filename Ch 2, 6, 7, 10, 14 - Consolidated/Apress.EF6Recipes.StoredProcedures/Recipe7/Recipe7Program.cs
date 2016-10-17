using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe7
{
    public static class Recipe7Program
    {
        public static void Run()
        {
            using (var context = new Recipe7Context())
            {
                context.People.Add(new Instructor
                {
                    Name = "Karen Stanford",
                    Salary = 62500M
                });
                context.People.Add(new Instructor
                {
                    Name = "Robert Morris",
                    Salary = 61800M
                });
                context.People.Add(new Student
                {
                    Name = "Jill Mathers",
                    Degree = "Computer Science"
                });
                context.People.Add(new Student
                {
                    Name = "Steven Kennedy",
                    Degree = "Math"
                });
                context.SaveChanges();
            }

            using (var context = new Recipe7Context())
            {
                Console.WriteLine("Instructors and Students");
                var allPeople = context.GetAllPeople();
                foreach (var person in allPeople)
                {
                    if (person is Instructor)
                        Console.WriteLine("Instructor {0} makes {1:C}/year",
                                            person.Name,
                                            ((Instructor)person).Salary);
                    else if (person is Student)
                        Console.WriteLine("Student {0}'s major is {1}",
                                            person.Name, ((Student)person).Degree);
                }
            }
            
        }
    }
}

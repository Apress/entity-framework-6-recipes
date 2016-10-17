using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe4
{
    public static class Recipe4Program
    {
        public static void Run()
        {
            using (var context = new Recipe4Context())
            {
                var teacher = new Teacher
                {
                    Name = "Susan Smith",
                    School = "Custer Baker Middle School"
                };
                var firefighter = new Firefighter
                {
                    Name = "Joel Clark",
                    FireStation = "Midtown"
                };
                var retired = new Retired
                {
                    Name = "Joan Collins",
                    FullTimeHobby = "Scapbooking"
                };
                context.People.Add(teacher);
                context.People.Add(firefighter);
                context.People.Add(retired);
                context.SaveChanges();
                firefighter.Hero = teacher;
                teacher.Hero = retired;
                retired.Hero = firefighter;
                context.SaveChanges();
            }

            using (var context = new Recipe4Context())
            {
                foreach (var person in context.People)
                {
                    if (person.Hero != null)
                        Console.WriteLine("\n{0}, Hero is: {1}", person.Name,
                                            person.Hero.Name);
                    else
                        Console.WriteLine("{0}", person.Name);
                    if (person is Firefighter)
                        Console.WriteLine("Firefighter at station {0}",
                                           ((Firefighter)person).FireStation);
                    else if (person is Teacher)
                        Console.WriteLine("Teacher at {0}", ((Teacher)person).School);
                    else if (person is Retired)
                        Console.WriteLine("Retired, hobby is {0}",
                                           ((Retired)person).FullTimeHobby);
                    Console.WriteLine("Fans:");
                    foreach (var fan in person.Fans)
                    {
                        Console.WriteLine("\t{0}", fan.Name);
                    }
                }
            }
            
        }
    }
}

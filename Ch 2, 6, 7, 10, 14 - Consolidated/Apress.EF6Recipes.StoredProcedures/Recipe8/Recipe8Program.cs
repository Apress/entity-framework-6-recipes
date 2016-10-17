using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe8
{
    public static class Recipe8Program
    {
        public static void Run()
        {
            using (var context = new Recipe8Context())
            {
                context.Athletes.Add(new Athlete
                {
                    Name = "Nancy Steward",
                    Height = 167,
                    Weight = 53
                });
                context.Athletes.Add(new Athlete
                {
                    Name = "Rob Achers",
                    Height = 170,
                    Weight = 77
                });
                context.Athletes.Add(new Athlete
                {
                    Name = "Chuck Sanders",
                    Height = 171,
                    Weight = 82
                });
                context.Athletes.Add(new Athlete
                {
                    Name = "Nancy Rodgers",
                    Height = 166,
                    Weight = 59
                });
                context.SaveChanges();
            }
            using (var context = new Recipe8Context())
            {
                // do a delete and an update
                var all = context.Athletes;
                context.Athletes.Remove(all.First(o => o.Name == "Nancy Steward"));
                all.First(o => o.Name == "Rob Achers").Weight = 80;
                context.SaveChanges();
            }

            using (var context = new Recipe8Context())
            {
                Console.WriteLine("All Athletes");
                Console.WriteLine("============");
                foreach (var athlete in context.Athletes)
                {
                    Console.WriteLine("{0} weighs {1} Kg and is {2} cm in height",
                     athlete.Name, athlete.Weight, athlete.Height);
                }
            }
            
        }
    }
}

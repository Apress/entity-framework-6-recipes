using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe11
{
    public static class Recipe11Program
    {
        public static void Run()
        {
            using (var context = new Recipe11Context())
            {
                var teen = new Teen
                {
                    Name = "Steven Keller",
                    Age = 17,
                    Phone = "817 867-5309"
                };
                var adult = new Adult
                {
                    Name = "Margret Jones",
                    Age = 53,
                    Phone = "913 294-6059"
                };
                var senior = new Senior
                {
                    Name = "Roland Park",
                    Age = 71,
                    Phone = "816 353-4458"
                };
                context.Members.Add(teen);
                context.Members.Add(adult);
                context.Members.Add(senior);
                context.SaveChanges();
            }

            using (var context = new Recipe11Context())
            {
                Console.WriteLine("Club Members");
                Console.WriteLine("============");
                foreach (var member in context.Members)
                {
                    bool printPhone = true;
                    string str = string.Empty;
                    if (member is Teen)
                    {
                        str = " a Teen";
                        printPhone = false;
                    }
                    else if (member is Adult)
                        str = "an Adult";
                    else if (member is Senior)
                        str = "a Senior";
                    Console.WriteLine("{0} is {1} member, phone: {2}", member.Name,
                                       str, printPhone ? member.Phone : "unavailable");
                }
            }
            
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe6
{
    public static class Recipe6Program
    {
        public static void Run()
        {
            using (var context = new Recipe6Context())
            {
                context.Media.Add(new Magazine { Title = "Field and Stream",
                                    PublicationDate = DateTime.Parse("6/12/1945") });
                context.Media.Add(new Magazine { Title = "National Geographic",
                                    PublicationDate = DateTime.Parse("7/15/1976") });
                context.Media.Add(new DVD { Title = "Harmony Road", 
                                    PlayTime = "2 hours, 30 minutes" });
                context.SaveChanges();
            }

            using (var context = new Recipe6Context())
            {
                var allMedia = context.GetAllMedia();
                Console.WriteLine("All Media");
                Console.WriteLine("=========");
                foreach (var m in allMedia)
                {
                    if (m is Magazine)
                        Console.WriteLine("{0} Published: {1}", m.Title,
                                        ((Magazine)m).PublicationDate.ToShortDateString());
                    else if (m is DVD)
                        Console.WriteLine("{0} Play Time: {1}", m.Title, ((DVD)m).PlayTime);
                }
            }
            
        }
    }
}

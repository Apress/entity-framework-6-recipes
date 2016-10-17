using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe6
{
    public static class Recipe6Program
    {
        public static void Run()
        {
            using (var context = new Recipe6Context())
            { 
                var exDrug1 = new Experimental { Name = "Nanoxol", 
                                       PrincipalResearcher = "Dr. Susan James" };
                var exDrug2 = new Experimental { Name = "Percosol", 
                                       PrincipalResearcher = "Dr. Bill Minor" };
                context.Drugs.Add(exDrug1);
                context.Drugs.Add(exDrug2);
                context.SaveChanges();

                // Nanoxol just got approved!
                exDrug1.PromoteToMedicine(DateTime.Now, 19.99M, "Treatall");
                context.Entry(exDrug1).State = EntityState.Detached; // better not use this instance any longer
            }

            using (var context = new Recipe6Context())
            {
                Console.WriteLine("Experimental Drugs");
                foreach (var d in context.Drugs.OfType<Experimental>())
                {
                    Console.WriteLine("\t{0} ({1})", d.Name, d.PrincipalResearcher);
                }

                Console.WriteLine("Medicines");
                foreach (var d in context.Drugs.OfType<Medicine>())
                {
                    Console.WriteLine("\t{0} Retails for {1}", d.Name,
                                       d.TargetPrice.Value.ToString("C"));
                }
            }
            
        }
    }
}

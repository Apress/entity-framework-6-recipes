using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe5
{
    public static class Recipe5Program
    {
        public static void Run()
        {
            using (var context = new Recipe5Context())
            {
                var tech1 = new Technician { Name = "Julie Kerns" };
                var tech2 = new Technician { Name = "Robert Allison" };
                context.ServiceCalls.Add(new ServiceCall
                {
                    ContactName = "Robin Rosen",
                    Issue = "Can't get satellite signal.",
                    Technician = tech1
                });
                context.ServiceCalls.Add(new ServiceCall
                {
                    ContactName = "Phillip Marlowe",
                    Issue = "Channel not available",
                    Technician = tech2
                });

                // now get the entities we've added
                foreach (var tech in
                         context.ChangeTracker.GetEntities<Technician>())
                {
                    Console.WriteLine("Technician: {0}", tech.Name);
                    foreach (var call in tech.ServiceCalls)
                    {
                        Console.WriteLine("\tService Call: Contact {0} about {1}",
                                           call.ContactName, call.Issue);
                    }
                }
            }
            
        }
    }
}

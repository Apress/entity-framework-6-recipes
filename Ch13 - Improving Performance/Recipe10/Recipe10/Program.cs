using System;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe10
{
    class Program
    {
        static void Main()
        {
            Cleanup();
            RunExample();
        }

        static void Cleanup()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter13.track");
                context.Database.ExecuteSqlCommand("delete from chapter13.cd");
            }
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var cd1 = context.CDs.Create<CD>();
                cd1.Title = "Abbey Road";
                cd1.Tracks.Add(new Track { Title = "Come Together", Artist = "The Beatles" });
                var cd2 = context.CDs.Create<CD>();
                cd2.Title = "Cowboy Town";
                cd2.Tracks.Add(new Track { Title = "Cowgirls Don't Cry", Artist = "Brooks & Dunn" });
                var cd3 = context.CDs.Create<CD>();
                cd3.Title = "Long Black Train";
                cd3.Tracks.Add(new Track { Title = "In My Dreams", Artist = "Josh Turner" });
                cd3.Tracks.Add(new Track { Title = "Jacksonville", Artist = "Josh Turner" });
                context.CDs.Add(cd1);
                context.CDs.Add(cd2);
                context.CDs.Add(cd3);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                // to trigger proxy generation we need to drop-down into the underlying
                // ObjectContext object as DbContext does not expose the CreateProxyTypes() method 
                var objectContext = ((IObjectContextAdapter) context).ObjectContext;
                objectContext.CreateProxyTypes(new Type[] { typeof(CD), typeof(Track) });

                var proxyTypes = ObjectContext.GetKnownProxyTypes();
                Console.WriteLine("{0} proxies generated!", ObjectContext.GetKnownProxyTypes().Count());

                var cds = context.CDs.Include("Tracks");
                foreach (var cd in cds)
                {
                    Console.WriteLine("Album: {0}", cd.Title);
                    foreach (var track in cd.Tracks)
                    {
                        Console.WriteLine("\t{0} by {1}", track.Title, track.Artist);
                    }
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}

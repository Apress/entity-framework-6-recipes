using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Diagnostics;
using System.Linq;

namespace Recipe6
{
    internal class Program
    {
        private static void Main()
        {
            Cleanup();
            LoadData();
            RunUncompiledQuery();
            RunCompiledQuery();

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }

        private static void Cleanup()
        {
            using (var context = new Recipe6())
            {
                context.Database.ExecuteSqlCommand("delete from chapter13.paycheck");
                context.Database.ExecuteSqlCommand("delete from chapter13.associate");
            }
        }

        private static void LoadData()
        {
            using (var context = new Recipe6())
            {
                var a1 = new Associate {Name = "Robert Stevens", City = "Raytown"};
                a1.Paychecks.Add(new Paycheck {PayDate = DateTime.Parse("3/1/10"), Gross = 1802.83M});
                a1.Paychecks.Add(new Paycheck {PayDate = DateTime.Parse("3/15/10"), Gross = 1924.91M});
                var a2 = new Associate {Name = "Karen Thorp", City = "Gladstone"};
                a2.Paychecks.Add(new Paycheck {PayDate = DateTime.Parse("3/1/10"), Gross = 2102.34M});
                a2.Paychecks.Add(new Paycheck {PayDate = DateTime.Parse("3/15/10"), Gross = 1992.18M});
                context.Associates.Add(a1);
                context.Associates.Add(a2);
                context.SaveChanges();
            }
        }

        private static void RunUncompiledQuery()
        {
            using (var context = new Recipe6())
            {
                // Explicitly disable query plan caching
                var objectContext = ((IObjectContextAdapter) context).ObjectContext;
                var associateNoCache = objectContext.CreateObjectSet<Associate>();
                associateNoCache.EnablePlanCaching = false;

                var watch = new Stopwatch();
                long totalTicks = 0;

                // warm things up
                associateNoCache.Include(x => x.Paychecks).Where(a => a.Name.StartsWith("Karen")).ToList();

                // query gets compiled each time
                for (var i = 0; i < 10; i++)
                {
                    watch.Restart();
                    associateNoCache.Include(x => x.Paychecks).Where(a => a.Name.StartsWith("Karen")).ToList();
                    watch.Stop();
                    totalTicks += watch.ElapsedTicks;
                    Console.WriteLine("Not Compiled #{0}: {1}", i, watch.ElapsedTicks);
                }
                Console.WriteLine("Average ticks without compiling: {0}", (totalTicks/10));
                Console.WriteLine("");
            }
        }

        private static void RunCompiledQuery()
        {
            using (var context = new Recipe6())
            {
                var watch = new Stopwatch();
                long totalTicks = 0;

                // warm things up
                context.Associates.Include(x => x.Paychecks).Where(a => a.Name.StartsWith("Karen")).ToList();

                totalTicks = 0;
                for (var i = 0; i < 10; i++)
                {
                    watch.Restart();
                    context.Associates.Include(x => x.Paychecks).Where(a => a.Name.StartsWith("Karen")).ToList();
                    watch.Stop();
                    totalTicks += watch.ElapsedTicks;
                    Console.WriteLine("Compiled #{0}: {1}", i, watch.ElapsedTicks);
                }
                Console.WriteLine("Average ticks with compiling: {0}", (totalTicks/10));
            }
        }
    }
}
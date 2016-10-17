using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe2
{
    public static class Recipe2Program
    {
        public static void Run()
        {
            using (var context = new Recipe2Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.Agent");
                context.SaveChanges();
            }
            
            using (var context = new Recipe2Context())
            {
                context.Agents.Add(new Agent
                {
                    Name = "Phillip Marlowe",
                    Phone = "202 555-1212"
                });
                context.Agents.Add(new Agent
                {
                    Name = "Janet Rooney",
                    Phone = "913 876-5309"
                });
                context.SaveChanges();
            }

            using (var context = new Recipe2Context())
            {
                // change the phone numbers
                var agent1 = context.Agents.Single(a => a.Name == "Janet Rooney");
                var agent2 = context.Agents.Single(a => a.Name == "Phillip Marlowe");
                agent1.Phone = "817 353-4458";
                context.SaveChanges();

                // update the other agent's number out-of-band
                context.Database.ExecuteSqlCommand(@"update Chapter14.agent 
                         set Phone = '817 294-6059' where name = 'Phillip Marlowe'");

                // now change it using the model
                agent2.Phone = "817 906-2212";
                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    Console.WriteLine("Exception caught updating phone number: {0}",
                                       ex.Message);
                }
            }

            using (var context = new Recipe2Context())
            {
                Console.WriteLine("-- All Agents --");
                foreach (var agent in context.Agents)
                {
                    Console.WriteLine("Agent: {0}, Phone: {1}", agent.Name, agent.Phone);
                }
            }
            
        }
    }
}

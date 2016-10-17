using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe5
{
    public static class Recipe5Program
    {
        public static void Run()
        {
            DateTime today = DateTime.Parse("5/7/2013");
            using (var context = new Recipe5Context())
            {
                var mem1 = new Member { Name = "Jill Robertson" };
                var mem2 = new Member { Name = "Steven Rhodes" };
                mem1.Messages.Add(new Message
                {
                    DateSent = today,
                    MessageBody = "Hello Jim",
                    Subject = "Hello"
                });
                mem1.Messages.Add(new Message
                {
                    DateSent = today,
                    MessageBody = "Wonderful weather!",
                    Subject = "Weather"
                });
                mem1.Messages.Add(new Message
                {
                    DateSent = today,
                    MessageBody = "Meet me for lunch",
                    Subject = "Lunch plans"
                });
                mem2.Messages.Add(new Message
                {
                    DateSent = today,
                    MessageBody = "Going to class today?",
                    Subject = "What's up?"
                });
                context.Members.Add(mem1);
                context.Members.Add(mem2);
                context.SaveChanges();
            }

            using (var context = new Recipe5Context())
            {
                Console.WriteLine("Members by message count for {0}",
                                   today.ToShortDateString());
                var members = context.MembersWithTheMostMessages(today);
                foreach (var member in members)
                {
                    Console.WriteLine("Member: {0}", member.Name);
                }
            }
            
        }
    }
}

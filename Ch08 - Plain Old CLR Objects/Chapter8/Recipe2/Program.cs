using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe22;
using System.Data.Entity;
namespace POCORecipe2
{
	class Program
	{
		static void Main(string[] args)
		{
			RunExample();
		}

		static void RunExample()
		{
            using (var context = new EFRecipesEntities())
            {
                var venue = new Venue { Name = "Sports and Recreational Grounds" };
                var event1 = new Event { Name = "Inter-school Soccer" };
                event1.Competitors.Add(new Competitor { Name = "St. Mary's School" });
                event1.Competitors.Add(new Competitor { Name = "City School" });
                venue.Events.Add(event1);
                context.Venues.Add(venue);
                context.SaveChanges();
            }
            using (var context = new EFRecipesEntities())
            {
                foreach (var venue in context.Venues.Include("Events").Include("Events.Competitors"))
                {
                    Console.WriteLine("Venue: {0}", venue.Name);
                    foreach (var evt in venue.Events)
                    {
                        Console.WriteLine("\tEvent: {0}", evt.Name);
                        Console.WriteLine("\t--- Competitors ---");
                        foreach (var competitor in evt.Competitors)
                        {
                            Console.WriteLine("\t{0}", competitor.Name);
                        }
                    }
                }
            }
			using (var context = new EFRecipesEntities())
			{
				foreach (var venue in context.Venues)
				{
					Console.WriteLine("Venue: {0}", venue.Name);
					context.Entry(venue).Collection(v => v.Events).Load();
					foreach (var evt in venue.Events)
					{
						Console.WriteLine("\tEvent: {0}", evt.Name);
						Console.WriteLine("\t--- Competitors ---");
						context.Entry(evt).Collection(e => e.Competitors).Load();
						foreach (var competitor in evt.Competitors)
						{
							Console.WriteLine("\t{0}", competitor.Name);
						}
					}
				}
			}
			
			Console.WriteLine("Enter input:");
			string line = Console.ReadLine();
			if (line == "exit")
			{
				return;
			};
		}
	}
}
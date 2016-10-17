using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe7
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
				var platst = new SponsorType { Description = "Platinum" };
				var goldst = new SponsorType { Description = "Gold" };
				var sp1 = new Sponsor
				{
					Name = "Rex's Auto Body Shop",
					SponsorType = goldst
				};
				var sp2 = new Sponsor
				{
					Name = "Midtown Eye Care Center",
					SponsorType = platst
				};
				var sp3 = new Sponsor
				{
					Name = "Tri-Cities Ford",
					SponsorType = platst
				};
				var ev1 = new Event { Name = "OctoberFest", Sponsor = sp1 };
				var ev2 = new Event { Name = "Concerts in the Park", Sponsor = sp2 };
				var ev3 = new Event { Name = "11th Street Art Festival", Sponsor = sp3 };
				context.Events.Add(ev1);
				context.Events.Add(ev2);
				context.Events.Add(ev3);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Events with Platinum Sponsors");
				Console.WriteLine("=============================");
				var esql = @"select value e from EFRecipesEntities.Events as e where
                ref(e.Sponsor) in (EFRecipesModel.PlatinumSponsors())";

				var objectContext = (context as IObjectContextAdapter).ObjectContext;

				var events = objectContext.CreateQuery<Event>(esql);
				foreach (var ev in events)
				{
					Console.WriteLine(ev.Name);
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}
}

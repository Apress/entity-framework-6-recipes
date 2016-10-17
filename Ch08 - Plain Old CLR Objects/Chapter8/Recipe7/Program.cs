using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe77;
namespace POCORecipe7
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
				context.Configuration.AutoDetectChangesEnabled = false;
				var speaker1 = new Speaker { Name = "Karen Stanfield" };
				var talk1 = new Talk { Title = "Simulated Annealing in C#" };
				speaker1.Talks = new List<Talk> { talk1 };

				// associations not yet complete
				Console.WriteLine("talk1.Speaker is null: {0}",
									talk1.Speakers == null);

				context.Speakers.Add(speaker1);

				// now it's fixed up
				Console.WriteLine("talk1.Speaker is null: {0}",
									talk1.Speakers == null);
				Console.WriteLine("Number of added entries tracked: {0}",
									context.ChangeTracker.Entries().Where(e => e.State == System.Data.Entity.EntityState.Added).Count());
				context.SaveChanges();
				// change the talk's title
				talk1.Title = "AI with C# in 3 Easy Steps";
				Console.WriteLine("talk1's state is: {0}",
									context.Entry(talk1).State);
				context.ChangeTracker.DetectChanges();
				Console.WriteLine("talk1's state is: {0}",
									context.Entry(talk1).State);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				foreach (var speaker in context.Speakers.Include("Talks"))
				{
					Console.WriteLine("Speaker: {0}", speaker.Name);
					foreach (var talk in speaker.Talks)
					{
						Console.WriteLine("\tTalk Title: {0}", talk.Title);
					}
				}
			}
		}
	}
}

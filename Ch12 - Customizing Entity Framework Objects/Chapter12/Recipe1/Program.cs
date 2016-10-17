using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
namespace CustomEFRecipe1
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
				var path1 = "AlexJones.txt";
				File.AppendAllText(path1, "Alex Jones\nResume\n...");
				var path2 = "JanisRogers.txt";
				File.AppendAllText(path2, "Janis Rodgers\nResume\n...");
				var app1 = new Applicant
				{
					Name = "Alex Jones",
					ResumePath = path1
				};
				var app2 = new Applicant
				{
					Name = "Janis Rogers",
					ResumePath = path2
				};
				context.Applicants.Add(app1);
				context.Applicants.Add(app2);
				context.SaveChanges();

				// delete Alex Jones
			    context.Applicants.Remove(app1);
			    context.SaveChanges();
			}
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
		}
	}
	public partial class EFRecipesEntities
	{
		public override int SaveChanges()
		{
			Console.WriteLine("Saving Changes...");
			var applicants = this.ChangeTracker.Entries().Where(e => e.State == System.Data.Entity.EntityState.Deleted).Select(e => e.Entity).OfType<Applicant>().ToList();

			int changes = base.SaveChanges();
			Console.WriteLine("\n{0} applicants deleted",
							   applicants.Count().ToString());
			foreach (var app in applicants)
			{
				File.Delete(app.ResumePath);
				Console.WriteLine("\n{0}'s resume at {1} deleted",
								   app.Name, app.ResumePath);
			}
			return changes;
		}
	}
}
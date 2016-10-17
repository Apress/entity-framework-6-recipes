using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Common;

namespace FunctionsEFRecipe4
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
				var john = new Supervisor { Name = "John Smith" };
				var steve = new Supervisor { Name = "Steve Johnson" };
				var jill = new ProjectManager
				{
					Name = "Jill Masterson",
					Manager = john
				};
				var karen = new ProjectManager
				{
					Name = "Karen Carns",
					Manager = steve
				};
				var bob = new TeamLead { Name = "Bob Richardson", Manager = karen };
				var tom = new TeamLead { Name = "Tom Landers", Manager = jill };
				var nancy = new TeamMember { Name = "Nancy Jones", Manager = tom };
				var stacy = new TeamMember
				{
					Name = "Stacy Rutgers",
					Manager = bob
				};
				context.Associates.Add(john);
				context.Associates.Add(steve);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Using eSQL...");
                var emps = context.Associates.OfType<TeamMember>()
                    .Where(q => q.Manager.Name == "Jill Masterson" || q.Manager.Name == "Steve Johnson");
				
                Console.WriteLine("Team members that report up to either");
				Console.WriteLine("Project Manager Jill Masterson ");
				Console.WriteLine("or Supervisor Steve Johnson");
				foreach (var emp in emps)
				{
					Console.WriteLine("\tAssociate: {0}", emp.Name);
				}
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Using LINQ...");
				var emps = from e in context.Associates.OfType<TeamMember>()
						   where MyFunctions.GetProjectManager(e).Name ==
							"Jill Masterson" ||
						   MyFunctions.GetSupervisor(e).Name == "Steve Johnson"
						   select e;
				Console.WriteLine("Team members that report up to either");
				Console.WriteLine("Project Manager Jill Masterson ");
				Console.WriteLine("or Supervisor Steve Johnson");
				foreach (var emp in emps)
				{
					Console.WriteLine("\tAssociate: {0}", emp.Name);
				}
			}
		}
	}

	public class MyFunctions
	{
		[EdmFunction("EFRecipesModel", "GetProjectManager")]
		public static ProjectManager GetProjectManager(TeamMember member)
		{
			throw new NotSupportedException("Direct calls not supported.");
		}

		[EdmFunction("EFRecipesModel", "GetSupervisor")]
		public static Supervisor GetSupervisor(TeamMember member)
		{
			throw new NotSupportedException("Direct calls not supported.");
		}
	}
}

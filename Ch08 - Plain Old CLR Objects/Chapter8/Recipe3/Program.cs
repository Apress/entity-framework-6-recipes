using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe3.Models;
namespace POCORecipe3
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
				var vh1 = new Vehicle { LicenseNo = "BR-549" };
				var t1 = new Ticket { IssueDate = DateTime.Parse("06/10/13") };
				var v1 = new Violation
				{
					Description = "20 MPH over the speed limit",
					Amount = 125M
				};
				var v2 = new Violation
				{
					Description = "Broken tail light",
					Amount = 50M
				};
				t1.Violations.Add(v1);
				t1.Violations.Add(v2);
				t1.Vehicle = vh1;
				context.Tickets.Add(t1);
				var vh2 = new Vehicle { LicenseNo = "XJY-902" };
				var t2 = new Ticket { IssueDate = DateTime.Parse("06/12/13") };
				var v3 = new Violation
				{
					Description = "Parking in a no parking zone",
					Amount = 35M
				};
				t2.Violations.Add(v3);
				t2.Vehicle = vh2;
				context.Tickets.Add(t2);
				context.SaveChanges();
			}
			using (var context = new EFRecipesEntities())
			{
				foreach (var ticket in context.Tickets)
				{
					Console.WriteLine(" Ticket: {0}, Total Cost: {1}",
					  ticket.TicketId.ToString(),
					  ticket.Violations.Sum(v => v.Amount).ToString("C"));
					foreach (var violation in ticket.Violations)
					{
						Console.WriteLine("\t{0}", violation.Description);
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

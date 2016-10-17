using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe11
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
				var app1 = new Appointment
				{
					StartsAt = DateTime.Parse("7/23/2013 14:00"),
					GoesTo = DateTime.Parse("7/23/2013 15:00")
				};
				var app2 = new Appointment
				{
					StartsAt = DateTime.Parse("7/24/2013 9:00"),
					GoesTo = DateTime.Parse("7/24/2013 11:00")
				};
				var app3 = new Appointment
				{
					StartsAt = DateTime.Parse("7/24/2013 13:00"),
					GoesTo = DateTime.Parse("7/23/2013 15:00")
				};
				context.Appointments.Add(app1);
				context.Appointments.Add(app2);
				context.Appointments.Add(app3);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				var apps = from a in context.Appointments
						   where SqlFunctions.DatePart("WEEKDAY", a.StartsAt) == 4
						   select a;
				Console.WriteLine("Appointments for Thursday");
				Console.WriteLine("=========================");
				foreach (var appointment in apps)
				{
					Console.WriteLine("Appointment from {0} to {1}",
								  appointment.StartsAt.ToShortTimeString(),
								  appointment.GoesTo.ToShortTimeString());
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}
}

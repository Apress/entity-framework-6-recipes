using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity.Infrastructure;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Data.EntityClient;
namespace FunctionsEFRecipe5
{
	class Program
	{
		static void Main(string[] args)
		{
            Cleanup();
			RunExample();
		}

        static void Cleanup()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter11.PatientVisit");
                context.Database.ExecuteSqlCommand("delete from chapter11.Patient");
            }
        }
		static void RunExample()
		{
			using (var context = new EFRecipesEntities())
			{
				var hotel = new Hotel { Name = "Five Seasons Resort" };
				var v1 = new Visitor { Name = "Alex Stevens" };
				var v2 = new Visitor { Name = "Joan Hills" };
				var r1 = new Reservation
				{
					Cost = 79.99M,
					Hotel = hotel,
					ReservationDate = DateTime.Parse("19/2/2013"),
					Visitor = v1
				};
				var r2 = new Reservation
				{
					Cost = 99.99M,
					Hotel = hotel,
                    ReservationDate = DateTime.Parse("17/2/2013"),
					Visitor = v2
				};
				var r3 = new Reservation
				{
					Cost = 109.99M,
					Hotel = hotel,
					ReservationDate = DateTime.Parse("18/2/2013"),
					Visitor = v1
				};
				var r4 = new Reservation
				{
					Cost = 89.99M,
					Hotel = hotel,
                    ReservationDate = DateTime.Parse("17/2/2013"),
					Visitor = v2
				};
                context.Hotels.Add(hotel);
                context.Visitors.Add(v1);
                context.Visitors.Add(v2);
                context.Reservations.Add(r1);
                context.Reservations.Add(r2);
                context.Reservations.Add(r3);
                context.Reservations.Add(r4);
                context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Using eSQL...");
				var esql = @"Select value v from
             EFRecipesModel.VisitorSummary(DATETIME'2013-02-16 00:00', 7) as v";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var visitors = objectContext.CreateQuery<DbDataRecord>(esql);
				foreach (var visitor in visitors)
				{
					Console.WriteLine("{0}, Total Reservations: {1}, Revenue: {2:C}",
						visitor["Name"], visitor["TotalReservations"],
						visitor["BusinessEarned"]);
				}
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Using LINQ...");
				var visitors = from v in
								   context.VisitorSummary(DateTime.Parse("16/2/2013"), 7)
							   select v;
                try
                {
				    foreach (var visitor in visitors)
				    {
					    Console.WriteLine("{0}, Total Reservations: {1}, Revenue: {2:C}",
						    visitor["Name"], visitor["TotalReservations"],
						    visitor["BusinessEarned"]);
				    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Call cannot be made to this function.");
                }
                Console.WriteLine("Press any key to close...");
                Console.ReadLine();
			}
		}
	}

	partial class EFRecipesEntities
	{
		[EdmFunction("EFRecipesModel", "VisitorSummary")]
		public IQueryable<DbDataRecord> VisitorSummary(DateTime StartDate, int Days)
		{
            var objectContext = (this as IObjectContextAdapter).ObjectContext;
            return objectContext.CreateQuery<DbDataRecord>(
            Expression.Call(Expression.Constant(this),
            (MethodInfo) MethodInfo.GetCurrentMethod(),
            new Expression[] { Expression.Constant(StartDate),
                               Expression.Constant(Days) }
            ).ToString());
		}
	}
}
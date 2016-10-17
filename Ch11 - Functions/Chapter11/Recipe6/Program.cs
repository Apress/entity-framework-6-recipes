using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe6
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
                context.Database.ExecuteSqlCommand("delete from chapter11.Reservation");
                context.Database.ExecuteSqlCommand("delete from chapter11.Visitor");
                context.Database.ExecuteSqlCommand("delete from chapter11.Hotel");
            }
        }

		static void RunExample()
		{
			using (var context = new EFRecipesEntities())
			{
				string hospital = "Oakland General";
				var p1 = new Patient { Name = "Robin Rosen", Age = 41 };
				var p2 = new Patient { Name = "Alex Jones", Age = 39 };
				var p3 = new Patient { Name = "Susan Kirby", Age = 54 };
				var v1 = new PatientVisit
				{
					Cost = 98.38M,
					Hospital = hospital,
					Patient = p1
				};
				var v2 = new PatientVisit
				{
					Cost = 1122.98M,
					Hospital = hospital,
					Patient = p1
				};
				var v3 = new PatientVisit
				{
					Cost = 2292.72M,
					Hospital = hospital,
					Patient = p2
				};
				var v4 = new PatientVisit
				{
					Cost = 1145.73M,
					Hospital = hospital,
					Patient = p3
				};
				var v5 = new PatientVisit
				{
					Cost = 2891.07M,
					Hospital = hospital,
					Patient = p3
				};
				context.Patients.Add(p1);
				context.Patients.Add(p2);
				context.Patients.Add(p3);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Query using eSQL...");
				var esql = @"Select value ps from EFRecipesEntities.Patients 
                          as p join EFRecipesModel.GetVisitSummary() 
                          as ps on p.Name = ps.Name where p.Age > 40";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var patients = objectContext.CreateQuery<VisitSummary>(esql);
                foreach (var patient in patients)
                {
                    Console.WriteLine("{0}, Visits: {1}, Total Bill: {2}",
                        patient.Name, patient.TotalVisits.ToString(),
                        patient.TotalCost.ToString("C"));
                }            
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Query using LINQ...");
				var patients = from p in context.Patients
							   join ps in context.GetVisitSummary() on p.Name equals
								ps.Name
							   where p.Age >= 40
							   select ps;
                try
                {            
				    foreach (var patient in patients)
				    {
					    Console.WriteLine("{0}, Visits: {1}, Total Bill: {2}",
						    patient.Name, patient.TotalVisits.ToString(),
						    patient.TotalCost.ToString("C"));
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
		[EdmFunction("EFRecipesModel", "GetVisitSummary")]
		public IQueryable<VisitSummary> GetVisitSummary()
		{
            var objectContext = (this as IObjectContextAdapter).ObjectContext;
            return objectContext.CreateQuery<VisitSummary>(
                Expression.Call(Expression.Constant(this),
				  (MethodInfo) MethodInfo.GetCurrentMethod()).ToString());
		}
	}
}

using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe10
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
				var c1 = new WebCustomer { Name = "Alex Stevens", Zip = "76039" };
				var c2 = new WebCustomer { Name = "Janis Jones", Zip = "76040" };
				var c3 = new WebCustomer { Name = "Cathy Robins", Zip = "76111" };
				context.Zips.Add(new Zip
				{
					Latitude = 32.834298M,
					Longitude = -32.834298M,
					ZipCode = "76039"
				});
				context.Zips.Add(new Zip
				{
					Latitude = 32.835298M,
					Longitude = -32.834798M,
					ZipCode = "76040"
				});
				context.Zips.Add(new Zip
				{
					Latitude = 33.834298M,
					Longitude = -31.834298M,
					ZipCode = "76111"
				});
				context.WebCustomers.Add(c1);
				context.WebCustomers.Add(c2);
				context.WebCustomers.Add(c3);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				string esql = @"select value c
                    from EFRecipesEntities.WebCustomers as c
                    join
                    (SELECT z.ZipCode,
                      3958.75 * (SqlServer.Atan(SqlServer.Sqrt(1 - 
                       SqlServer.power(((SqlServer.Sin(t2.Latitude/57.2958M) *
                           SqlServer.Sin(z.Latitude/57.2958M)) + 
                           (SqlServer.Cos(t2.Latitude/57.2958M) *
                           SqlServer.Cos(z.Latitude/57.2958M) * 
                            SqlServer.Cos((z.Longitude/57.2958M) -
                           (t2.Longitude/57.2958M)))), 2)) /(
                             ((SqlServer.Sin(t2.Latitude/57.2958M) *
                             SqlServer.Sin(z.Latitude/57.2958M)) + 
                              (SqlServer.Cos(t2.Latitude/57.2958M) * 
                               SqlServer.Cos(z.Latitude/57.2958M) * 
                               SqlServer.Cos((z.Longitude/57.2958M) - 
                                 (t2.Longitude/57.2958M))))))
                     ) as DistanceInMiles
                     FROM EFRecipesEntities.Zips AS z join
                      (select top(1) z2.Latitude as Latitude,z2.Longitude as 
                       Longitude
                       from EFRecipesEntities.Zips as z2
                       where z2.ZipCode = @Zip
                      ) as t2 on 1 = 1
                    ) as matchingzips on matchingzips.ZipCode = c.Zip
                   where matchingzips.DistanceInMiles <= @RadiusInMiles";
				
				var objectContext = (context as IObjectContextAdapter).ObjectContext;

				var custs = objectContext.CreateQuery<WebCustomer>(esql,
								new ObjectParameter("Zip", "76039"),
								new ObjectParameter("RadiusInMiles", 5));
				Console.WriteLine("Customers within 5 miles of 76039");
				foreach (var cust in custs)
				{
					Console.WriteLine("Customer: {0}", cust.Name);
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}
}

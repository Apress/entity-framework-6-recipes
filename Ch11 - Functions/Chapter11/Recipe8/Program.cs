using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe8
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
				var c1 = new Customer { Name = "Jill Masters", City = "Raytown" };
				var c2 = new Customer { Name = "Bob Meyers", City = "Austin" };
				var c3 = new Customer { Name = "Robin Rosen", City = "Dallas" };
				var o1 = new Order { OrderAmount = 12.99M, Customer = c1 };
				var o2 = new Order { OrderAmount = 99.39M, Customer = c2 };
				var o3 = new Order { OrderAmount = 101.29M, Customer = c3 };
				context.Orders.Add(o1);
				context.Orders.Add(o2);
				context.Orders.Add(o3);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Customers with above average total purchases");
				var esql = @"select o.Customer.Name, count(o.OrderId) as TotalOrders,
                 Sum(o.OrderAmount) as TotalPurchases
                 from EFRecipesEntities.Orders as o
                 where o.OrderAmount > 
                   anyelement(select value Avg(o.OrderAmount) from
                              EFRecipesEntities.Orders as o)
                 group by o.Customer.Name";

				var objectContext = (context as IObjectContextAdapter).ObjectContext;

				var summary = objectContext.CreateQuery<DbDataRecord>(esql);
				foreach (var item in summary)
				{
					Console.WriteLine("\t{0}, Total Orders: {1}, Total: {2:C}",
						item["Name"], item["TotalOrders"], item["TotalPurchases"]);
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}
}
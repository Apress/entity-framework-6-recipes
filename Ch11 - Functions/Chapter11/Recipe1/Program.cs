using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe1
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
				var c1 = new Category { CategoryName = "Backpacking Tents" };
				var p1 = new Product
				{
					ProductName = "Hooligan",
					UnitPrice = 89.99M,
					Category = c1
				};

				var p2 = new Product
				{
					ProductName = "Kraz",
					UnitPrice = 99.99M,
					Category = c1
				};

				var p3 = new Product
				{
					ProductName = "Sundome",
					UnitPrice = 49.99M,
					Category = c1
				};
				context.Categories.Add(c1);
				context.Products.Add(p1);
				context.Products.Add(p2);
				context.Products.Add(p3);

				var c2 = new Category { CategoryName = "Family Tents" };
				var p4 = new Product
				{
					ProductName = "Evanston",
					UnitPrice = 169.99M,
					Category = c2
				};
				var p5 = new Product
				{
					ProductName = "Montana",
					UnitPrice = 149.99M,
					Category = c2
				};
				context.Categories.Add(c2);
				context.Products.Add(p4);
				context.Products.Add(p5);
				context.SaveChanges();
			}
			// with eSQL
			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Using eSQL for the query...");
				Console.WriteLine();
				string sql = @"Select c.CategoryName, EFRecipesModel
                         .AverageUnitPrice(c) as AveragePrice from
                         EFRecipesEntities.Categories as c";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var cats = objectContext.CreateQuery<DbDataRecord>(sql);
				foreach (var cat in cats)
				{
					Console.WriteLine("Category '{0}' has an average price of {1}",
									   cat["CategoryName"], ((decimal)cat["AveragePrice"]).ToString("C"));
				}
			}

			// with LINQ
			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Using LINQ for the query...");
				Console.WriteLine();
				var cats = from c in context.Categories
						   select new
						   {
							   Name = c.CategoryName,
							   AveragePrice = MyFunctions.AverageUnitPrice(c)
						   };
				foreach (var cat in cats)
				{
					Console.WriteLine("Category '{0}' has an average price of {1}",
									   cat.Name, cat.AveragePrice.ToString("C"));
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}
	public class MyFunctions
	{
		[EdmFunction("EFRecipesModel", "AverageUnitPrice")]
		public static decimal AverageUnitPrice(Category category)
		{
			throw new NotSupportedException("Direct calls are not supported!");
		}
	}
}
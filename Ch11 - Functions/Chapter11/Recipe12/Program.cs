using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Objects.DataClasses;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe12
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
                context.Database.ExecuteSqlCommand("delete from chapter11.webproduct");
            }
        }

		static void RunExample()
		{
            using (var context = new EFRecipesEntities())
            {
                var w1 = new WebProduct
                {
                    Name = "Camping Tent",
                    Description = "Family Camping Tent, Color Green"
                };
                var w2 = new WebProduct { Name = "Chemical Light" };
                var w3 = new WebProduct
                {
                    Name = "Ground Cover",
                    Description = "Blue ground cover"
                };
                context.WebProducts.Add(w1);
                context.WebProducts.Add(w2);
                context.WebProducts.Add(w3);
                context.SaveChanges();
            }

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Query using eSQL...");
				var esql = @"select value
                 EFRecipesModel.Store.ISNULL(p.Description,p.Name)
                 from EFRecipesEntities.WebProducts as p";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var prods = objectContext.CreateQuery<string>(esql);
				foreach (var prod in prods)
				{
					Console.WriteLine("Product Description: {0}", prod);
				}
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Query using LINQ...");
                try
                {
                    var prods = from p in context.WebProducts.AsEnumerable()
                                select BuiltinFunctions.ISNULL(p.Description, p.Name);
                    foreach (var prod in prods)
                    {
                        Console.WriteLine(prod);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}

    public class BuiltinFunctions
	{
		[EdmFunction("EFRecipesModel.Store", "ISNULL")]
		public static string ISNULL(string check_expression, string replacementvalue)
		{
            throw new NotSupportedException("Direct calls are not supported.");
		}
	}
}

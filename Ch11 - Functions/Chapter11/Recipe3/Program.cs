using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe3
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
				context.Employees.Add(new Employee
				{
					FirstName = "Jill",
					LastName = "Robins",
					BirthDate = DateTime.Parse("3/2/1976")
				});
				context.Employees.Add(new Employee
				{
					FirstName = "Michael",
					LastName = "Kirk",
					BirthDate = DateTime.Parse("4/12/1985")
				});
				context.Employees.Add(new Employee
				{
					FirstName = "Karen",
					LastName = "Stanford",
					BirthDate = DateTime.Parse("7/6/1963")
				});
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Query using eSQL");
				var esql = @"Select EFRecipesModel.FullName(e) as Name,
                         EFRecipesModel.Age(e) as Age from
                         EFRecipesEntities.Employees as e";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var emps = objectContext.CreateQuery<DbDataRecord>(esql);
				foreach (var emp in emps)
				{
					Console.WriteLine("Employee: {0}, Age: {1}", emp["Name"],
									   emp["Age"]);
				}
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("\nQuery using LINQ");
				var emps = from e in context.Employees
						   select new
						   {
							   Name = MyFunctions.FullName(e),
							   Age = MyFunctions.Age(e)
						   };
				foreach (var emp in emps)
				{
					Console.WriteLine("Employee: {0}, Age: {1}", emp.Name,
									   emp.Age.ToString());
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}

	public class MyFunctions
	{
		[EdmFunction("EFRecipesModel", "FullName")]
		public static string FullName(Employee employee)
		{
			throw new NotSupportedException("Direct calls are not supported.");
		}

		[EdmFunction("EFRecipesModel", "Age")]
		public static int Age(Employee employee)
		{
			throw new NotSupportedException("Direct calls are not supported.");
		}
	}
}

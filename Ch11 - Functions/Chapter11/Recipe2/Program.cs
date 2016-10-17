using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace FunctionsEFRecipe2
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
				DateTime d1 = DateTime.Parse("8/8/2009");
				DateTime d2 = DateTime.Parse("8/12/2008");
				var c1 = new Customer { Name = "Jill Robinson", City = "Dallas" };
				var c2 = new Customer { Name = "Jerry Jones", City = "Denver" };
				var c3 = new Customer { Name = "Janis Brady", City = "Dallas" };
				var c4 = new Customer { Name = "Steve Foster", City = "Dallas" };
				context.Invoices.Add(new Invoice
				{
					Amount = 302.99M,
					Description = "New Tires",
					Date = d1,
					Customer = c1
				});
				context.Invoices.Add(new Invoice
				{
					Amount = 430.39M,
					Description = "Brakes and Shocks",
					Date = d1,
					Customer = c2
				});
				context.Invoices.Add(new Invoice
				{
					Amount = 102.28M,
					Description = "Wheel Alignment",
					Date = d1,
					Customer = c3
				});
				context.Invoices.Add(new Invoice
				{
					Amount = 629.82M,
					Description = "A/C Repair",
					Date = d2,
					Customer = c4
				});
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine("Using eSQL query...");
				string sql = @"Select value i from
                    EFRecipesModel.GetInvoices(EFRecipesEntities.Invoices) as i
                    where i.Date > DATETIME'2009-05-1 00:00' 
                    and i.Customer.City = @City";
				var objectContext = (context as IObjectContextAdapter).ObjectContext;
				var invoices = objectContext.CreateQuery<Invoice>(sql,
					   new ObjectParameter("City", "Dallas")).Include("Customer");
				foreach (var invoice in invoices)
				{
					Console.WriteLine("Customer: {0}\tInvoice for: {1}, Amount: {2}",
						 invoice.Customer.Name, invoice.Description, invoice.Amount);
				}
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Using LINQ query...");
				DateTime date = DateTime.Parse("5/1/2009");
				var invoices = from invoice in
								   MyFunctions.GetInvoices(context.Invoices)
							   where invoice.Date > date
							   where invoice.Customer.City == "Dallas"
							   select invoice;
				foreach (var invoice in ((DbQuery<Invoice>)invoices)
													.Include("Customer"))
				{
					Console.WriteLine("Customer: {0}, Invoice for: {1}, Amount: {2}",
						 invoice.Customer.Name, invoice.Description, invoice.Amount);
				}
			}
			Console.WriteLine("Press any key to close...");
			Console.ReadLine();
		}
	}

	public class MyFunctions
	{
		[EdmFunction("EFRecipesModel", "GetInvoices")]
		public static IQueryable<Invoice> GetInvoices(IQueryable<Invoice> invoices)
		{
			return invoices.Provider.CreateQuery<Invoice>(
				Expression.Call((MethodInfo) MethodInfo.GetCurrentMethod(),
								Expression.Constant(invoices,
													typeof(IQueryable<Invoice>))));
		}
	}
}

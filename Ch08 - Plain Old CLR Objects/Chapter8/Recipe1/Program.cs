using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe11;
namespace POCORecipe1
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
				var tea = new Product { ProductName = "Green Tea", UnitPrice = 1.09M };
				var coffee = new Product
				{
					ProductName = "Colombian Coffee",
					UnitPrice = 2.15M
				};
				var customer = new Customer { ContactName = "Karen Marlowe" };
				var order1 = new Order { OrderDate = DateTime.Parse("10/06/13") };
				order1.OrderDetails.Add(new OrderDetail
				{
					Product = tea,
					Quantity = 4,
					UnitPrice = 1.00M
				});
				order1.OrderDetails.Add(new OrderDetail
				{
					Product = coffee,
					Quantity = 3,
					UnitPrice = 2.15M
				});
				customer.Orders.Add(order1);
				context.Customers.Add(customer);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				var query = context.Customers.Include("Orders.OrderDetails.Product");
				foreach (var customer in query)
				{
					Console.WriteLine("Orders for {0}", customer.ContactName);
					foreach (var order in customer.Orders)
					{
						Console.WriteLine("--Order Date: {0}--",
									 order.OrderDate.ToShortDateString());
						foreach (var detail in order.OrderDetails)
						{
							Console.WriteLine(
								"\t{0}, {1} units at {2} each, unit discount: {3}",
								detail.Product.ProductName,
								detail.Quantity.ToString(),
								detail.UnitPrice.ToString("C"),
								(detail.Product.UnitPrice - detail.UnitPrice).ToString("C"));
						}
					}
				}
			}
			Console.WriteLine("Enter input to exit:");
			string line = Console.ReadLine();
			if (line == "exit")
			{
				return;
			};
		}
	}
}

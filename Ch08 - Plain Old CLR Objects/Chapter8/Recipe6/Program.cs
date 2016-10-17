using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe6.Models;
namespace POCORecipe6
{
	class Program
	{
		static void Main(string[] args)
		{
			RunExample();
		}

		static void RunExample()
		{
			int itemId = 0;
			using (var context = new EFRecipesEntities())
			{
				var item = new Item
				{
					Name = "Xcel Camping Tent",
					UnitPrice = 99.95M
				};
				context.Items.Add(item);
				context.SaveChanges();

				// keep the item id for the next step
				itemId = item.ItemId;
				Console.WriteLine("Item: {0}, UnitPrice: {1}",
						 item.Name, item.UnitPrice.ToString("C"));
			}

			using (var context = new EFRecipesEntities())
			{
				// pretend this is the updated 
				// item we received with the new price
				var item = new Item
				{
					ItemId = itemId,
					Name = "Xcel Camping Tent",
					UnitPrice = 129.95M
				};
				var originalItem = context.Items.Where(x => x.ItemId ==  itemId).FirstOrDefault<Item>();
				context.Entry(originalItem).CurrentValues.SetValues(item);
				context.SaveChanges();
			}
			using (var context = new EFRecipesEntities())
			{
				var item = context.Items.Single();
				Console.WriteLine("Item: {0}, UnitPrice: {1}", item.Name,
								   item.UnitPrice.ToString("C"));
			}
			Console.WriteLine("Enter input as exit to exit.:");
			string line = Console.ReadLine();
			if (line == "exit")
			{
				return;
			};
		}
	}
}

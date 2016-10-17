using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe10
{
    public static class Recipe10Program
    {
        public static void Run()
        {
            using (var context = new Recipe10Context())
            {
                var order = new WebOrder
                {
                    CustomerName = "Jim Allen",
                    OrderDate = DateTime.Parse("5/3/2012"),
                    IsDeleted = false,
                    Amount = 200
                };
                context.WebOrders.Add(order);
                order = new WebOrder
                {
                    CustomerName = "John Stevens",
                    OrderDate = DateTime.Parse("1/1/2011"),
                    IsDeleted = false,
                    Amount = 400
                };
                context.WebOrders.Add(order);
                order = new WebOrder
                {
                    CustomerName = "Russel Smith",
                    OrderDate = DateTime.Parse("1/3/2011"),
                    IsDeleted = true,
                    Amount = 500
                };
                context.WebOrders.Add(order);
                order = new WebOrder
                {
                    CustomerName = "Mike Hammer",
                    OrderDate = DateTime.Parse("6/3/2013"),
                    IsDeleted = true,
                    Amount = 1800
                };
                context.WebOrders.Add(order);
                order = new WebOrder
                {
                    CustomerName = "Steve Jones",
                    OrderDate = DateTime.Parse("1/1/2008"),
                    IsDeleted = true,
                    Amount = 600
                };
                context.WebOrders.Add(order);
                context.SaveChanges();
            }

            using (var context = new Recipe10Context())
            {
                Console.WriteLine("Orders");
                Console.WriteLine("======");
                foreach (var order in context.WebOrders)
                {
                    Console.WriteLine("\nCustomer: {0}", order.CustomerName);
                    Console.WriteLine("OrderDate: {0}", order.OrderDate.ToShortDateString());
                    Console.WriteLine("Is Deleted: {0}", order.IsDeleted.ToString());
                    Console.WriteLine("Amount: {0:C}", order.Amount);
                }
            }
            
        }
    }
}

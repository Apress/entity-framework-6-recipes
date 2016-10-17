using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe4
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
                var item1 = new CartItem
                {
                    SKU = "AMM-223",
                    Quantity = 3,
                    Price = 19.95M
                };
                var item2 = new CartItem
                {
                    SKU = "CAMP-12",
                    Quantity = 1,
                    Price = 59.95M
                };
                var item3 = new CartItem
                {
                    SKU = "29292",
                    Quantity = 2,
                    Price = 4.95M
                };
                var cart = new Cart { CartTotal = 0 };
                cart.CartItems.Add(item1);
                cart.CartItems.Add(item2);
                cart.CartItems.Add(item3);
                context.Carts.AddObject(cart);
                item1.Quantity = 1;
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var cart in context.Carts)
                {
                    Console.WriteLine("Cart Total = {0}",
                                       cart.CartTotal.ToString("C"));
                    foreach (var item in cart.CartItems)
                    {
                        Console.WriteLine("\tSKU = {0}, Qty = {1}, Unit Price = {2}",
                                           item.SKU, item.Quantity.ToString(),
                                           item.Price.ToString("C"));
                    }
                }
            }
        }
    }
}

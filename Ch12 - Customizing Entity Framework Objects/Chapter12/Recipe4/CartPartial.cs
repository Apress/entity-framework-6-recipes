using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
namespace CustomEFRecipe4
{
    public partial class Cart
    {
        public Cart()
        {
            this.CartItems.AssociationChanged += (s, e) =>
            {
                if (e.Action == CollectionChangeAction.Add)
                {
                    var item = e.Element as CartItem;
                    item.PropertyChanged += (ps, pe) =>
                    {
                        if (pe.PropertyName == "Quantity")
                        {
                            this.CartTotal =
                              this.CartItems.Sum(t => t.Price * t.Quantity);
                            Console.WriteLine("Qty changed, total = {0}",
                              this.CartTotal.ToString("C"));
                        }
                    };
                }
                this.CartTotal = this.CartItems.Sum(t => t.Price * t.Quantity);
                Console.WriteLine("New total = {0}",
                                   this.CartTotal.ToString("C"));
            };
        }
    }
}

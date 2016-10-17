using System.Collections.Generic;

namespace Recipe10
{
    public class Order 
    {
        public Order()
        {
            OrderItems = new HashSet<OrderItem>();
        }

        public int OrderId { get; set; }
        public System.DateTime OrderDate { get; set; }
        public string CustomerName { get; set; }

        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
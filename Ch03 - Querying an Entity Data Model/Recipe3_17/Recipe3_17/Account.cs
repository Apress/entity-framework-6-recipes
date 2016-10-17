using System.Collections.Generic;

namespace Recipe3_19
{
    public class Account
    {
        public Account()
        {
            Orders = new HashSet<Order>();
        }
        
        public int AccountId { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
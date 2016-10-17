using System.Collections.Generic;

namespace Recipe10
{
    public class Customer
    {
        public Customer()
        {
            CreditCards = new HashSet<CreditCard>();
        }

        public int CustomerId { get; set; }
        public string Name { get; set; }
        public string City { get; set; }

        public virtual ICollection<CreditCard> CreditCards { get; set; }
    }
}
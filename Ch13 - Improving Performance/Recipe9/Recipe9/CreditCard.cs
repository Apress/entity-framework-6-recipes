using System.Collections.Generic;

namespace Recipe10
{
    public class CreditCard
    {
        public CreditCard()
        {
            Transactions = new HashSet<Transaction>();
        }

        public string CardNumber { get; set; }
        public string Type { get; set; }
        public System.DateTime ExpirationDate { get; set; }
        public int CustomerId { get; set; }

        public virtual Customer Customer { get; set; }
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
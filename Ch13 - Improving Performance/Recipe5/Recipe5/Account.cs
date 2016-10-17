using System.Collections.Generic;

namespace Recipe5
{
    public class Account
    {
        public virtual int AccountId { get; set; }
        public virtual string Name { get; set; }
        public virtual decimal Balance { get; set; }
        public virtual ICollection<Payment> Payments { get; set; }
    }
}
using System;

namespace Recipe3_19
{
    public class Order
    {
        public int OrderId { get; set; }
        public Decimal Amount { get; set; }
        public int AccountId { get; set; }
        public string ShipCity { get; set; }
        public string ShipState { get; set; }
        public virtual Account Account { get; set; }
    }
}
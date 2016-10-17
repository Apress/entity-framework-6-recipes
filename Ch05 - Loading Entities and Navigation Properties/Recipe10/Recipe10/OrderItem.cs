namespace Recipe10
{
    public class OrderItem
    {
        public int OrderItemId { get; set; }
        public int OrderId { get; set; }
        public int SKU { get; set; }
        public int Shipped { get; set; }
        public decimal UnitPrice { get; set; }

        public virtual Order Order { get; set; }
    }
}
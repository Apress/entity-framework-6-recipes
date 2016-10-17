namespace Recipe10
{
    public class Transaction
    {
        public int TransactionId { get; set; }
        public string CardNumber { get; set; }
        public decimal Amount { get; set; }

        public virtual CreditCard CreditCard { get; set; }
    }
}
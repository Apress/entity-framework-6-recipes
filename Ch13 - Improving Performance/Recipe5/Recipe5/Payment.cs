namespace Recipe5
{
    public class Payment
    {
        public virtual int PaymentId { get; set; }
        public virtual string PaidTo { get; set; }
        public virtual decimal Paid { get; set; }
        public virtual int AccountId { get; set; }
    }
}
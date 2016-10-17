namespace Recipe4.Service.DAL
{
    public class Phone : BaseEntity
    {
        public int PhoneId { get; set; }
        public string Number { get; set; }
        public string PhoneType { get; set; }
        public int CustomerId { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
using System.Collections.Generic;

namespace Recipe4.Service.DAL
{
    public class Customer : BaseEntity
    {
        public int CustomerId { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }

        public virtual ICollection<Phone> Phones { get; set; }
    }
}
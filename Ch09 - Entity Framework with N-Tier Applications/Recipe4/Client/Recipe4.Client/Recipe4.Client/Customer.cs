using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Recipe4.Client
{
    class Customer : BaseEntity
    {
        public Customer()
        {
            Phones = new List<Phone>();
        }
        
        public int CustomerId { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }

        public virtual ICollection<Phone> Phones { get; set; }
    }
}

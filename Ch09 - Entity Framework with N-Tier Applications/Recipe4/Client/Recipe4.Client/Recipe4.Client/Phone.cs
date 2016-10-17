using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Recipe4.Client
{
    class Phone : BaseEntity
    {
        public int PhoneId { get; set; }
        public string Number { get; set; }
        public string PhoneType { get; set; }
        public int CustomerId { get; set; }

        public virtual Customer Customer { get; set; }
    }
}

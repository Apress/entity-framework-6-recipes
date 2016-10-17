using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Recipe3.Client
{
    public class Booking
    {
        public int BookingId { get; set; }
        public int AgentId { get; set; }
        public string Customer { get; set; }
        public System.DateTime BookingDate { get; set; }
        public bool Paid { get; set; }

        public virtual TravelAgent TravelAgent { get; set; }
        //public TravelAgent TravelAgent { get; set; }
    }
}

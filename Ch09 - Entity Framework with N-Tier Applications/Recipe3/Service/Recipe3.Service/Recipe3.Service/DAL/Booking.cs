using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Recipe3.Service.DAL
{
    public class Booking
    {
        public int BookingId { get; set; }
        public int AgentId { get; set; }
        public string Customer { get; set; }
        public DateTime BookingDate { get; set; }
        public bool Paid { get; set; }

        public virtual TravelAgent TravelAgent { get; set; }
    }
}
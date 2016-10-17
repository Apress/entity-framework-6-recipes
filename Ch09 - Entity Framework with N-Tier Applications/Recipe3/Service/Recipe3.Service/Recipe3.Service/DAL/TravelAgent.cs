using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Recipe3.Service.DAL
{
    public class TravelAgent
    {
        public TravelAgent()
        {
            this.Bookings = new HashSet<Booking>();
        }

        public int AgentId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Booking> Bookings { get; set; }
    }
}
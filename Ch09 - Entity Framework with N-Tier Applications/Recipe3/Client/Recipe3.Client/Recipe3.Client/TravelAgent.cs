using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Recipe3.Client
{
    public class TravelAgent
    {
        public TravelAgent()
        {
            Bookings = new List<Booking>();
        }

        public int AgentId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Booking> Bookings { get; set; }
        //public List<Booking> Bookings { get; set; }

    }
}

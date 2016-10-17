using System;

namespace Recipe7
{
    public class Event
    {
        public int EventId { get; set; }
        public string EventName { get; set; }
        public DateTime EventDate { get; set; }
        public int ClubId { get; set; }

        public virtual Club Club { get; set; }
    }
}
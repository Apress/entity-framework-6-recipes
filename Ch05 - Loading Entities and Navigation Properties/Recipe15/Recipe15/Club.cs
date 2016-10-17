using System.Collections.Generic;

namespace AsyncEntityFramework
{
    public class Club
    {
        public Club()
        {
            Events = new HashSet<Event>();
        }

        public int ClubId { get; set; }
        public string Name { get; set; }
        public string City { get; set; }

        public virtual ICollection<Event> Events { get; set; }
    }
}
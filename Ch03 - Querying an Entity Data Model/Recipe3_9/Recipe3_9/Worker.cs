using System.Collections.Generic;

namespace Recipe3_9
{
    public class Worker
    {
        public Worker()
        {
            Accidents = new HashSet<Accident>();
        }

        public int WorkerId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Accident> Accidents { get; set; }
    }
}
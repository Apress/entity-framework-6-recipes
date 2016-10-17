using System.Collections.Generic;

namespace Recipe11
{
    public class Manager
    {
        public Manager()
        {
            Projects = new HashSet<Project>();
        }

        public int ManagerID { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Project> Projects { get; set; }
    }
}
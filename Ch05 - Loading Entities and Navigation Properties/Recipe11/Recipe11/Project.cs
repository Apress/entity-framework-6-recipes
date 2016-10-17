using System.Collections.Generic;

namespace Recipe11
{
    public class Project
    {
        public Project()
        {
            Contractors = new HashSet<Contractor>();
        }

        public int ProjectID { get; set; }
        public string Name { get; set; }
        public int ManagerID { get; set; }

        public virtual ICollection<Contractor> Contractors { get; set; }
        public virtual Manager Manager { get; set; }
    }
}
using System.Collections.Generic;

namespace Recipe8
{
    public class Company
    {
        public Company()
        {
            Departments = new HashSet<Department>();
        }

        public int CompanyId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Department> Departments { get; set; }
    }
}
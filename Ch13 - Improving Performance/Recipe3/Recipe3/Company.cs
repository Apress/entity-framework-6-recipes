using System.Collections.Generic;

namespace Recipe3
{
    public class Company
    {
        public Company()
        {
            Doctors = new HashSet<Doctor>();
        }

        public int CompanyId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Doctor> Doctors { get; set; }
    }
}
using System.Collections.Generic;

namespace Recipe3
{
    public class Doctor
    {
        public Doctor()
        {
            Appointments = new HashSet<Appointment>();
        }

        public int DoctorId { get; set; }
        public string Name { get; set; }
        public int CompanyId { get; set; }

        public virtual ICollection<Appointment> Appointments { get; set; }
        public virtual Company Company { get; set; }
    }
}
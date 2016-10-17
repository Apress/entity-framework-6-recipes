namespace Recipe3
{
    public class Appointment
    {
        public int AppointmentId { get; set; }
        public System.DateTime AppointmentDate { get; set; }
        public string Patient { get; set; }
        public int DoctorId { get; set; }

        public virtual Doctor Doctor { get; set; }
    }
}
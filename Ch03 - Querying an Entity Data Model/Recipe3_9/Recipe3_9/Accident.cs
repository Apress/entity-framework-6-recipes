namespace Recipe3_9
{
    public class Accident
    {
        public int AccidentId { get; set; }
        public string Description { get; set; }
        public int? Severity { get; set; }
        public int WorkerId { get; set; }

        public virtual Worker Worker { get; set; }
    }
}
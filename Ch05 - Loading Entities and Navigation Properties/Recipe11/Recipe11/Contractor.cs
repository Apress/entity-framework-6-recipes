namespace Recipe11
{
    public class Contractor
    {
        public int ContracterID { get; set; }
        public string Name { get; set; }
        public int ProjectID { get; set; }

        public virtual Project Project { get; set; }
    }
}
using System;

namespace Recipe3_1
{
    public class AssociateSalary
    {
        public int SalaryId { get; set; }
        public int AssociateId { get; set; }
        public decimal Salary { get; set; }
        public DateTime SalaryDate { get; set; }
        public virtual Associate Associate { get; set; }
    }
}
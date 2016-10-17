using System.Collections.Generic;

namespace Recipe3_1
{
    public class Associate
    {
        public Associate()
        {
            AssociateSalaries = new HashSet<AssociateSalary>();
        }

        public int AssociateId { get; set; }
        public string Name { get; set; }
        public virtual ICollection<AssociateSalary> AssociateSalaries { get; set; }
    }
}
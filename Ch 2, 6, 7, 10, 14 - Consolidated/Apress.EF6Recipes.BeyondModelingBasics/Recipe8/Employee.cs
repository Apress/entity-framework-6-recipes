using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe8
{
    public abstract class Employee
    {
        public int EmployeeId { get; set; }
        public string Name { get; set; }
    }

    public class SalariedEmployee : Employee
    {
        public decimal? Salary { get; set; }
    }

    public class CommissionedEmployee : SalariedEmployee
    {
        public decimal? Commission { get; set; }
    }

    public class HourlyEmployee : Employee
    {
        public decimal? Rate { get; set; }
        public decimal? Hours { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe10
{
    [Table("Employee", Schema="Chapter2")]
    public abstract class Employee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EmployeeId { get; protected set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public class FullTimeEmployee : Employee
    {
        public decimal? Salary { get; set; }
    }

    public class HourlyEmployee : Employee
    {
        public decimal? Wage { get; set; }
    }
}

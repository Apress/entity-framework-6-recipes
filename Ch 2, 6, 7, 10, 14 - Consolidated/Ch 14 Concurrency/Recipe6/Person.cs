using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe6
{
    [Table("Person", Schema = "Chapter14")]
    public abstract class Person
    {
        [Key]
        public int PersonId { get; set; }

        public string Name { get; set; }

        [Timestamp]
        public byte[] TimeStamp { get; set; }
    }

    [Table("Student", Schema = "Chapter14")]
    public class Student : Person
    {
        public DateTime? EnrollmentDate { get; set; }        
    }

    [Table("Instructor", Schema = "Chapter14")]
    public class Instructor : Person
    {
        public DateTime? HireDate { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe4
{
    [Table("Person", Schema = "Chapter6")]
    public abstract class Person
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PersonId { get; protected set; }
        public string Name { get; set; }

        public virtual Person Hero { get; set; }
        public virtual ICollection<Person> Fans { get; set; } 
    }

    public class Firefighter : Person
    {
        public string FireStation { get; set; }
    }

    public class Teacher : Person
    {
        public string School { get; set; }
    }

    public class Retired : Person
    {
        public string FullTimeHobby { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe5
{
    [Table("Technician", Schema = "Chapter7")]
    public class Technician
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TechId { get; set; }

        [MaxLength(50)]
        public string Name { get; set; }

        [ForeignKey("TechId")]
        public virtual ICollection<ServiceCall> ServiceCalls { get; set; } 
    }
}

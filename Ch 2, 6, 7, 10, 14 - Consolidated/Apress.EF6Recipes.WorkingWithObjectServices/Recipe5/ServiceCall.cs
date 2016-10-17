using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe5
{
    [Table("ServiceCall", Schema = "Chapter7")]
    public class ServiceCall
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CallId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string ContactName { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Issue { get; set; }

        public int TechId { get; set; }

        [InverseProperty("ServiceCalls")]
        public virtual Technician Technician { get; set; }
    }
}

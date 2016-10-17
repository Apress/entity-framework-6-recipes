using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe2
{
    [Table("Agent", Schema = "Chapter14")]
    public class Agent
    {
        [Key]
        [MaxLength(100)]
        public string Name { get; set; }

        [Required]
        [MaxLength(15)]
        public string Phone { get; set; }

        [Timestamp]
        public byte[] TimeStamp { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics
{
    public abstract class Car
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CarId { get; set; }
        public string Model { get; set; }
        public int Year { get; set; }
        public string Color { get; set; }

        public virtual Dealer Dealer { get; set; }
    }

    public class Toyota : Car
    {
        
    }

    public class BMW : Car
    {
        public bool CollisionAvoidance { get; set; }
    }

    [Table("Dealer", Schema = "Chapter6")]
    public class Dealer
    {
        public int DealerId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Car> Cars { get; set; } 
    }
}

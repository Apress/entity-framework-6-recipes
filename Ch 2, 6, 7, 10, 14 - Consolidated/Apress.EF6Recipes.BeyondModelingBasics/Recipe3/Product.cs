using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe3
{
    [Table("Product", Schema = "Chapter6")]
    public class Product
    {
        public Product()
        {
            RelatedProducts = new HashSet<Product>();
            OtherRelatedProducts = new HashSet<Product>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }

        // Products related to this product
        public virtual ICollection<Product> RelatedProducts { get; set; }

        // Products to which this product is related
        public virtual ICollection<Product> OtherRelatedProducts { get; set; } 

    }
}

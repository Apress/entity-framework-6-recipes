using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe5
{
    public class PictureCategory
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CategoryId { get; private set; }
        public string Name { get; set; }
        public int? ParentCategoryId { get; private set; }

        [ForeignKey("ParentCategoryId")]
        public PictureCategory ParentCategory { get; set; }

        public List<PictureCategory> Subcategories { get; set; } 

        public PictureCategory()
        {
            Subcategories = new List<PictureCategory>();
        }
    }
}

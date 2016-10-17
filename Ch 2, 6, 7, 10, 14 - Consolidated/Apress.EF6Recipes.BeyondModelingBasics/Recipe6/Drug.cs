using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe6
{
    [Table("Drug", Schema = "Chapter6")]
    public abstract class Drug
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int DrugId { get; set; }
        public string Name { get; set; }
    }

    public class Experimental : Drug
    {
        public string PrincipalResearcher { get; set; }

        public void PromoteToMedicine(DateTime acceptedDate, decimal targetPrice, 
                                  string marketingName)
        {
            var drug = new Medicine { DrugId = this.DrugId };
            using (var context = new Recipe6Context())
            {
                context.Drugs.Attach(drug);
                drug.AcceptedDate = acceptedDate;
                drug.TargetPrice = targetPrice;
                drug.Name = marketingName;
                context.SaveChanges();
            }
        }

    }

    public class Medicine : Drug
    {
        public decimal? TargetPrice { get; set; }
        public DateTime AcceptedDate { get; set; }
    }
}

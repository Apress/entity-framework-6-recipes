using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe7
{
    public class Invoice
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int InvoiceNumber { get; set; }
        public string BilledTo { get; set; }
        public DateTime InvoiceDate { get; set; }

        public virtual ICollection<LineItem> LineItems { get; set; } 

    }

    public class LineItem
    {
        public int InvoiceNumber { get; set; }
        public int ItemNumber { get; set; }
        public decimal Cost { get; set; }

        public virtual Invoice Invoice { get; set; }
    }
}

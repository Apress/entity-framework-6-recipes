using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe9
{
    public class Account
    {
        public int AccountNumber { get; set; }
        public string AccountHolder { get; set; }

        public virtual ICollection<Transaction> Transactions { get; set; } 
    }

    public class Transaction
    {
        public int AccountNumber { get; set; }
        public int TransactionNumber { get; set; }
        public DateTime TransactionDate { get; set; }
        public decimal Amount { get; set; }
    }
}

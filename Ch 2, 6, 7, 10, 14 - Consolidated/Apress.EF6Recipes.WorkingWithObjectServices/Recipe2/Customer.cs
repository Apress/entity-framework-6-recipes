using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe2
{
    public class Customer
    {
        public virtual int CustomerId { get; set; }
        public virtual string Name { get; set; }
    }
}

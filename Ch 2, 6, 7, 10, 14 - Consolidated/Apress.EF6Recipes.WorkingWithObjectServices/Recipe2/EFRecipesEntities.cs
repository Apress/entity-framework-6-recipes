using System;
using System.Collections.Generic;
using System.Data.Entity.Core.EntityClient;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe2
{
    public class EFRecipesEntities : ObjectContext
    {
        private ObjectSet<Customer> customers;
        public EFRecipesEntities(EntityConnection cn)
            : base(cn)
        {
        }

        public ObjectSet<Customer> Customers
        {
            get
            {
                return customers ?? (customers = CreateObjectSet<Customer>());
            }
        }
    }

}

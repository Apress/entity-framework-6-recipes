using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe11
{
    public partial class Recipe11Context
    {
        public override int SaveChanges()
        {
            Validate();
            
            return base.SaveChanges();
        }

        public void Validate()
        {
            var entities = ((IObjectContextAdapter)this).ObjectContext.ObjectStateManager
                                .GetObjectStateEntries(EntityState.Added |
                                                        EntityState.Modified)
                                .Select(et => et.Entity as Member);
            foreach (var member in entities)
            {
                if (member is Teen && member.Age > 19)
                {
                    throw new ApplicationException("Entity validation failed");
                }
                else if (member is Adult && (member.Age < 20 || member.Age >= 55))
                {
                    throw new ApplicationException("Entity validation failed");
                }
                else if (member is Senior && member.Age < 55)
                {
                    throw new ApplicationException("Entity validation failed");
                }
            }
        }
    }

}

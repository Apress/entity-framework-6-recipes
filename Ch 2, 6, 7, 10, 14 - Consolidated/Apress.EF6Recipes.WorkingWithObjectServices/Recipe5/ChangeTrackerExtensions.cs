using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe5
{
    public static class ChangeTrackerExtensions
    {
        public static IEnumerable<T> GetEntities<T>(this DbChangeTracker tracker)
        {
            var entrySet = tracker.Entries();
            var entities = tracker
                     .Entries()
                     .Where(entry => entry.State != EntityState.Detached && entry.Entity != null)
                     .Select(entry => entry.Entity).OfType<T>();
            return entities;
        }
    }

}

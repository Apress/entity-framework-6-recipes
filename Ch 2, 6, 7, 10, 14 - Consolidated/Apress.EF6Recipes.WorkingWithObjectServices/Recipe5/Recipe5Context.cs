using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe5
{
    public class Recipe5Context : DbContext
    {
        public DbSet<Technician> Technicians { get; set; }
        public DbSet<ServiceCall> ServiceCalls { get; set; }

        public Recipe5Context() : base("name=EF6CodeFirstRecipesContext")
        {
        }
    }
}

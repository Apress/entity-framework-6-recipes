using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe6
{
    public class Recipe6Context : DbContext
    {
        public DbSet<Drug> Drugs { get; set; }

        public Recipe6Context() : base("name=EF6CodeFirstRecipesContext")
        {}

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Experimental>()
                        .Map(m => m.Requires("AcceptedDate").HasValue((DateTime?)null));
            modelBuilder.Entity<Medicine>()
                        .Map(m => m.Requires(d => d.AcceptedDate).HasValue());
        }


    }
}

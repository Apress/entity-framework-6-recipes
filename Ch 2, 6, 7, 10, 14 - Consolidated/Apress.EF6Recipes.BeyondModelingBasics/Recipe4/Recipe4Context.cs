using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe4
{
    public class Recipe4Context : DbContext
    {
        public DbSet<Person> People { get; set; }

        public Recipe4Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Person>()
                        .HasMany(p => p.Fans)
                        .WithOptional(p => p.Hero)
                        .Map(m => m.MapKey("HeroId"));

            modelBuilder.Entity<Person>()
                        .Map<Firefighter>(m => m.Requires("Role").HasValue("f"))
                        .Map<Teacher>(m => m.Requires("Role").HasValue("t"))
                        .Map<Retired>(m => m.Requires("Role").HasValue("r"));
        }
    }
}

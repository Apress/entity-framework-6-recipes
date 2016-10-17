using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe2
{
    public class Recipe2Context : DbContext
    {
        public DbSet<Agent> Agents { get; set; }
        
        public Recipe2Context()
            : base("name=EF6CodeFirstRecipesContext")
        {
            Database.SetInitializer<Recipe2Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder
                .Entity<Agent>()
                .MapToStoredProcedures(agent =>
                                           {
                                               agent.Insert(i => i.HasName("Chapter14.InsertAgent"));
                                               agent.Update(u => u.HasName("Chapter14.UpdateAgent"));
                                               agent.Delete(d => d.HasName("Chapter14.DeleteAgent"));
                                           });

        }
    }
}

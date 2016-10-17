using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe7
{
    public class Recipe7Context : DbContext
    {
        public DbSet<Photograph> Photographs { get; set; }
        public DbSet<PhotographFullImage> PhotographFullImages { get; set; }

        public Recipe7Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Photograph>()
                        .HasRequired(p => p.PhotographFullImage)
                        .WithRequiredPrincipal(p => p.Photograph);

            modelBuilder.Entity<Photograph>().ToTable("Photograph", "Chapter2");
            modelBuilder.Entity<PhotographFullImage>().ToTable("Photograph", "Chapter2");
        }
    }
}

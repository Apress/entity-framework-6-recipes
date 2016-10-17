using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe5
{
    public class Recipe5Context : DbContext
    {
        public DbSet<PictureCategory> PictureCategories { get; set; }

        public Recipe5Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<PictureCategory>()
                        .HasMany(cat => cat.Subcategories)
                        .WithOptional(cat => cat.ParentCategory);
        }
    }
}

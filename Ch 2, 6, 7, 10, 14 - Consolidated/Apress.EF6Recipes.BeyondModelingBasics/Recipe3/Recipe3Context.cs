using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe3
{
    public class Recipe3Context : DbContext
    {
        public DbSet<Product> Products { get; set; }

        public Recipe3Context() : base("name=EF6CodeFirstRecipesContext")
        {}

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Product>()
                        .HasMany(p => p.RelatedProducts)
                        .WithMany(p => p.OtherRelatedProducts)
                        .Map(m =>
                                 {
                                     m.MapLeftKey("ProductId");
                                     m.MapRightKey("RelatedProductId");
                                     m.ToTable("RelatedProduct", "Chapter6");
                                 });
        }
    }
}

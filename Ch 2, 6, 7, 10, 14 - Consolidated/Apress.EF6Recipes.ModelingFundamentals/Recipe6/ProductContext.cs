using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe6
{
    public class Recipe6Context : DbContext
    {
        public DbSet<Product> Products { get; set; }

        public Recipe6Context() : base("name=EF6CodeFirstRecipesContext")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Product>()
                        .Map(m =>
                                 {
                                     m.Properties(p => new {p.SKU, p.Description, p.Price});
                                     m.ToTable("Product", "Chapter2");
                                 })
                        .Map(m =>
                                 {
                                     m.Properties(p => new {p.SKU, p.ImageURL});
                                     m.ToTable("ProductWebInfo", "Chapter2");
                                 });
        }
    }
}

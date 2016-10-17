using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe5
{
    public class Recipe5Context : DbContext
    {
        public DbSet<Category> Categories { get; set; }

        public Recipe5Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Category>()
                        .HasOptional(c => c.ParentCategory)
                        .WithMany(c => c.SubCategories)
                        .Map(m => m.MapKey("ParentCategoryId"));
        }

        public ICollection<Category> GetSubCategories(int categoryId)
        {
            return this.Database.SqlQuery<Category>("exec Chapter6.GetSubCategories @catId",
                                                    new SqlParameter("@catId", categoryId)).ToList();
        }
    }
}

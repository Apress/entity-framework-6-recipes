using System.Data.Entity;

namespace Recipe13
{
    public class Recipe13Context : DbContext
    {
        public Recipe13Context()
            : base("Recipe13ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe13Context>(null);
        }

        public DbSet<Category> Categories { get; set; }
        public DbSet<Movie> Movies { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Category>().ToTable("Chapter5.Category");
            modelBuilder.Entity<Movie>().ToTable("Chapter5.Movie");
        }
    }
}
using System.Data.Entity;

namespace Recipe3
{
    public class Recipe3Context : DbContext
    {
        public Recipe3Context()
            : base("Recipe3ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe3Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
             modelBuilder.Entity<Club>().ToTable("Chapter5.Club");
        }

        public DbSet<Club> Clubs { get; set; }
    }
}
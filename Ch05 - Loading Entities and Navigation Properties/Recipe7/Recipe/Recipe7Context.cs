using System.Data.Entity;

namespace Recipe7
{
    public class Recipe7Context : DbContext
    {
        public Recipe7Context()
            : base("Recipe7ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe7Context>(null);
        }

        public DbSet<Club> Clubs { get; set; }
        public DbSet<Event> Events { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Club>().ToTable("Chapter5.Club");
            modelBuilder.Entity<Event>().ToTable("Chapter5.Event");
        }
    }
}
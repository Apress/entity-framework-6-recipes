using System.Data.Entity;

namespace AsyncEntityFramework
{
    public class Recipe15Context : DbContext
    {
        public Recipe15Context()
            : base("Recipe16ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe15Context>(null);
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
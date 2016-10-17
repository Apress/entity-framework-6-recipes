using System.Data.Entity;

namespace Recipe4
{
    public class Recipe4Context : DbContext
    {
        public Recipe4Context()
            : base("Recipe4ConnectionString")
        {
            // disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe4Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Reservation>().ToTable("Chapter13.Reservation");
        }

        public DbSet<Reservation> Reservations { get; set; }
    }
}
using System.Data.Entity;

namespace Recipe3
{
    public class Recipe3Context : DbContext
    {
        public Recipe3Context()
            : base("Recipe3ConnectionString")
        {
            // disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe3Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Appointment>().ToTable("Chapter13.Appointment");
            modelBuilder.Entity<Company>().ToTable("Chapter13.Company");
            modelBuilder.Entity<Doctor>().ToTable("Chapter13.Doctor");
        }

        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<Company> Companies { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
    }
}
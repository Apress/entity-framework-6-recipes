using System.Data.Entity;

namespace Recipe11
{
    public class Recipe11Context : DbContext
    {
        public Recipe11Context()
            : base("Recipe11ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe11Context>(null);
        }

        public DbSet<Contractor> Contractors { get; set; }
        public DbSet<Manager> Managers { get; set; }
        public DbSet<Project> Projects { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Contractor>().ToTable("Chapter5.Contractor");
            modelBuilder.Entity<Manager>().ToTable("Chapter5.Manager");
            modelBuilder.Entity<Project>().ToTable("Chapter5.Project");

            // Explilcitly map key for Contractor entity
            modelBuilder.Entity<Contractor>().HasKey(x => x.ContracterID);
        }
    }
}
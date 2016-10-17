using System.Data.Entity;

namespace Recipe5
{
    public class Recipe5Context : DbContext
    {
        public Recipe5Context()
            : base("Recipe5ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe5Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Account>().ToTable("Chapter13.Account");
            modelBuilder.Entity<Payment>().ToTable("Chapter13.Payment");
        }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<Payment> Payments { get; set; }
    }
}
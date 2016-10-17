using System.Data.Entity;

namespace Recipe10
{
    public class Recipe9Context : DbContext
    {
        public Recipe9Context()
            : base("Recipe9ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe9Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // explicilty specify primary key for CreditCard
            modelBuilder.Entity<CreditCard>().HasKey(x => x.CardNumber);

            modelBuilder.Entity<Customer>().ToTable("Chapter13.Customer");
            modelBuilder.Entity<CreditCard>().ToTable("Chapter13.CreditCard");
            modelBuilder.Entity<Transaction>().ToTable("Chapter13.Transaction");
        }

        public DbSet<CreditCard> CreditCards { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
    }
}
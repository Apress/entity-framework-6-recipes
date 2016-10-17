using System.Data.Entity;

namespace Recipe3_19
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Order> Orders { get; set; }
        public DbSet<Account> Accounts { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Account>().ToTable("Chapter3.Account");
            modelBuilder.Entity<Order>().ToTable("Chapter3.Order");

            base.OnModelCreating(modelBuilder);
        }
    }
}
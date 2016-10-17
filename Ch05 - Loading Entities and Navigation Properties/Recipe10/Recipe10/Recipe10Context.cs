using System.Data.Entity;

namespace Recipe10
{
    public class Recipe10Context : DbContext
    {
        public Recipe10Context()
            : base("Recipe10ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe10Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Order>().ToTable("Chapter5.Order");
            modelBuilder.Entity<OrderItem>().ToTable("Chapter5.OrderItem");
        }

        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
    }
}
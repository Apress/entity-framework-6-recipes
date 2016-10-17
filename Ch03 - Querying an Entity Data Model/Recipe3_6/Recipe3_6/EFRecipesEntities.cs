using System.Data.Entity;

namespace Recipe3_6
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Employee> Employees { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Employee>().ToTable("Chapter3.Employee");
            base.OnModelCreating(modelBuilder);
        }
    }
}
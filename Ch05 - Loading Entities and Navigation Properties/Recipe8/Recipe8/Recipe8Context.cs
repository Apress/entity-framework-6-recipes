using System.Data.Entity;

namespace Recipe8
{
    public partial class Recipe8Context : DbContext
    {
        public Recipe8Context()
            : base("Recipe8ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe8Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Company>().ToTable("Chapter5.Company");
            modelBuilder.Entity<Employee>().ToTable("Chapter5.Employee");
            modelBuilder.Entity<Department>().ToTable("Chapter5.Department");
        }

        public DbSet<Company> Companies { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Employee> Employees { get; set; }
    }
}
using System.Data.Entity;

namespace Recipe3_3
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString")
        {
        }

        public DbSet<Student> Students { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Student>().ToTable("Chapter3.Student");
            base.OnModelCreating(modelBuilder);
        }
    }
}
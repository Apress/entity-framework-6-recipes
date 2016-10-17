using System.Data.Entity;

namespace Recipe3_13
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Registration> Registrations { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Registration>().ToTable("Chapter3.Registration");
            base.OnModelCreating(modelBuilder);
        }
    }
}
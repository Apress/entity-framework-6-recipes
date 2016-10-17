using System.Data.Entity;

namespace Recipe3_9
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Accident> Accidents { get; set; }
        public DbSet<Worker> Workers { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Accident>().ToTable("Chapter3.Accident");
            modelBuilder.Entity<Worker>().ToTable("Chapter3.Worker");
            base.OnModelCreating(modelBuilder);
        }
    }
}
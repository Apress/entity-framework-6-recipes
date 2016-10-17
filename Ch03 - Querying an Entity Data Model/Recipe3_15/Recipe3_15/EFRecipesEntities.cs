using System.Data.Entity;

namespace Recipe3_15
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Event> Events { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Event>().ToTable("Chapter3.Event");
            base.OnModelCreating(modelBuilder);
        }
    }
}
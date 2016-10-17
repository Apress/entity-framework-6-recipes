using System.Data.Entity;

namespace Recipe3_11
{
    public class EFRecipesEntities : DbContext
    {
        public EFRecipesEntities()
            : base("ConnectionString") {}

        public DbSet<Media> Media { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Media>().ToTable("Chapter3.Media");

            // Map child entities to the 'Discriminator' column, MediaType, from parent table,
            // which will determine the type of medium 
            modelBuilder.Entity<Media>().Map<Article>(x => x.Requires("MediaType").HasValue(1));
            modelBuilder.Entity<Media>().Map<Picture>(x => x.Requires("MediaType").HasValue(2));
            modelBuilder.Entity<Media>().Map<Video>(x => x.Requires("MediaType").HasValue(3));

            base.OnModelCreating(modelBuilder);
        }
    }
}
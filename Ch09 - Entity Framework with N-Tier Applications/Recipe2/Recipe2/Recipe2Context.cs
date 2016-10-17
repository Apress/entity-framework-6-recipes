using System.Data.Entity;

namespace Recipe2
{
    public class Recipe2Context : DbContext
    {
        public Recipe2Context()
            : base("Recipe2ConnectionString")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>().ToTable("Chapter9.Post");
            modelBuilder.Entity<Comment>().ToTable("Chapter9.Comment");
        }

        public DbSet<Comment> Comments { get; set; }
        public DbSet<Post> Posts { get; set; }
    }
}
using System.Data.Entity;

namespace Recipe2
{
    public class Recipe2Context : DbContext
    {
        public Recipe2Context()
            : base("Recipe2ConnectionString")
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe2Context>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // map AccessionNumber as primary key to table
            modelBuilder.Entity<Painting>().HasKey(x => x.AccessionNumber);
            modelBuilder.Entity<Painting>().ToTable("Chapter13.Painting");
        }

        public DbSet<Painting> Paintings { get; set; }
    }
}
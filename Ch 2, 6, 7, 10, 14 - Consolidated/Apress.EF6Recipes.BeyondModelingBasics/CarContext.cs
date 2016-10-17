using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics
{
    public class CarContext : DbContext
    {
        public DbSet<Car> Cars { get; set; }
        public DbSet<Dealer> Dealers { get; set; }

        public CarContext() : base("name=EF6CodeFirstRecipesContext")
        {}

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Toyota>()
                        .Map(m =>
                                 {
                                     m.MapInheritedProperties();
                                     m.ToTable("Toyota", "Chapter6");
                                 });

            modelBuilder.Entity<BMW>()
                        .Map(m =>
                                 {
                                     m.MapInheritedProperties();
                                     m.ToTable("BMW", "Chapter6");
                                 });

            modelBuilder.Entity<Car>()
                        .HasRequired(c => c.Dealer)
                        .WithMany(d => d.Cars)
                        .Map(m =>
                                 {
                                     m.MapKey("DealerId").ToTable("CarDealer", "Chapter6");
                                     m.MapKey("CarId").ToTable("CarDealer", "Chapter6");
                                 })
            ;
        }
    }
}

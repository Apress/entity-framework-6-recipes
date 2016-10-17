using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Recipe4.Service.DAL
{
    public class Recipe4Context : DbContext
    {
        public Recipe4Context() : base("Recipe4ConnectionString") { }

        public DbSet<Customer> Customers { get; set; }
        public DbSet<Phone> Phones { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // Do not persist TrackingState property to data store
            // This property is used internally to track state of
            // disconnected entities across service boundaries.
            modelBuilder.Entity<Customer>().Ignore(x => x.TrackingState);
            modelBuilder.Entity<Phone>().Ignore(x => x.TrackingState);
            modelBuilder.Entity<Customer>().ToTable("Chapter9.Customer");
            modelBuilder.Entity<Phone>().ToTable("Chapter9.Phone");
        }
    }
}
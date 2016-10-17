using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Recipe1Service.DAL
{
    public class Recipe1Context : DbContext
    {
        public Recipe1Context() : base("Recipe1ConnectionString") { }
        
        public DbSet<Order> Orders { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Order>().ToTable("Chapter9.Order");
            // Following configuration enables timestamp to be concurrency token
            modelBuilder.Entity<Order>().Property(x => x.TimeStamp)
                .IsConcurrencyToken()
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Computed);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Recipe3.Service.DAL
{
    public class Recipe3Context : DbContext
    {
        public Recipe3Context() : base("Recipe3ConnectionString") { }
        
        public DbSet<TravelAgent> TravelAgents { get; set; }
        public DbSet<Booking> Bookings { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TravelAgent>().HasKey(x => x.AgentId);
            modelBuilder.Entity<TravelAgent>().ToTable("Chapter9.TravelAgent");
            modelBuilder.Entity<Booking>().ToTable("Chapter9.Booking");
        }
    }
}
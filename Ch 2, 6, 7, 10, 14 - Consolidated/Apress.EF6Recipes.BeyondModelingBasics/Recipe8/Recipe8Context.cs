using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe8
{
    public class Recipe8Context : DbContext
    {
        public DbSet<Employee> Employees { get; set; }

        public Recipe8Context() : base("name=EF6CodeFirstRecipesContext")
        {}

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Employee>()
                        .HasKey(e => e.EmployeeId)
                        .Property(e => e.EmployeeId)
                        .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            modelBuilder.Entity<Employee>()
                        .Map<HourlyEmployee>(m => m.Requires("EmployeeType").HasValue("hourly"))
                        .Map<SalariedEmployee>(m => m.Requires("EmployeeType").HasValue("salaried"))
                        .Map<CommissionedEmployee>(m => m.Requires("EmployeeType").HasValue("commissioned"))
                        .ToTable("Employee", "Chapter6");
        }
    }
}

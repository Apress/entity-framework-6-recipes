using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe10
{
    public class Recipe10Context : DbContext
    {
        public DbSet<Employee> Employees { get; set; }

        public Recipe10Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Employee>()
                        .Map<FullTimeEmployee>(m => m.Requires("EmployeeType").HasValue(1))
                        .Map<HourlyEmployee>(m => m.Requires("EmployeeType").HasValue(2));
        }
    }
}

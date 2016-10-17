using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe1
{
    public class Recipe1Context : DbContext
    {
        public DbSet<Customer> Customers { get; set; }

        public Recipe1Context()
            : base("name=EF6CodeFirstRecipesContext")
        {

        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Types<Customer>()
                        .Configure(c =>
                        {
                            c.HasKey(cust => cust.CustomerId);

                            c.Property(cust => cust.CustomerId)
                             .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

                            c.Property(cust => cust.Name)
                             .HasMaxLength(50);

                            c.Property(cust => cust.Company)
                             .HasMaxLength(50);

                            c.Property(cust => cust.ContactTitle)
                             .HasMaxLength(50);

                            c.ToTable("Customer", "Chapter10");
                        });
        }

        public ICollection<Customer> GetCustomers(string company, string contactTitle)
        {
            return Database.SqlQuery<Customer>("EXEC Chapter10.GetCustomers @Company, @ContactTitle"
                                               , new SqlParameter("Company", company)
                                               , new SqlParameter("ContactTitle", contactTitle))
                                               .ToList();
        }
    }
}

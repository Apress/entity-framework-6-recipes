using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe7
{
    public class Recipe7Context : DbContext
    {
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<LineItem> LineItems { get; set; }
        
        public Recipe7Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Configurations.Add(new InvoiceTypeConfiguration());
            modelBuilder.Configurations.Add(new LineItemTypeConfiguration());
        }
    }

    public class InvoiceTypeConfiguration : EntityTypeConfiguration<Invoice>
    {
        public InvoiceTypeConfiguration()
        {
            HasKey(i => i.InvoiceNumber);
            Property(i => i.InvoiceNumber)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            HasMany(i => i.LineItems)
                .WithRequired(l => l.Invoice);
            ToTable("Invoice", "Chapter7");
        }
    }

    public class LineItemTypeConfiguration : EntityTypeConfiguration<LineItem>
    {
        public LineItemTypeConfiguration()
        {
            HasKey(item => new {item.InvoiceNumber, item.ItemNumber});
            Property(item => item.ItemNumber)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            ToTable("LineItem", "Chapter7");
        }
    }
}

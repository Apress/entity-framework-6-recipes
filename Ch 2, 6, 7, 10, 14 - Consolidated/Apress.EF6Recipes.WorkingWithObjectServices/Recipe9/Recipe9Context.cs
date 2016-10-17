using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe9
{
    public class Recipe9Context : DbContext
    {
        public DbSet<Account> Accounts { get; set; }
        public DbSet<Transaction> Transactions { get; set; }

        public Recipe9Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Configurations.Add(new AccountTypeConfiguration());
            modelBuilder.Configurations.Add(new TransactionTypeConfiguration());
        }
    }

    public class AccountTypeConfiguration : EntityTypeConfiguration<Account>
    {
        public AccountTypeConfiguration()
        {
            HasKey(a => a.AccountNumber);

            Property(a => a.AccountNumber)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            HasMany(a => a.Transactions)
                .WithRequired();
        }
    }

    public class TransactionTypeConfiguration : EntityTypeConfiguration<Transaction>
    {
        public TransactionTypeConfiguration()
        {
            HasKey(t => new {t.AccountNumber, t.TransactionNumber});

            Property(t => t.TransactionNumber)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
        }
    }
}

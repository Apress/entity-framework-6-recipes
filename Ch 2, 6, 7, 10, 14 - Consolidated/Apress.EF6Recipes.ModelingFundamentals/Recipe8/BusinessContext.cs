using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe8
{
    public class Recipe8Context : DbContext
    {
        public DbSet<Business> Businesses { get; set; }
    }
}

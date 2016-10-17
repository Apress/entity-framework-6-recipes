using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe6
{
    public class Recipe6Context : DbContext
    {
        public DbSet<Person> People { get; set; }

        public Recipe6Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }
    }
}

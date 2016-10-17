using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe2
{
    public class Recipe2Context : DbContext
    {
        public DbSet<Worker> Workers { get; set; }
        public DbSet<Task> Tasks { get; set; }
        public DbSet<WorkerTask> WorkerTasks { get; set; }

        public Recipe2Context() : base("name=EF6CodeFirstRecipesContext")
        {
            
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe1
{
    public static class Recipe1Program
    {
        public static void Run()
        {
            Console.WriteLine(String.Format("The current connection string is: {0}", ConnectionStringManager.EFConnection));
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            Recipe1.Recipe1Program.Run();
            Recipe2.Recipe2Program.Run();
            Recipe3.Recipe3Program1.Run();
            Recipe3.Recipe3Program2.Run();
            Recipe4.Recipe4Program.Run();
            Console.ReadKey(true);

        }

    }
}
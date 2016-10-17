using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity.Design.PluralizationServices;
using System.Globalization;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe4
{
    public static class Recipe4Program
    {
        public static void Run()
        {
            var service = PluralizationService.CreateService(new CultureInfo("en-US"));
            string person = "Person";
            string people = "People";
            Console.WriteLine("The plural of {0} is {1}", person,
             service.Pluralize(person));
            Console.WriteLine("The singular of {0} is {1}", people,
             service.Singularize(people));
        }
    }
}

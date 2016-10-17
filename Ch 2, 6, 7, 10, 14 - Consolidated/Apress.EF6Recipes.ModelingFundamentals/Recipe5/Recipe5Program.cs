using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe5
{
    public static class Recipe5Program
    {
        public static void Run()
        {
            using (var context = new Recipe5Context())
            {
                var louvre = new PictureCategory { Name = "Louvre" };
                var child = new PictureCategory { Name = "Egyptian Antiquites" };
                louvre.Subcategories.Add(child);
                child = new PictureCategory { Name = "Sculptures" };
                louvre.Subcategories.Add(child);
                child = new PictureCategory { Name = "Paintings" };
                louvre.Subcategories.Add(child);
                var paris = new PictureCategory { Name = "Paris" };
                paris.Subcategories.Add(louvre);
                var vacation = new PictureCategory { Name = "Summer Vacation" };
                vacation.Subcategories.Add(paris);
                context.PictureCategories.Add(paris);
                context.SaveChanges();
            }

            using (var context = new Recipe5Context())
            {
                var roots = context.PictureCategories.Where(c => c.ParentCategory == null).ToList();
                roots.ForEach(root => Print(root, 0));
            }
        }

        public static void Print(PictureCategory cat, int level)
        {
            StringBuilder sb = new StringBuilder();
            Console.WriteLine("{0}{1}", sb.Append(' ', level).ToString(), cat.Name);
            cat.Subcategories.ForEach(child => Print(child, level + 1));
        }

    }
}

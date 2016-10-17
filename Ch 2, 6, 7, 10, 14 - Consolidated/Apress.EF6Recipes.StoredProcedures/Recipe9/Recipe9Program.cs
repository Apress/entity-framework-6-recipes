using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe9
{
    public static class Recipe9Program
    {
        public static void Run()
        {
            using (var context = new Recipe9Context())
            {
                var auth1 = new Author { Name = "Jane Austin" };
                var book1 = new Book
                {
                    Title = "Pride and Prejudice",
                    ISBN = "1848373104"
                };
                var book2 = new Book
                {
                    Title = "Sense and Sensibility",
                    ISBN = "1440469563"
                };
                auth1.Books.Add(book1);
                auth1.Books.Add(book2);
                var auth2 = new Author { Name = "Audrey Niffenegger" };
                var book3 = new Book
                {
                    Title = "The Time Traveler's Wife",
                    ISBN = "015602943X"
                };
                auth2.Books.Add(book3);
                context.Authors.Add(auth1);
                context.Authors.Add(auth2);
                context.SaveChanges();
                context.Books.Remove(book1);
                context.SaveChanges();
            }
            
        }
    }
}

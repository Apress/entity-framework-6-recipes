using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe3_8
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.book");
                context.Database.ExecuteSqlCommand("delete from chapter3.category");
                // add new test data                
                var cat1 = new Category {Name = "Programming"};
                var cat2 = new Category {Name = "Databases"};
                var cat3 = new Category {Name = "Operating Systems"};
                context.Books.Add(new Book {Title = "F# In Practice", Category = cat1});
                context.Books.Add(new Book {Title = "The Joy of SQL", Category = cat2});
                context.Books.Add(new Book
                {
                    Title = "Windows 7: The Untold Story",
                    Category = cat3
                });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Books (using LINQ)");
                var cats = new List<string> {"Programming", "Databases"};
                var books = from b in context.Books
                    where cats.Contains(b.Category.Name)
                    select b;
                foreach (var book in books)
                {
                    Console.WriteLine("'{0}' is in category: {1}", book.Title,
                        book.Category.Name);
                }
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("\nBooks (using eSQL)");
                var esql = @"select value b from Books as b
                 where b.Category.Name in {'Programming','Databases'}";
                var books = ((IObjectContextAdapter) context).ObjectContext.CreateQuery<Book>(esql);
                foreach (var book in books)
                {
                    Console.WriteLine("'{0}' is in category: {1}", book.Title,
                        book.Category.Name);
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
using System;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe3_5
{
    internal class Program
    {
        private static void Main()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.comment");
                context.Database.ExecuteSqlCommand("delete from chapter3.blogpost");
                // add new test data
                var post1 = new BlogPost
                {
                    Title = "The Joy of LINQ",
                    Description = "101 things you always wanted to know about LINQ"
                };
                var post2 = new BlogPost
                {
                    Title = "LINQ as Dinner Conversation",
                    Description = "What wine goes with a Lambda expression?"
                };
                var post3 = new BlogPost
                {
                    Title = "LINQ and our Children",
                    Description = "Why we need to teach LINQ in High School"
                };
                var comment1 = new Comment
                {
                    Comments = "Great post, I wish more people would talk about LINQ"
                };
                var comment2 = new Comment
                {
                    Comments = "You're right, we should teach LINQ in high school!"
                };
                post1.Comments.Add(comment1);
                post3.Comments.Add(comment2);
                context.BlogPosts.Add(post1);
                context.BlogPosts.Add(post2);
                context.BlogPosts.Add(post3);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Blog Posts with comments...(LINQ)");
                var posts = from post in context.BlogPosts
                    where post.Comments.Any()
                    select post;
                foreach (var post in posts)
                {
                    Console.WriteLine("Blog Post: {0}", post.Title);
                    foreach (var comment in post.Comments)
                    {
                        Console.WriteLine("\t{0}", comment.Comments);
                    }
                }
            }

            Console.WriteLine();

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Blog Posts with comments...(eSQL)");
                var esql = "select value p from BlogPosts as p where exists(p.Comments)";
                var posts = ((IObjectContextAdapter) context).ObjectContext.CreateQuery<BlogPost>(esql);
                foreach (var post in posts)
                {
                    Console.WriteLine("Blog Post: {0}", post.Title);
                    foreach (var comment in post.Comments)
                    {
                        Console.WriteLine("\t{0}", comment.Comments);
                    }
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
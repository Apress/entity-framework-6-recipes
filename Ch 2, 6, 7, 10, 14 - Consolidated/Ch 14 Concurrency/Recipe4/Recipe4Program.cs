using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.Concurrency.Recipe4
{
    public static class Recipe4Program
    {
        public static void Run()
        {
            using (var context = new Recipe4Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter14.ForumPost");
                context.SaveChanges();
            }
            
            int postId = 0;
            using (var context = new Recipe4Context())
            {
                // post is created
                var post = new ForumPost
                {
                    ForumUser = "FastEddie27",
                    IsActive = false,
                    Post = "The moderator is a great guy."
                };
                context.ForumPosts.Add(post);
                context.SaveChanges();
                postId = post.PostingId;
            }

            using (var context = new Recipe4Context())
            {
                // moderator gets post to review
                var post = context.ForumPosts.First(p => p.PostingId == postId);
                Console.WriteLine("Post by {0}: {1}", post.ForumUser, post.Post);

                // poster changes post out-of-band
                context.Database.ExecuteSqlCommand(@"update chapter14.forumpost 
             set post='The moderator''s mom dresses him funny.' 
             where postingId = @p0", new object[] { postId.ToString() });
                Console.WriteLine("Fast Eddie changes the post");

                // moderator doesn't trust Fast Eddie
                if (string.Compare(post.ForumUser, "FastEddie27") == 0)
                    post.IsActive = false;
                else
                    post.IsActive = true;

                try
                {
                    // refresh any changes to the TimeStamp
                    var postEntry = context.Entry(post);
                    postEntry.OriginalValues.SetValues(postEntry.GetDatabaseValues());
                    context.SaveChanges();
                    Console.WriteLine("No concurrency exception.");
                }
                catch (DbUpdateConcurrencyException exFirst)
                {
                    try
                    {
                        // try one more time.
                        var postEntry = context.Entry(post);
                        postEntry.OriginalValues.SetValues(postEntry.GetDatabaseValues());
                        context.SaveChanges();
                    }
                    catch (DbUpdateConcurrencyException exSecond)
                    {
                        // we tried twice...do something else
                    }
                }
            }
            
        }
    }
}

using System.Data.Entity;
using System.Linq;
using Recipe2;

namespace WcfService1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class Service1 : IService1
    {
        public void Cleanup()
        {
            using (var context = new Recipe2Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter9.comment");
                context.Database.ExecuteSqlCommand("delete from chapter9.post");
            }
        }

        public Post GetPostByTitle(string title)
        {
            using (var context = new Recipe2Context())
            {
                context.Configuration.ProxyCreationEnabled = false;
                context.Configuration.LazyLoadingEnabled = false;
                var post = context.Posts.Include("Comments").Single(p => p.Title == title);
                return post;
            }
        }

        public Post SubmitPost(Post post)
        {
            using (var context = new Recipe2Context())
            {
                context.Posts.Attach(post);
                if (post.PostId == 0)
                {
                    // this must be an insert
                    context.Entry(post).State = EntityState.Added;
                }
                else
                {
                    context.Entry(post).State = EntityState.Modified;
                }
                context.SaveChanges();
                return post;
            }
        }

        public Comment SubmitComment(Comment comment)
        {
            using (var context = new Recipe2Context())
            {
                context.Comments.Attach(comment);
                if (comment.CommentId == 0)
                {
                    // this is an insert
                    context.Entry(comment).State = EntityState.Added;
                }
                else
                {
                    // set single property to modified, which sets state of entity to modified, but
                    // only updates the single property – not the entire entity
                    context.Entry(comment).Property(x => x.CommentText).IsModified = true;
                }
                context.SaveChanges();
                return comment;
            }
        }

        public void DeleteComment(Comment comment)
        {
            using (var context = new Recipe2Context())
            {
                context.Entry(comment).State = EntityState.Deleted;
                context.SaveChanges();
            }
        }
    }
}
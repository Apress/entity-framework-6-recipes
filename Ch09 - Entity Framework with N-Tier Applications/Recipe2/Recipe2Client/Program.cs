using System;
using Recipe2;
using Recipe2Client.ServiceReference1;

namespace Recipe2Client
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var client = new Service1Client())
            {
                // cleanup previous data
                client.Cleanup();

                // insert a post
                var post = new Post { Title = "POCO Proxies" };
                post = client.SubmitPost(post);

                // update the post
                post.Title = "Change Tracking Proxies";
                client.SubmitPost(post);

                // add a comment
                var comment1 = new Comment { CommentText = "Virtual Properties are cool!", PostId = post.PostId };
                var comment2 = new Comment { CommentText = "I use ICollection<T> all the time", PostId = post.PostId };
                comment1 = client.SubmitComment(comment1);
                comment2 = client.SubmitComment(comment2);

                // update a comment
                comment1.CommentText = "How do I use ICollection<T>?";
                client.SubmitComment(comment1);

                // delete comment 1
                client.DeleteComment(comment1);

                // get posts with comments
                var p = client.GetPostByTitle("Change Tracking Proxies");
                Console.WriteLine("Comments for post: {0}", p.Title);
                foreach (var comment in p.Comments)
                {
                    Console.WriteLine("\tComment: {0}", comment.CommentText);
                }
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}

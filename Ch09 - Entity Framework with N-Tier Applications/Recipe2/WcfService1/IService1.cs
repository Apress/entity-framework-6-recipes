using System.ServiceModel;
using Recipe2;

namespace WcfService1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        void Cleanup();

        [OperationContract]
        Post GetPostByTitle(string title);

        [OperationContract]
        Post SubmitPost(Post post);

        [OperationContract]
        Comment SubmitComment(Comment comment);

        [OperationContract]
        void DeleteComment(Comment comment);
    }
}
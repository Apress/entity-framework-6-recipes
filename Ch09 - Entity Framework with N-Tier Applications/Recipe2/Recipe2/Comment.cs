using System.Runtime.Serialization;

namespace Recipe2
{
    [DataContract(IsReference = true)]
    public class Comment
    {
        [DataMember]
        public int CommentId { get; set; }

        [DataMember]
        public int PostId { get; set; }

        [DataMember]
        public string CommentText { get; set; }

        [DataMember]
        public virtual Post Post { get; set; }
    }
}
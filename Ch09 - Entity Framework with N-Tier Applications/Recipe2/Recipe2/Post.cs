using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Recipe2
{
    [DataContract(IsReference = true)]
    public class Post
    {
        public Post()
        {
            Comments = new HashSet<Comment>();
        }

        [DataMember]
        public int PostId { get; set; }

        [DataMember]
        public string Title { get; set; }

        [DataMember]
        public virtual ICollection<Comment> Comments { get; set; }
    }
}
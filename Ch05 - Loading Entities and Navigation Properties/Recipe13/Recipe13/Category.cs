using System.Collections.Generic;

namespace Recipe13
{
    public class Category
    {
        public Category()
        {
            Movies = new HashSet<Movie>();
        }

        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string ReleaseType { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
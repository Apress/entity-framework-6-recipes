//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CustomEFRecipe5
{
    using System;
    using System.Collections.Generic;
    
    public partial class Course
    {
        public Course()
        {
            this.Classes = new HashSet<Class>();
        }
    
        public int CourseId { get; set; }
        public string CourseName { get; set; }
    
        public virtual ICollection<Class> Classes { get; set; }
    }
}

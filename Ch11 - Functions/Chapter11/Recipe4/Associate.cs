//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FunctionsEFRecipe4
{
    using System;
    using System.Collections.Generic;
    
    public abstract partial class Associate
    {
        public Associate()
        {
            this.DirectReports = new HashSet<Associate>();
        }
    
        public int AssociateId { get; set; }
        public string Name { get; set; }
        public Nullable<int> ReportsTo { get; set; }
    
        public virtual ICollection<Associate> DirectReports { get; set; }
        public virtual Associate Manager { get; set; }
    }
}

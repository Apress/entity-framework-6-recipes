//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Apress.EF6Recipes.StoredProcedures.Recipe5
{
    using System;
    using System.Collections.Generic;
    
    public partial class Member
    {
        public Member()
        {
            this.Messages = new HashSet<Message>();
        }
    
        public int MemberId { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Message> Messages { get; set; }
    }
}

//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Recipe2
{
    using System;
    using System.Collections.Generic;
    
    public partial class Customer
    {
        public Customer()
        {
            this.CustomerEmails = new HashSet<CustomerEmail>();
        }
    
        public int CustomerId { get; set; }
        public string Name { get; set; }
        public int CustomerTypeId { get; set; }
    
        public virtual CustomerType CustomerType { get; set; }
        public virtual ICollection<CustomerEmail> CustomerEmails { get; set; }
    }
}

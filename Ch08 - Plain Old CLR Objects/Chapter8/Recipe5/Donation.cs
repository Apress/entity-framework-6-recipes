//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace POCORecipe55
{
    using System;
    using System.Collections.Generic;
    
    public partial class Donation
    {
        public int DonationId { get; set; }
        public Nullable<int> DonorId { get; set; }
        public decimal Amount { get; set; }
    
        public virtual Donor Donor { get; set; }
    }
}

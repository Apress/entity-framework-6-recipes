//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FunctionsEFRecipe6
{
    using System;
    using System.Collections.Generic;
    
    public partial class PatientVisit
    {
        public int VisitId { get; set; }
        public decimal Cost { get; set; }
        public string Hospital { get; set; }
        public int PatientId { get; set; }
    
        public virtual Patient Patient { get; set; }
    }
}

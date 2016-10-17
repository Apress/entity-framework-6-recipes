﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe7
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class Recipe7Context : DbContext
    {
        public Recipe7Context()
            : base("name=Recipe7Context")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Staff> Staffs { get; set; }
    
        public virtual int DeleteInstructor(Nullable<int> staffId)
        {
            var staffIdParameter = staffId.HasValue ?
                new ObjectParameter("StaffId", staffId) :
                new ObjectParameter("StaffId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteInstructor", staffIdParameter);
        }
    
        public virtual int DeletePrincipal(Nullable<int> staffId)
        {
            var staffIdParameter = staffId.HasValue ?
                new ObjectParameter("StaffId", staffId) :
                new ObjectParameter("StaffId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeletePrincipal", staffIdParameter);
        }
    
        public virtual ObjectResult<InsertInstructor_Result> InsertInstructor(string name, Nullable<decimal> salary)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var salaryParameter = salary.HasValue ?
                new ObjectParameter("Salary", salary) :
                new ObjectParameter("Salary", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<InsertInstructor_Result>("InsertInstructor", nameParameter, salaryParameter);
        }
    
        public virtual ObjectResult<InsertPrincipal_Result> InsertPrincipal(string name, Nullable<decimal> salary, Nullable<decimal> bonus)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var salaryParameter = salary.HasValue ?
                new ObjectParameter("Salary", salary) :
                new ObjectParameter("Salary", typeof(decimal));
    
            var bonusParameter = bonus.HasValue ?
                new ObjectParameter("Bonus", bonus) :
                new ObjectParameter("Bonus", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<InsertPrincipal_Result>("InsertPrincipal", nameParameter, salaryParameter, bonusParameter);
        }
    
        public virtual int UpdateInstructor(string name, Nullable<decimal> salary, Nullable<int> staffId, Nullable<int> instructorId)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var salaryParameter = salary.HasValue ?
                new ObjectParameter("Salary", salary) :
                new ObjectParameter("Salary", typeof(decimal));
    
            var staffIdParameter = staffId.HasValue ?
                new ObjectParameter("StaffId", staffId) :
                new ObjectParameter("StaffId", typeof(int));
    
            var instructorIdParameter = instructorId.HasValue ?
                new ObjectParameter("InstructorId", instructorId) :
                new ObjectParameter("InstructorId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateInstructor", nameParameter, salaryParameter, staffIdParameter, instructorIdParameter);
        }
    
        public virtual int UpdatePrincipal(string name, Nullable<decimal> salary, Nullable<decimal> bonus, Nullable<int> staffId, Nullable<int> principalId)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var salaryParameter = salary.HasValue ?
                new ObjectParameter("Salary", salary) :
                new ObjectParameter("Salary", typeof(decimal));
    
            var bonusParameter = bonus.HasValue ?
                new ObjectParameter("Bonus", bonus) :
                new ObjectParameter("Bonus", typeof(decimal));
    
            var staffIdParameter = staffId.HasValue ?
                new ObjectParameter("StaffId", staffId) :
                new ObjectParameter("StaffId", typeof(int));
    
            var principalIdParameter = principalId.HasValue ?
                new ObjectParameter("PrincipalId", principalId) :
                new ObjectParameter("PrincipalId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdatePrincipal", nameParameter, salaryParameter, bonusParameter, staffIdParameter, principalIdParameter);
        }
    }
}

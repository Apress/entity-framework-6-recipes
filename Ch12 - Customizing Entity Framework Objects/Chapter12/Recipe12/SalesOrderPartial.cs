using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace CustomEFRecipe12
{

    public interface IValidator
    {
        void Validate(DbEntityEntry entry);
    }
    public partial class SalesOrder : IValidator
    {
        public void Validate(DbEntityEntry entry)
        {
            if (entry.State == EntityState.Added)
            {
                if (this.OrderDate > DateTime.Now)
                    throw new ApplicationException(
                      "OrderDate cannot be after the current date");
            }
            else if (entry.State == EntityState.Modified)
            {
                if (this.ShippedDate < this.OrderDate)
                {
                    throw new ApplicationException(
                      "ShippedDate cannot be before OrderDate");
                }
                if (this.Shipped.Value && this.Status != "Approved")
                {
                    throw new ApplicationException(
                      "Order cannot be shipped unless it is Approved");
                }
                if (this.Amount > 5000M && this.ShippingCharge != 0)
                {
                    throw new ApplicationException(
                      "Orders over $5000 ship for free");
                }
            }
            else if (entry.State == EntityState.Deleted)
            {
                if (this.Shipped.Value)
                    throw new ApplicationException(
                      "Shipped orders cannot be deleted");
            }
        }
    }
}

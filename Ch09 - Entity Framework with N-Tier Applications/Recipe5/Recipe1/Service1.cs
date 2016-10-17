using System.Data.Entity;

namespace Recipe1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class Service1 : IService1
    {
        public Payment InsertPayment()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous text data
                context.Database.ExecuteSqlCommand("delete from chapter9.payment");
                context.Database.ExecuteSqlCommand("delete from chapter9.invoice");

                var payment = new Payment {Amount = 99.95M, Invoice = new Invoice {Description = "Auto Repair"}};
                context.Payments.Add(payment);
                context.SaveChanges();
                return payment;
            }
        }

        public void DeletePayment(Payment payment)
        {
            using (var context = new EFRecipesEntities())
            {
                context.Entry(payment).State = EntityState.Deleted;
                context.SaveChanges();
            }
        }
    }
}
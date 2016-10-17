using System;
using System.Collections.Generic;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe3
{
	class Program
	{
        static void Main(string[] args)
        {
            Cleanup();
            RunExample();
        }

        static void Cleanup()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter12.donation");
            }
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Donations.Add(new Donation
                {
                    DonorName = "Robert Byrd",
                    Amount = 350M
                });
                context.Donations.Add(new Donation
                {
                    DonorName = "Nancy McVoid",
                    Amount = 250M
                });
                context.Donations.Add(new Donation
                {
                    DonorName = "Kim Kerns",
                    Amount = 750M
                });
                Console.WriteLine("About to SaveChanges()");
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var list = context.Donations.Where(o => o.Amount > 300M);
                Console.WriteLine("Donations over $300");
                foreach (var donor in list)
                {
                    Console.WriteLine("{0} gave {1}", donor.DonorName,
                                       donor.Amount.ToString("C"));
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
	}
    public partial class EFRecipesEntities
    {
        public override int SaveChanges()
        {
            this.Database.Connection.StateChange += (s, e) =>
            {
                var conn = ((SqlConnection) s);
                Console.WriteLine("{0}: Database: {1}, State: {2}, was: {3}",
                    DateTime.Now.ToShortTimeString(), conn.Database,
                    e.CurrentState, e.OriginalState);
            };
            return base.SaveChanges();
        }
    }
}
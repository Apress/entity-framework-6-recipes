using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe55;
namespace POCORecipe5
{
	class Program
	{
		static void Main(string[] args)
		{
			RunExample();
		}

		static void RunExample()
		{
			using (var context = new EFRecipesEntities())
			{
				var donation = context.Donations.Create();
				donation.Amount = 5000M;

				var donor1 = context.Donors.Create();
				donor1.Name = "Jill Rosenberg";
				var donor2 = context.Donors.Create();
				donor2.Name = "Robert Hewitt";

				// give Jill the credit for the donation and save
				donor1.Donations.Add(donation);
				context.Donors.Add(donor1);
				context.Donors.Add(donor2);
				context.SaveChanges();

				// now give Robert the credit
				donation.Donor = donor2;

				// report
				foreach (var donor in context.Donors)
				{
					Console.WriteLine("{0} has given {1} donation(s)", donor.Name,
									   donor.Donations.Count().ToString());
				}
				Console.WriteLine("Original Donor Id: {0}",
					context.Entry(donation).OriginalValues["DonorId"]);
				Console.WriteLine("Current Donor Id: {0}",
								   context.Entry(donation).CurrentValues["DonorId"]);
			}
		}
	}
}

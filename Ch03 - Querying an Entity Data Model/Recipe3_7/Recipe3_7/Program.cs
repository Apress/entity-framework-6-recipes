using System;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;

namespace Recipe3_7
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                var job1 = new Job {JobDetails = "Re-surface Parking Log"};
                var job2 = new Job {JobDetails = "Build Driveway"};
                job1.Bids.Add(new Bid {Amount = 948M, Bidder = "ABC Paving"});
                job1.Bids.Add(new Bid {Amount = 1028M, Bidder = "TopCoat Paving"});
                job2.Bids.Add(new Bid {Amount = 502M, Bidder = "Ace Concrete"});
                context.Jobs.Add(job1);
                context.Jobs.Add(job2);
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                var cs = @"Data Source=.;Initial Catalog=EFRecipes;Integrated Security=True";
                var conn = new SqlConnection(cs);
                var cmd = conn.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "Chapter3.GetBidDetails";
                conn.Open();
                var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                var jobs = ((IObjectContextAdapter) context).ObjectContext.Translate<Job>(reader, "Jobs",
                    MergeOption.AppendOnly).ToList();
                reader.NextResult();
                ((IObjectContextAdapter) context).ObjectContext.Translate<Bid>(reader, "Bids", MergeOption.AppendOnly)
                    .ToList();
                foreach (var job in jobs)
                {
                    Console.WriteLine("\nJob: {0}", job.JobDetails);
                    foreach (var bid in job.Bids)
                    {
                        Console.WriteLine("\tBid: {0} from {1}",
                            bid.Amount.ToString(), bid.Bidder);
                    }
                }

                Console.WriteLine("\nPress <enter> to continue...");
                Console.ReadLine();
            }
        }
    }
}
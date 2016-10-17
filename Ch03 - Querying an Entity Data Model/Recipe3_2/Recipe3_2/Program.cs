using System;
using System.Data.Common;
using System.Data.SqlClient;

namespace Recipe3_2
{
    internal class Program
    {
        private static void Main()
        {
            // delete previous test data
            using (var context = new EFRecipesEntities())
            {
                context.Database.ExecuteSqlCommand("delete from chapter3.payment");
            }
            // insert two rows of data
            using (var context = new EFRecipesEntities())
            {
                var sql = @"insert into Chapter3.Payment(Amount, Vendor)
                   values (@Amount, @Vendor)";
                var parameters = new DbParameter[]
                    {
                        new SqlParameter {ParameterName = "Amount", Value = 99.97M},
                        new SqlParameter {ParameterName = "Vendor", Value = "Ace Plumbing"}
                    };

                var rowCount = context.Database.ExecuteSqlCommand(sql, parameters);

                parameters = new DbParameter[]
                    {
                        new SqlParameter {ParameterName = "Amount", Value = 43.83M},
                        new SqlParameter
                            {
                                ParameterName = "Vendor",
                                Value = "Joe's Trash Service"
                            }
                    };

                rowCount += context.Database.ExecuteSqlCommand(sql, parameters);
                Console.WriteLine("{0} rows inserted", rowCount.ToString());
            }

            // retrieve and materialize data
            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Payments");
                Console.WriteLine("========");
                foreach (var payment in context.Payments)
                {
                    Console.WriteLine("Paid {0} to {1}", payment.Amount.ToString(),
                                      payment.Vendor);
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
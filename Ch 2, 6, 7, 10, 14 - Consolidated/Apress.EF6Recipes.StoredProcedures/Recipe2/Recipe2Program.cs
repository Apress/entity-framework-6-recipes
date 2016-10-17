using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe2
{
    public static class Recipe2Program
    {
        public static void Run()
        {
            using (var context = new Recipe2Context())
            {
                var car1 = new Vehicle
                {
                    Manufacturer = "Toyota",
                    Model = "Camry",
                    Year = 2013
                };
                var car2 = new Vehicle
                {
                    Manufacturer = "Chevrolet",
                    Model = "Corvette",
                    Year = 2013
                };
                var r1 = new Rental
                {
                    Vehicle = car1,
                    RentalDate = DateTime.Parse("5/7/2013"),
                    Payment = 59.95M
                };
                var r2 = new Rental
                {
                    Vehicle = car2,
                    RentalDate = DateTime.Parse("5/7/2013"),
                    Payment = 139.95M
                };
                context.Rentals.Add(r1);
                context.Rentals.Add(r2);
                context.SaveChanges();
            }

            using (var context = new Recipe2Context())
            {
                string reportDate = "5/7/2013";
                var totalRentals = new ObjectParameter("TotalRentals", typeof(int));
                var totalPayments = new ObjectParameter("TotalPayments", typeof(decimal));
                var vehicles = context.GetVehiclesWithRentals(DateTime.Parse(reportDate),
                                 totalRentals, totalPayments);
                Console.WriteLine("Rental Activity for {0}", reportDate);
                Console.WriteLine("Vehicles Rented");
                foreach (var vehicle in vehicles)
                {
                    Console.WriteLine("{0} {1} {2}", vehicle.Year.ToString(),
                                       vehicle.Manufacturer, vehicle.Model);
                }
                Console.WriteLine("Total Rentals: {0}",
                                   ((int)totalRentals.Value).ToString());
                Console.WriteLine("Total Payments: {0}",
                                   ((decimal)totalPayments.Value).ToString("C"));
            }
            
        }
    }
}

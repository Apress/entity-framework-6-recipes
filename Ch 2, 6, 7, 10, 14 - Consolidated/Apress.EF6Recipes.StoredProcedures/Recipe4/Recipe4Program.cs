using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe4
{
    public static class Recipe4Program
    {
        public static void Run()
        {
            using (var context = new Recipe4Context())
            {
                var emp1 = new Employee
                {
                    Name = "Lisa Jefferies",
                    Address = new EmployeeAddress
                    {
                        address = "100 E. Main",
                        city = "Fort Worth",
                        state = "TX",
                        ZIP = "76106"
                    }
                };
                var emp2 = new Employee
                {
                    Name = "Robert Jones",
                    Address = new EmployeeAddress
                    {
                        address = "3920 South Beach",
                        city = "Fort Worth",
                        state = "TX",
                        ZIP = "76102"
                    }
                };
                var emp3 = new Employee
                {
                    Name = "Steven Chue",
                    Address = new EmployeeAddress
                    {
                        address = "129 Barker",
                        city = "Euless",
                        state = "TX",
                        ZIP = "76092"
                    }
                };
                var emp4 = new Employee
                {
                    Name = "Karen Stevens",
                    Address = new EmployeeAddress
                    {
                        address = "108 W. Parker",
                        city = "Fort Worth",
                        state = "TX",
                        ZIP = "76102"
                    }
                };
                context.Employees.Add(emp1);
                context.Employees.Add(emp2);
                context.Employees.Add(emp3);
                context.Employees.Add(emp4);
                context.SaveChanges();
            }

            using (var context = new Recipe4Context())
            {
                Console.WriteLine("Employee addresses in Fort Worth, TX");
                foreach (var address in context.GetEmployeeAddresses("Fort Worth"))
                {
                    Console.WriteLine("{0}, {1}, {2}, {3}", address.address,
                                       address.city, address.state, address.ZIP);
                }
            }
            
        }
    }
}

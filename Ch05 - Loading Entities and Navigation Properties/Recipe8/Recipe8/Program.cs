using System;
using System.Data.Entity;
using System.Linq;

namespace Recipe8
{
    internal class Program
    {
        private static void Main()
        {
            Cleanup();
            RunExample();
        }

        private static void Cleanup()
        {
            using (var context = new Recipe8Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter5.employee");
                context.Database.ExecuteSqlCommand("delete from chapter5.department");
                context.Database.ExecuteSqlCommand("delete from chapter5.company");
            }
        }

        private static void RunExample()
        {
            using (var context = new Recipe8Context())
            {
                var company = new Company {Name = "Acme Products"};
                var acc = new Department {Name = "Accounting", Company = company};
                var ship = new Department {Name = "Shipping", Company = company};
                var emp1 = new Employee {Name = "Jill Carpenter", Department = acc};
                var emp2 = new Employee {Name = "Steven Hill", Department = ship};
                context.Employees.Add(emp1);
                context.Employees.Add(emp2);
                context.SaveChanges();
            }

            // First approach
            using (var context = new Recipe8Context())
            {
                // Assume we already have an employee
                var jill = context.Employees.First(o => o.Name == "Jill Carpenter");

                // Get Jill's Department and Company, but we also reload Employees
                var results = context.Employees.Include("Department.Company")
                                     .First(o => o.EmployeeId == jill.EmployeeId);
                Console.WriteLine("{0} works in {1} for {2}", jill.Name, jill.Department.Name,
                                  jill.Department.Company.Name);
            }

            // More efficient approach, does not retrieve Employee again
            using (var context = new Recipe8Context())
            {
                // Assume we already have an employee
                var jill = context.Employees.Where(o => o.Name == "Jill Carpenter").First();

                // Leverage the Entry, Query and Include methods to retrieve Department and Company data
                // without requerying the Employee table
                context.Entry(jill).Reference(x => x.Department).Query().Include(y => y.Company).Load();

                Console.WriteLine("{0} works in {1} for {2}", jill.Name, jill.Department.Name,
                                  jill.Department.Company.Name);
            }

            Console.WriteLine("Press <enter> to continue...");
            Console.ReadLine();
        }
    }
}
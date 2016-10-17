using System;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe3_6
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.employee");
                // add new test data
                context.Employees.Add(new Employee
                {
                    Name = "Robin Rosen",
                    YearsWorked = 3
                });
                context.Employees.Add(new Employee {Name = "John Hancock"});
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Employees (using LINQ)");
                var employees = from e in context.Employees
                                select new { Name = e.Name, YearsWorked = e.YearsWorked ?? 0 };
                foreach (var employee in employees)
                {
                    Console.WriteLine("{0}, years worked: {1}", employee.Name,
                        employee.YearsWorked);
                }
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("\nEmployees (using ESQL w/named constructor)");
                var esql = @"select value Recipe3_6.Employee(e.EmployeeId, 
                      e.Name,
                      case when e.YearsWorked is null then 0
                           else e.YearsWorked end) 
                    from Employees as e";
                // cast the DbContext to the underlying ObjectContext, as DbContext does not 
                // provide direct support for EntitySQL queries
                var employees = ((IObjectContextAdapter) context).ObjectContext.CreateQuery<Employee>(esql);
                foreach (var employee in employees)
                {
                    Console.WriteLine("{0}, years worked: {1}", employee.Name,
                        employee.YearsWorked.ToString());
                }
            }

            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}
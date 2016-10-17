using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using POCORecipe44;
namespace POCORecipe4
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
                context.Employees.Add(new Employee
                {
                    Name = new Name
                    {
                        FirstName = "Annie",
                        LastName = "Oakley"
                    },
                    Email = "aoakley@wildwestshow.com"
                });
                context.Employees.Add(new Employee
                {
                    Name = new Name
                    {
                        FirstName = "Bill",
                        LastName = "Jordan"
                    },
                    Email = "BJordan@wildwestshow.com"
                });
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var employee in
                         context.Employees.OrderBy(e => e.Name.LastName))
                {
                    Console.WriteLine("{0}, {1} email: {2}",
                                       employee.Name.LastName,
                                       employee.Name.FirstName,
                                       employee.Email);
                }
            }
			int id = 0;
			using (var context = new EFRecipesEntities())
			{
				var emp = context.Employees.Where(e =>
							e.Name.FirstName.StartsWith("Bill")).FirstOrDefault();
				id = emp.EmployeeId;
			}

			using (var context = new EFRecipesEntities())
			{
				var empDelete = new Employee
				{
					EmployeeId = id,
					Name = new Name
					{
						FirstName = string.Empty,
						LastName = string.Empty
					}
				};
				context.Employees.Attach(empDelete);
				context.Employees.Remove(empDelete);
				context.SaveChanges();
			}

			using (var context = new EFRecipesEntities())
			{
				foreach (var employee in
						 context.Employees.OrderBy(e => e.Name.LastName))
				{
					Console.WriteLine("{0}, {1} email: {2}",
									   employee.Name.LastName,
									   employee.Name.FirstName,
									   employee.Email);
				}
			}
			Console.WriteLine("Enter input:");
			string line = Console.ReadLine();
			if (line == "exit")
			{
				return;
			};
		}
	}
}

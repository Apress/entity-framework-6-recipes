using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe2
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
				var user1 = new User
				{
					FullName = "Robert Meyers",
					UserName = "RM"
				};
				var user2 = new User
				{
					FullName = "Karen Kelley",
					UserName = "KKelley"
				};
				context.Users.Add(user1);
				context.Users.Add(user2);
				context.SaveChanges();
				Console.WriteLine("Users saved to database");
			}

			using (var context = new EFRecipesEntities())
			{
				Console.WriteLine();
				Console.WriteLine("Reading users from database");
				foreach (var user in context.Users)
				{
					Console.WriteLine("{0} is {1}, UserName is {2}", user.FullName,
							user.IsActive ? "Active" : "Inactive", user.UserName);
				}
			}
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
		}
	}

	
}

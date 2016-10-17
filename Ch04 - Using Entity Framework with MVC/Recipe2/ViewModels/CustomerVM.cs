using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EntityFrameworkRecipe2.Models;
namespace EntityFrameworkRecipe2.ViewModels
{
	public class CustomerVM
	{
		public string Name { get; set; }
		public string City { get; set; }
		public string State { get; set; }
		public List<Customer> Customers { get; set; }
	}
}
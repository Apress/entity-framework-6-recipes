using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EntityFrameworkRecipe3.ViewModels
{
	public class ProductVM
	{
		public int ProductId { get; set; }
		public string Name { get; set; }
		public string CategoryName { get; set; }
	}
}
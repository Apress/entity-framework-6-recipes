using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EntityFrameworkRecipe3.Models;
using EntityFrameworkRecipe3.ViewModels;
namespace EntityFrameworkRecipe3.Controllers
{
    public class ProductController : Controller
    {
        //
        // GET: /Product/

        public ActionResult Index(string name)
        {
			using (var db = new ProductEntities())
			{
				var query = from productRec in db.Products
							join categoryRec in db.Categories
							on productRec.CategoryId
							equals categoryRec.CategoryId
							where categoryRec.Name == name
							select new
							{
								Name = productRec.Name
								,
								CategoryName = categoryRec.Name
							};
				List<ProductVM> lstProduct = new List<ProductVM>();
				foreach(var record in query)
				{
					ProductVM productValue = new ProductVM();
					productValue.Name = record.Name;
					productValue.CategoryName = record.CategoryName;
					lstProduct.Add(productValue);
				}
				return View(lstProduct);
			}
        }

    }
}

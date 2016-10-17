using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EntityFrameworkRecipe2.Models;
using EntityFrameworkRecipe2.ViewModels;
namespace EntityFrameworkRecipe2.Controllers
{
    public class CustomerController : Controller
    {
		public ActionResult Search()
		{
			using (var db = new CustomerEntities())
			{
				var customer = db.Customers.ToList();
				var data = new CustomerVM()
				{
					Customers = customer
				};
				return View(data);
			}
		}
		[HttpPost]
		public ActionResult Search(CustomerVM customerVmValue)
		{
			using (var db = new CustomerEntities())
			{
				var customerSearchResults = from customerRec in db.Customers
											 where ((customerVmValue.Name == null) || (customerRec.Name == customerVmValue.Name.Trim()))
											 && ((customerVmValue.City == null) || (customerRec.City == customerVmValue.City.Trim()))
											 && ((customerVmValue.State == null) || (customerRec.State == customerVmValue.State.Trim()))
											 select new
											 {
												 Name = customerRec.Name
												 ,
												 City = customerRec.City
												 ,
												 State = customerRec.State
											 };
				List<Customer> lstCustomer = new  List<Customer>();
				foreach (var record in customerSearchResults)
				{
					Customer customerValue = new Customer();
					customerValue.Name = record.Name;
					customerValue.City = record.City;
					customerValue.State = record.State;
					lstCustomer.Add(customerValue);
				}
				customerVmValue.Customers = lstCustomer;
				return View(customerVmValue);
			}
		}
    }
}

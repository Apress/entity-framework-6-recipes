using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using System.Web;
using System.Web.Mvc;
using Recipe4.Service.DAL;

namespace Recipe4.Service.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Test()
        {
            using (var context = new Recipe4Context())
            {
                var junk = context.Customers.Include(x => x.Phones).ToList();
                return null;
            }
            
            
            return null;
        }
    }
}

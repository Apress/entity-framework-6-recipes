using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyStore.Models;
namespace MyStore.Controllers
{
    public class AppController : Controller
    {
        //
        // GET: /App/

        public ActionResult Index()
        {
			using (var db = new MyStoreEntities())
			{
				return View(db.Apps.ToList());
			}
        }

        //
        // GET: /App/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /App/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /App/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /App/Edit/5

        public ActionResult Edit(int id)
        {
			using (var db = new MyStoreEntities())
			{
				return View(db.Apps.Find(id));
			}
        }

        //
        // POST: /App/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /App/Delete/5

        public ActionResult Delete(int id)
        {
			using (var db = new MyStoreEntities())
			{
				return View(db.Apps.Find(id));
			}
        }

        //
        // POST: /App/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}

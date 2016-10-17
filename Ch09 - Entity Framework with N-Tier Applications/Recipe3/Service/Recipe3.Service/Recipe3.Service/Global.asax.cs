using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Recipe3.Service.DAL;
using RouteDebug;

namespace Recipe3.Service
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            // Disable Entity Framework Model Compatibilty 
            Database.SetInitializer<Recipe3Context>(null);
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // The Bi-Directional navigation properties between related entities 
            // create a self-referencing loop which breaks Web API's effort to 
            // serialize the objects as JSON. By default, Json.NET is configured
            // to error when a reference loop is detected. To resolve problem,
            // simply configure JSON serializer to ignore self-referencing loops.
            GlobalConfiguration.Configuration.Formatters.JsonFormatter
                .SerializerSettings.ReferenceLoopHandling =
                    Newtonsoft.Json.ReferenceLoopHandling.Ignore;
        }
    }
}
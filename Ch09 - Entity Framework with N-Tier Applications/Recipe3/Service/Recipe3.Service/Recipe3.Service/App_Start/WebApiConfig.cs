using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace Recipe3.Service
{
    public static class WebApiConfig
    {
 
        public static void Register(HttpConfiguration config)
        {
            config.Routes.MapHttpRoute(
                name: "ActionMethodSave",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            // Remove the default routing for Web API that is created by Visual Studio template
            //config.Routes.MapHttpRoute(
            //    name: "DefaultApi",
            //    routeTemplate: "api/{controller}/{id}",
            //    defaults: new { id = RouteParameter.Optional }
            //);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Recipe1Service.DAL;

namespace Recipe1Service.Controllers
{
    public class OrderController : ApiController
    {
        // GET api/order
        public IEnumerable<Order> Get()
        {
            using (var context = new Recipe1Context())
            {
                return context.Orders.ToList();
            }
        }

        // GET api/order/5
        public Order Get(int id)
        {
            using (var context = new Recipe1Context())
            {
                return context.Orders.FirstOrDefault(x => x.OrderId == id);
            }
        }

        // POST api/order
        public HttpResponseMessage Post(Order order)
        {
            // Cleanup data from previous requests
            Cleanup();
            
            using (var context = new Recipe1Context())
            {
                context.Orders.Add(order);
                context.SaveChanges();

                // create HttpResponseMessage to wrap result, assigning Http Status code of 201,
                // which informs client that resource created successfully
                var response = Request.CreateResponse(HttpStatusCode.Created, order);
                
                // add location of newly-created resource to response header
                response.Headers.Location = 
                    new Uri(Url.Link("DefaultApi", new { id = order.OrderId }));
                
                return response;
            }
        }

        // PUT api/order/5
        public HttpResponseMessage Put(Order order)
        {
            using (var context = new Recipe1Context())
            {
                context.Entry(order).State = EntityState.Modified;
                context.SaveChanges();

                // return Http Status code of 200, informing client that resource updated successfully
                return Request.CreateResponse(HttpStatusCode.OK, order);
            }
        }

        // DELETE api/order/5
        public HttpResponseMessage Delete(int id)
        {
            using (var context = new Recipe1Context())
            {
                var order = context.Orders.FirstOrDefault(x => x.OrderId == id);
                context.Orders.Remove(order);
                context.SaveChanges();

                // Return Http Status code of 200, informing client that resouce removed successfully
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }

        private void Cleanup()
        {
            using (var context = new Recipe1Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter9.[order]");
                context.SaveChanges();
            }
        }
    }
}

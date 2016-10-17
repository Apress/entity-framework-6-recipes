using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Recipe3.Service.DAL;

namespace Recipe3.Service.Controllers
{
    public class TravelAgentController : ApiController
    {
        // GET api/travelagent
        [HttpGet]
        public IEnumerable<TravelAgent> Retrieve()
        {
            using (var context = new Recipe3Context())
            {
                return context.TravelAgents.Include(x => x.Bookings).ToList();
            }
        }

        /// <summary>
        /// Update changes to TravelAgent, implementing Action-Based Routing in Web API
        /// </summary>
        public HttpResponseMessage Update(TravelAgent travelAgent)
        {
            using (var context = new Recipe3Context())
            {
                var newParentEntity = true;

                // adding the object graph makes the context aware of entire
                // object graph (parent and child entites) and assigns a state
                // of added to each entity.
                context.TravelAgents.Add(travelAgent);

                if (travelAgent.AgentId > 0)
                {
                    // as the Id property has a value greater than 0, we assume
                    // that travel agent already exists and set entity state to
                    // be updated.
                    context.Entry(travelAgent).State = EntityState.Modified;
                    newParentEntity = false;
                }

                // iterate through child entites, assigning correct state.
                foreach (var booking in travelAgent.Bookings)
                {
                    if (booking.BookingId > 0)
                        // assume booking already exists if ID is greater than zero.
                        // set entity to be updated.
                        context.Entry(booking).State = EntityState.Modified;
                }

                context.SaveChanges();

                HttpResponseMessage response;

                // set Http Status code based on operation type
                response = Request.CreateResponse(newParentEntity
                    ? HttpStatusCode.Created
                    : HttpStatusCode.OK, travelAgent);

                return response;
            }
        }

        [HttpDelete]
        public HttpResponseMessage Cleanup()
        {
            using (var context = new Recipe3Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter9.booking");
                context.Database.ExecuteSqlCommand("delete from chapter9.travelagent");
                context.SaveChanges();
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}
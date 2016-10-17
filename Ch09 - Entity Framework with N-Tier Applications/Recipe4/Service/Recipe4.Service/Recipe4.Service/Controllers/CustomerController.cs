using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Recipe4.Service.DAL;

namespace Recipe4.Service.Controllers
{
    public class CustomerController : ApiController
    {
        // GET api/customer
        public IEnumerable<Customer> Get()
        {
            using (var context = new Recipe4Context())
            {
                return context.Customers.Include(x => x.Phones).ToList();
            }
        }

        // GET api/customer/5
        public Customer Get(int id)
        {
            using (var context = new Recipe4Context())
            {
                return context.Customers.Include(x => x.Phones)
                    .FirstOrDefault(x => x.CustomerId == id);
            }
        }

        [ActionName("Update")]
        public HttpResponseMessage UpdateCustomer(Customer customer)
        {
            using (var context = new Recipe4Context())
            {
                // Add object graph to context setting default state of 'Added'.
                // Adding parent to context automatically attaches entire graph
                // (parent and child entites) to context and sets state to 'Added'
                // for all entities.
                context.Customers.Add(customer);

                foreach (var entry in context.ChangeTracker.Entries<BaseEntity>())
                {
                    entry.State = EntityStateFactory.Set(entry.Entity.TrackingState);

                    if (entry.State == EntityState.Modified)
                    {
                        // For entity updates, we fetch a current copy of the entity
                        // from the database and assign the values to the orginal values
                        // property from the Entry object. OrginalValues wrap a dictionary
                        // that represent the values of the entity before applying changes.
                        // The Entity Framework change tracker will detect
                        // differences bewteen the current and original values and mark 
                        // each property and the entity as modified. Start by setting
                        // the state for the entity as 'Unchanged'.
                        entry.State = EntityState.Unchanged;
                        var databaseValues = entry.GetDatabaseValues();
                        entry.OriginalValues.SetValues(databaseValues);
                    }
                }

                context.SaveChanges();
            }

            return Request.CreateResponse(HttpStatusCode.OK, customer);
        }

        [HttpDelete]
        [ActionName("Cleanup")]
        public HttpResponseMessage Cleanup()
        {
            using (var context = new Recipe4Context())
            {
                context.Database.ExecuteSqlCommand("delete from chapter9.phone");
                context.Database.ExecuteSqlCommand("delete from chapter9.customer");
                context.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }
    }
}
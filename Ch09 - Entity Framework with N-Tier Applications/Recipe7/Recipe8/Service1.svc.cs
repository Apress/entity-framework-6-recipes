using System.Data.Entity;
using System.Linq;

namespace Recipe8
{
    public class Service1 : IService1
    {
        [ApplyProxyDataContractResolver]
        public Client GetClient()
        {
            using (var context = new EFRecipesEntities())
            {
                context.Configuration.LazyLoadingEnabled = false;
                return context.Clients.Single();
            }
        }

        public void Update(Client client)
        {
            using (var context = new EFRecipesEntities())
            {
                context.Entry(client).State = EntityState.Modified;
                context.SaveChanges();
            }
        }

        public void InsertTestRecord()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter9.client");

                // insert new test data
                context.Database.ExecuteSqlCommand(
                    @"insert into chapter9.client(Name, Email) values ('Jerry Jones','jjones@gmail.com')");
            }
        }
    }
}
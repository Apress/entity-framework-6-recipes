using Recipe2Client.ServiceReference1;

namespace Recipe2Client
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            var service = new Service1Client();
            var order = service.InsertOrder();
            order.Quantity = 5;
            service.UpdateOrderWithoutRetrieving(order);
            order = service.InsertOrder();
            order.Quantity = 5;
            service.UpdateOrderByRetrieving(order);
        }
    }
}
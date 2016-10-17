using Recipe1Client.ServiceReference1;

namespace Recipe1Client
{
    internal class Program
    {
        private static void Main()
        {
            var client = new Service1Client();
            var payment = client.InsertPayment();
            client.DeletePayment(payment);
        }
    }
}
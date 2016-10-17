using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Recipe1.Client
{
    internal class Program
    {
        private HttpClient _client;
        private Order _order;
        
        private static void Main()
        {
            Task t = Run();
            t.Wait();
            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }

        private static async Task Run()
        {
            var program = new Program();
            program.ServiceSetup();
            program.CreateOrder();
            // do not proceed until order is added
            await program.PostOrderAsync();
            program.ChangeOrder();
            // do not proceed until order is changed
             await program.PutOrderAsync();
            // do not proceed until order is removed
           await  program.RemoveOrderAsync();
        }

        private void ServiceSetup()
        {
            // map URL for Web API cal
            _client = new HttpClient { BaseAddress = new Uri("http://localhost:3237/") };

            // add Accept Header to request Web API content 
            // negotiation to return resource in JSON format
            _client.DefaultRequestHeaders.Accept.
                Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        private void CreateOrder()
        {
            // Create new order
            _order = new Order { Product = "Camping Tent", Quantity = 3, Status = "Received" };
        }

        private async Task PostOrderAsync()
        {
            // leverage Web API client side API to call service
            var response = await _client.PostAsJsonAsync("api/order", _order); 
            Uri newOrderUri;

            if (response.IsSuccessStatusCode)
            {
                // Capture Uri of new resource
                newOrderUri = response.Headers.Location;

                // capture newly-created order returned from service, 
                // which will now include the database-generated Id value
                _order = await response.Content.ReadAsAsync<Order>();
                Console.WriteLine("Successfully created order: {0}", newOrderUri);
            }
            else
                Console.WriteLine("{0} ({1})", (int)response.StatusCode, response.ReasonPhrase);
        }

        private void ChangeOrder()
        {
            // update order 
            _order.Quantity = 10;
        }


        private async Task PutOrderAsync()
        {
            // construct call to generate HttpPut verb and dispatch 
            // to corresponding Put method in the Web API Service
            var response = await _client.PutAsJsonAsync("api/order", _order);

            if (response.IsSuccessStatusCode)
            {
                // capture updated order returned from service, which will include new quanity
                _order = await response.Content.ReadAsAsync<Order>();
                Console.WriteLine("Successfully updated order: {0}", response.StatusCode);
            }
            else
                Console.WriteLine("{0} ({1})", (int)response.StatusCode, response.ReasonPhrase);
        }

        private async Task RemoveOrderAsync()
        {
            // remove order
            var uri = "api/order/" + _order.OrderId;
            var response = await _client.DeleteAsync(uri);

            if (response.IsSuccessStatusCode)
                Console.WriteLine("Sucessfully deleted order: {0}", response.StatusCode);
            else
                Console.WriteLine("{0} ({1})", (int)response.StatusCode, response.ReasonPhrase);

        }
    }
}
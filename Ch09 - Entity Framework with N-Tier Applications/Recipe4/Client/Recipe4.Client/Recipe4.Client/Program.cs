using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Recipe4.Client
{
    internal class Program
    {
        private HttpClient _client;
        private Customer _bush, _obama;
        private Phone _whiteHousePhone, _bushMobilePhone, _obamaMobilePhone;
        private HttpResponseMessage _response;

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
            // do not proceed until clean-up completes
            await program.CleanupAsync();
            program.CreateFirstCustomer();
            // do not proceed until customer is added
            await program.AddCustomerAsync();
            program.CreateSecondCustomer();
            // do not proceed until customer is added
            await program.AddSecondCustomerAsync();
            // do not proceed until customer is removed
            await program.RemoveFirstCustomerAsync();
            // do not proceed until customers are fetched
            await program.FetchCustomersAsync();
        }

        private void ServiceSetup()
        {
            // set up infrastructure for Web API call
            _client = new HttpClient {BaseAddress = new Uri("http://localhost:62799/")};

            // add Accept Header to request Web API content negotiation to return resource in JSON format
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        private async Task CleanupAsync()
        {
            // call the cleanup method from the service
            _response = await _client.DeleteAsync("api/customer/cleanup/");
        }

        private void CreateFirstCustomer()
        {
            // create customer #1 and two phone numbers
            _bush = new Customer
            {
                Name = "Geroge Bush",
                Company = "Ex President",
                // set tracking state to 'Add' to generate a SQL Insert statement
                TrackingState = TrackingState.Add,
            };

            _whiteHousePhone = new Phone
            {
                Number = "212 222-2222",
                PhoneType = "White House Red Phone",
                // set tracking state to 'Add' to generate a SQL Insert statement
                TrackingState = TrackingState.Add,
            };

            _bushMobilePhone = new Phone
            {
                Number = "212 333-3333",
                PhoneType = "Bush Mobile Phone",
                // set tracking state to 'Add' to generate a SQL Insert statement
                TrackingState = TrackingState.Add,
            };

            _bush.Phones.Add(_whiteHousePhone);
            _bush.Phones.Add(_bushMobilePhone);
        }

        private async Task AddCustomerAsync()
        {
            // construct call to invoke UpdateCustomer action method in Web API service 
            _response = await _client.PostAsync("api/customer/updatecustomer/", _bush, new JsonMediaTypeFormatter());

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created customer entity from service, which will include 
                // database-generated Ids for all entites
                _bush = await _response.Content.ReadAsAsync<Customer>();
                _whiteHousePhone = _bush.Phones.FirstOrDefault(x => x.CustomerId == _bush.CustomerId);
                _bushMobilePhone = _bush.Phones.FirstOrDefault(x => x.CustomerId == _bush.CustomerId);

                Console.WriteLine("Successfully created Customer {0} and {1} Phone Numbers(s)",
                    _bush.Name, _bush.Phones.Count);
                foreach (var phoneType in _bush.Phones)
                {
                    Console.WriteLine("Added Phone Type: {0}", phoneType.PhoneType);
                }
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }

        private void CreateSecondCustomer()
        {
            // create customer #2 and phone numbers
            _obama = new Customer
            {
                Name = "Barack Obama",
                Company = "Presdient",
                // set tracking state to 'Add' to generate a SQL Insert statement
                TrackingState = TrackingState.Add,
            };

            _obamaMobilePhone = new Phone
            {
                Number = "212 444-4444",
                PhoneType = "Obama Mobile Phone",
                // set tracking state to 'Add' to generate a SQL Insert statement
                TrackingState = TrackingState.Add,
            };

            // set tracking state to 'Modifed' to generate a SQL Update statement
            _whiteHousePhone.TrackingState = TrackingState.Update;

            _obama.Phones.Add(_obamaMobilePhone);
            _obama.Phones.Add(_whiteHousePhone);
        }

        private async Task AddSecondCustomerAsync()
        {
            // construct call to invoke UpdateCustomer action method in Web API service 
            _response = await _client.PostAsync("api/customer/updatecustomer/",
                _obama, new JsonMediaTypeFormatter());

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created customer entity from service, which will include 
                // database-generated Ids for all entites
                _obama = await _response.Content.ReadAsAsync<Customer>();
                _whiteHousePhone = _bush.Phones.FirstOrDefault(x => x.CustomerId == _obama.CustomerId);
                _bushMobilePhone = _bush.Phones.FirstOrDefault(x => x.CustomerId == _obama.CustomerId);

                Console.WriteLine("Successfully created Customer {0} and {1} Phone Numbers(s)",
                    _obama.Name, _obama.Phones.Count);

                foreach (var phoneType in _obama.Phones)
                {
                    Console.WriteLine("Added Phone Type: {0}", phoneType.PhoneType);
                }
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }

        private async Task RemoveFirstCustomerAsync()
        {
            // remove George Bush from underlying data store.
            // first, fetch George Bush entity, demonstrating a call to the 
            // get action method on the service while passing a parameter
            var query = "api/customer/" + _bush.CustomerId;
            _response = _client.GetAsync(query).Result;

            if (_response.IsSuccessStatusCode)
            {
                _bush = await _response.Content.ReadAsAsync<Customer>();

                // set tracking state to 'Remove' to generate a SQL Delete statement
                _bush.TrackingState = TrackingState.Remove;

                // must also remove bush's mobile number -- must delete child before removing parent
                foreach (var phoneType in _bush.Phones)
                {
                    // set tracking state to 'Remove' to generate a SQL Delete statement
                    phoneType.TrackingState = TrackingState.Remove;
                }

                // construct call to remove Bush from underlying database table
                _response = await _client.PostAsync("api/customer/updatecustomer/", _bush, new JsonMediaTypeFormatter());

                if (_response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Removed {0} from database", _bush.Name);
                    foreach (var phoneType in _bush.Phones)
                    {
                        Console.WriteLine("Remove {0} from data store", phoneType.PhoneType);
                    }
                }
                else
                    Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
            }
            else
            {
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
            }
        }

        private async Task FetchCustomersAsync()
        {

            // finally, return remaining customers from underlying data store
            _response = await _client.GetAsync("api/customer/");

            if (_response.IsSuccessStatusCode)
            {
                var customers = await _response.Content.ReadAsAsync<IEnumerable<Customer>>();

                foreach (var customer in customers)
                {
                    Console.WriteLine("Customer {0} has {1} Phone Numbers(s)",
                        customer.Name, customer.Phones.Count());
                    foreach (var phoneType in customer.Phones)
                    {
                        Console.WriteLine("Phone Type: {0}", phoneType.PhoneType);
                    }
                }
            }
            else
            {
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
            }
        }
    }
}

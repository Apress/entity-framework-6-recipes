using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Recipe3.Client
{
    internal class Program
    {
        private HttpClient _client;
        private TravelAgent _agent1, _agent2;
        private Booking _booking1, _booking2, _booking3;
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
            // do not proceed until clean up is completed
            await program.CleanupAsync();
            program.CreateFirstAgent();
            // do not proceed until agent is created
            await program.AddAgentAsync();
            program.CreateSecondAgent();
            // do not proceed until agent is created
            await program.AddSecondAgentAsync();
            program.ModifyAgent();
            // do not proceed until agent is updated
            await program.UpdateAgentAsync();
            // do not proceed until agents are fetched
            await program.FetchAgentsAsync();
        }

        private void ServiceSetup()
        {
            // set up infrastructure for Web API call
            _client = new HttpClient {BaseAddress = new Uri("http://localhost:6687/")};

            // add Accept Header to request Web API content negotiation to return resource in JSON format
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        private async Task CleanupAsync()
        {
            // call cleanup method in service
            _response = await _client.DeleteAsync("api/travelagent/cleanup/");
        }

        private void CreateFirstAgent()
        {
            // create new Travel Agent and booking
            _agent1 = new TravelAgent {Name = "John Tate"};
            _booking1 = new Booking
            {
                Customer = "Karen Stevens",
                Paid = false,
                BookingDate = DateTime.Parse("2/2/2010")
            };
            _booking2 = new Booking
            {
                Customer = "Dolly Parton",
                Paid = true,
                BookingDate = DateTime.Parse("3/10/2010")
            };
            _agent1.Bookings.Add(_booking1);
            _agent1.Bookings.Add(_booking2);
        }

        private async Task AddAgentAsync()
        {
            // call generic update method in Web API service to add agent and bookings
            _response = await _client.PostAsync("api/travelagent/update/",
                _agent1, new JsonMediaTypeFormatter());

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created travel agent from service, which will include 
                // database-generated Ids for each entity
                _agent1 = await _response.Content.ReadAsAsync<TravelAgent>();
                _booking1 = _agent1.Bookings.FirstOrDefault(x => x.Customer == "Karen Stevens");
                _booking2 = _agent1.Bookings.FirstOrDefault(x => x.Customer == "Dolly Parton");

                Console.WriteLine("Successfully created Travel Agent {0} and {1} Booking(s)",
                    _agent1.Name, _agent1.Bookings.Count);
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }

        private void CreateSecondAgent()
        {
            // add new agent and booking
            _agent2 = new TravelAgent {Name = "Perry Como"};
            _booking3 = new Booking
            {
                Customer = "Loretta Lynn",
                Paid = true,
                BookingDate = DateTime.Parse("3/15/2010")
            };
            _agent2.Bookings.Add(_booking3);
        }

        private async Task AddSecondAgentAsync()
        {
            // call generic update method in Web API service to add agent and booking
            _response = await _client.PostAsync("api/travelagent/update/",
                _agent2, new JsonMediaTypeFormatter());

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created travel agent from service
                _agent2 = await _response.Content.ReadAsAsync<TravelAgent>();
                _booking3 = _agent2.Bookings.FirstOrDefault(x => x.Customer == "Loretta Lynn");

                Console.WriteLine("Successfully created Travel Agent {0} and {1} Booking(s)",
                    _agent2.Name, _agent2.Bookings.Count);
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }

        private void ModifyAgent()
        {
            // modify agent 2 by changing agent name and assigning booking 1 to him from agent 1
            _agent2.Name = "Perry Como, Jr.";
            _agent2.Bookings.Add(_booking1);
        }

        private async Task UpdateAgentAsync()
        {
            // call generic update method in Web API service to update agent 2
            _response = await _client.PostAsync("api/travelagent/update/",
                _agent2, new JsonMediaTypeFormatter());

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created travel agent from service, which will include Ids
                _agent1 = _response.Content.ReadAsAsync<TravelAgent>().Result;
                Console.WriteLine("Successfully updated Travel Agent {0} and {1} Booking(s)",
                    _agent1.Name, _agent1.Bookings.Count);
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }

        private async Task FetchAgentsAsync()
        {
            // call Get method on service to fetch all Travel Agents and Bookings
            _response = _client.GetAsync("api/travelagent/retrieve").Result;

            if (_response.IsSuccessStatusCode)
            {
                // capture newly-created travel agent from service, which will include Ids
                var agents = await _response.Content.ReadAsAsync<IEnumerable<TravelAgent>>();

                foreach (var agent in agents)
                {
                    Console.WriteLine("Travel Agent {0} has {1} Booking(s)", agent.Name, agent.Bookings.Count());
                }
            }
            else
                Console.WriteLine("{0} ({1})", (int) _response.StatusCode, _response.ReasonPhrase);
        }
    }
}
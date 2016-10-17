using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace CustomEFRecipe10
{
    class Program
    {
        static void Main(string[] args)
        {
            RunExample();
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var resume = new XElement("Person",
                    new XElement("Name", "Robin St.James"),
                    new XElement("Phone", "817 867-5201"),
                    new XElement("FirstOffice", "Dog Catcher"),
                    new XElement("SecondOffice", "Mayor"),
                    new XElement("ThirdOffice", "State Senator"));
                var can = new Candidate
                {
                    Name = "Robin St.James",
                    CandidateResume = resume
                };
                context.Candidates.Add(can);
                context.SaveChanges();
                can.CandidateResume.SetElementValue("Phone", "817 555-5555");
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                foreach (var can in context.Candidates)
                {
                    Console.WriteLine("{0}", can.Name);
                    Console.WriteLine("Phone: {0}",
                            can.CandidateResume.Element("Phone").Value);
                    Console.WriteLine("First Political Office: {0}",
                            can.CandidateResume.Element("FirstOffice").Value);
                    Console.WriteLine("Second Political Office: {0}",
                            can.CandidateResume.Element("SecondOffice").Value);
                    Console.WriteLine("Third Political Office: {0}",
                            can.CandidateResume.Element("ThirdOffice").Value);
                }
            }
            Console.WriteLine("Press any key to close...");
            Console.ReadLine();
        }
    }

    public partial class Candidate
    {
        private XElement candidateResume = null;

        public XElement CandidateResume
        {
            get
            {
                if (candidateResume == null)
                {
                    candidateResume = XElement.Parse(this.Resume);
                    candidateResume.Changed += (s, e) =>
                    {
                        this.Resume = candidateResume.ToString();
                    };
                }
                return candidateResume;
            }
            set
            {
                candidateResume = value;
                candidateResume.Changed += (s, e) =>
                {
                    this.Resume = candidateResume.ToString();
                };
                this.Resume = value.ToString();
            }
        }
    }
}
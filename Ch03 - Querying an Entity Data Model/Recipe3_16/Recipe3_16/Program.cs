using System;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Recipe3_16
{
    class Program
    {
        static void Main(string[] args)
        {
                RunExample();
        }

        [Flags]
        public enum SponsorTypes
        {
            None = 0,
            ContributesMoney = 1,
            Volunteers = 2,
            IsABoardMember = 4
        };

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                // delete previous test data
                context.Database.ExecuteSqlCommand("delete from chapter3.patron");
                // add new test data
                context.Patrons.Add(new Patron { Name = "Jill Roberts", 
                           SponsorType = (int)SponsorTypes.ContributesMoney });
                context.Patrons.Add(new Patron { Name = "Ryan Keyes", 
                           // note the useage of the bitwise OR operator: '|'
                           SponsorType = (int)(SponsorTypes.ContributesMoney | 
                                               SponsorTypes.IsABoardMember)});
                context.Patrons.Add(new Patron {Name = "Karen Rosen", 
                           SponsorType = (int)SponsorTypes.Volunteers});
                context.Patrons.Add(new Patron {Name = "Steven King", 
                           SponsorType = (int)(SponsorTypes.ContributesMoney |
                                               SponsorTypes.Volunteers)});
                context.SaveChanges();
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("Using LINQ...");
                var sponsors = from p in context.Patrons
                               // note the useage of the bitwise AND operator: '&'
                               where (p.SponsorType & 
                                      (int)SponsorTypes.ContributesMoney) != 0
                               select p;
                Console.WriteLine("Patrons who contribute money");
                foreach (var sponsor in sponsors)
                {
                    Console.WriteLine("\t{0}", sponsor.Name);
                }
            }

            using (var context = new EFRecipesEntities())
            {
                Console.WriteLine("\nUsing Entity SQL...");
                var esql = @"select value p from Patrons as p
                             where BitWiseAnd(p.SponsorType, @type) <> 0";
                var sponsors = ((IObjectContextAdapter)context).ObjectContext.CreateQuery<Patron>(esql, 
                   new ObjectParameter("type", (int)SponsorTypes.ContributesMoney));
                Console.WriteLine("Patrons who contribute money");
                foreach (var sponsor in sponsors)
                {
                    Console.WriteLine("\t{0}", sponsor.Name);
                }
            }
            Console.WriteLine("\nPress <enter> to continue...");
            Console.ReadLine();
        }
    }
}


using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CodeFirstDemo.Models;
using CodeFirstDemo.DataAccess;

namespace CodeFirstDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            Database.SetInitializer(new DropCreateBreakAwayWithSeedData());

            InsertDestination();
            Console.WriteLine("Done");
        }

        private static void InsertDestination()
        {
            var destination = new Destination
            {
                Country = "Indonesia",
                Description = "EcoTourism at its best in exquisite Bali",
                Name = "Bali"
            };
            using (var context = new BreakAwayContext())
            {
                context.Destinations.Add(destination);
                context.SaveChanges();
            }
        }
    }
}

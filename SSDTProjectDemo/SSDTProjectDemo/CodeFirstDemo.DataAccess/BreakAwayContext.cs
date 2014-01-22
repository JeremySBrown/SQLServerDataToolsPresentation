using System.Data.Entity;
using CodeFirstDemo.Models;

namespace CodeFirstDemo.DataAccess
{
    public class BreakAwayContext : DbContext
    {
        public DbSet<Destination> Destinations { get; set; }
        public DbSet<Lodging> Lodgings { get; set; } 
    }
}
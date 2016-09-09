using System;
using System.Data.Entity;
using Microsoft.AspNet.Identity.EntityFramework;
using MyMenu.Api.DataEf.EntityConfiguration;

namespace MyMenu.Api.DataEf
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Configuration.LazyLoadingEnabled = false;
        }

        public DbSet<Restaurant> Restaurants { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new RestaurantConfiguration());

            base.OnModelCreating(modelBuilder); 
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }
    }
}

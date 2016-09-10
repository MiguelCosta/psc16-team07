using Microsoft.AspNet.Identity.EntityFramework;
using MyMenu.Api.DataEf.EntityConfiguration;
using System.Data.Entity;

namespace MyMenu.Api.DataEf
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Configuration.LazyLoadingEnabled = false;
        }

        public DbSet<Dish> Dishes { get; set; }

        public DbSet<Restaurant> Restaurants { get; set; }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new RestaurantConfiguration());

            base.OnModelCreating(modelBuilder);
        }
    }
}

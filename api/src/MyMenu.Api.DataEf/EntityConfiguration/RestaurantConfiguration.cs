using System.Data.Entity.ModelConfiguration;

namespace MyMenu.Api.DataEf.EntityConfiguration
{
    public class RestaurantConfiguration : EntityTypeConfiguration<Restaurant>
    {
        public RestaurantConfiguration()
        {
            Property(p => p.Latitude)
                .HasPrecision(11, 6);

            Property(p => p.Longitude)
                .HasPrecision(11, 6);

            HasMany(r => r.Dishes)
                .WithRequired(d => d.Restaurant)
                .HasForeignKey(d => d.RestaurantId);

        }
    }
}

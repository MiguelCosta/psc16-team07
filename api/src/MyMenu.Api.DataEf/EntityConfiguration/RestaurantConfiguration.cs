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
        }
    }
}

using AutoMapper;

namespace MyMenu.Api.Mapping
{
    public class Map
    {
        public static void Start()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.AddProfile<RestaurantMapping>();
            });
            Mapper.AssertConfigurationIsValid();
        }
    }
}

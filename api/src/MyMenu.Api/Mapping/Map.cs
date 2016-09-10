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
                cfg.AddProfile<DishMapping>();
            });
            Mapper.AssertConfigurationIsValid();
        }
    }
}

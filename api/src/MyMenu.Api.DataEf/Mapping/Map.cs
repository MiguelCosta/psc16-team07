using AutoMapper;

namespace MyMenu.Api.DataEf.Mapping
{
    public static class Map
    {
        public static void Start()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.AddProfile<RestaurantMapping>();
                cfg.AddProfile<DishMapping>();
            });
        }
    }
}

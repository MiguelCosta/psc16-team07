using AutoMapper;
using MyMenu.Api.Models;

namespace MyMenu.Api.DataEf.Mapping
{
    public class RestaurantMapping : Profile
    {
        public RestaurantMapping()
        {
            ToDataBase();
            ToModel();
        }

        private void ToDataBase()
        {
            CreateMap<RestaurantModel, Restaurant>();
        }

        private void ToModel()
        {
            CreateMap<Restaurant, RestaurantModel>();
        }
    }
}

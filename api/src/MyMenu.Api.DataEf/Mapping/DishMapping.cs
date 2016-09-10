using AutoMapper;
using MyMenu.Api.Models;

namespace MyMenu.Api.DataEf.Mapping
{
    public class DishMapping : Profile
    {
        public DishMapping()
        {
            ToDataBase();
            ToModel();
        }

        private void ToDataBase()
        {
            CreateMap<DishModel, Dish>();
        }

        private void ToModel()
        {
            CreateMap<Dish, DishModel>();
        }
    }
}

using AutoMapper;
using MyMenu.Api.Dtos;
using MyMenu.Api.Models;

namespace MyMenu.Api.Mapping
{
    public class DishMapping : Profile
    {
        public DishMapping()
        {
            CreateMap<DishDto, DishModel>()
                .ForMember(m => m.Id, c => c.Ignore())
                ;
        }
    }
}

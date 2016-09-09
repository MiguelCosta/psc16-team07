using AutoMapper;
using MyMenu.Api.Dtos;
using MyMenu.Api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyMenu.Api.Mapping
{
    public class RestaurantMapping : Profile
    {
        public RestaurantMapping()
        {
            CreateMap<RestaurantDto, RestaurantModel>()
                .ForMember(m => m.Id, c => c.Ignore())
                .ForMember(m => m.Username, c => c.Ignore())
                ;
        }
    }
}
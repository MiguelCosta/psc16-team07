using MyMenu.Api.Models;
using System.Collections.Generic;

namespace MyMenu.Api.Dtos
{
    public class SearchResultDto
    {
        public IEnumerable<DishModel> Dishes { get; set; }

        public IEnumerable<RestaurantModel> Restaurants { get; set; }

        public SearchFilterDto Filter { get; set; }
    }
}

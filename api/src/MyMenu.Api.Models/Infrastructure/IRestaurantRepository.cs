using MyMenu.Api.Models.Filters;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyMenu.Api.Models.Infrastructure
{
    public interface IRestaurantRepository
    {
        Task<RestaurantModel> CreateAsync(RestaurantModel restaurant);

        Task<RestaurantModel> EditAsync(int id, RestaurantModel restaurant);

        Task<RestaurantModel> FindAsync(int id);

        Task<IEnumerable<RestaurantModel>> GetAllAsync();

        Task<IEnumerable<RestaurantModel>> SearchAsync(RestaurantFilter search);
    }
}

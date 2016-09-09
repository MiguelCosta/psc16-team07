using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyMenu.Api.Models.Infrastructure
{
    public interface IRestaurantRepsitory
    {
        Task<IEnumerable<RestaurantModel>> GetAllAsync();

        Task<IEnumerable<RestaurantModel>> Search(string search);
    }
}

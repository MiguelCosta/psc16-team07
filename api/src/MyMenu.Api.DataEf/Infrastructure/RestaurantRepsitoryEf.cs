using AutoMapper.QueryableExtensions;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace MyMenu.Api.DataEf.Infrastructure
{
    public class RestaurantRepsitoryEf : IRestaurantRepsitory
    {
        private ApplicationDbContext _context;

        public RestaurantRepsitoryEf(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RestaurantModel>> GetAllAsync()
        {
            return await _context.Restaurants.ProjectTo<RestaurantModel>().ToListAsync();
        }

        public async Task<IEnumerable<RestaurantModel>> Search(string search)
        {
            var filter = new Models.Filters.RestaurantFilter(search);

            var query = _context.Restaurants
                .AsNoTracking()
                .AsQueryable();

            if(string.IsNullOrWhiteSpace(filter.DishName) == false)
            {
                // todo: impletmentar DishModel
            }

            if(filter.RestaurantType.Any())
            {
                query = query.Where(r => filter.RestaurantType.Contains(r.Type));
            }

            if(string.IsNullOrWhiteSpace(filter.RestaurantName))
            {
                query = query.Where(r => r.Name.Contains(filter.RestaurantName));
            }

            var results = await query.ProjectTo<RestaurantModel>().ToListAsync();

            return results;
        }
    }
}

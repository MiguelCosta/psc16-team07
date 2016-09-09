using AutoMapper;
using AutoMapper.QueryableExtensions;
using LinqKit;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System;
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

        public async Task<RestaurantModel> CreateAsync(RestaurantModel restaurant)
        {
            var rest = Mapper.Map<Restaurant>(restaurant);
            _context.Restaurants.Add(rest);
            await _context.SaveChangesAsync();
            var final = await _context.Restaurants.FindAsync(rest.Id);
            return Mapper.Map<RestaurantModel>(final);
        }

        public async Task<RestaurantModel> EditAsync(int id, RestaurantModel restaurant)
        {
            var rest = Mapper.Map<Restaurant>(restaurant);
            var currentRestaurant = await _context.Restaurants.FindAsync(id);

            //_context.Entry(currentRestaurant).;

            await _context.SaveChangesAsync();
            await _context.Entry(currentRestaurant).ReloadAsync();

            return Mapper.Map<RestaurantModel>(currentRestaurant);
        }

        public async Task<RestaurantModel> FindAsync(int id)
        {
            var rest = await _context.Restaurants.FindAsync(id);

            return Mapper.Map<RestaurantModel>(rest);
        }

        public async Task<IEnumerable<RestaurantModel>> GetAllAsync()
        {
            return await _context.Restaurants.ProjectTo<RestaurantModel>().ToListAsync();
        }

        public async Task<IEnumerable<RestaurantModel>> SearchAsync(string search)
        {
            var filter = new Models.Filters.RestaurantFilter(search);

            var predicate = PredicateBuilder.New<Restaurant>(false);

            if(string.IsNullOrWhiteSpace(filter.DishName) == false)
            {
                // todo: impletmentar DishModel
            }

            if(filter.RestaurantType.Any())
            {
                predicate = predicate.Or(r => filter.RestaurantType.Contains(r.Type));
            }

            if(string.IsNullOrWhiteSpace(filter.RestaurantName) == false)
            {
                predicate = predicate.Or(r => r.Name.Contains(filter.RestaurantName));
            }

            var results = await _context.Restaurants
                .AsExpandable()
                .AsNoTracking()
                .Where(predicate)
                .ToListAsync();

            return Mapper.Map<IEnumerable<RestaurantModel>>(results);
        }
    }
}

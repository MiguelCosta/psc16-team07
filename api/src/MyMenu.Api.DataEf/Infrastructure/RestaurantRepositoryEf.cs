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
    public class RestaurantRepositoryEf : IRestaurantRepository
    {
        private ApplicationDbContext _context;

        public RestaurantRepositoryEf(ApplicationDbContext context)
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

            _context.Entry(currentRestaurant).CurrentValues.SetValues(rest);

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

        public async Task<IEnumerable<RestaurantModel>> SearchAsync(Models.Filters.RestaurantFilter filter)
        {
            var predicate = PredicateBuilder.New<Restaurant>(true);

            if(string.IsNullOrWhiteSpace(filter.DishName) == false)
            {
                predicate = predicate.Or(r => r.Dishes.Any(d => d.Name.Contains(filter.DishName)));
            }

            if(filter.RestaurantType.Any())
            {
                predicate = predicate.Or(r => filter.RestaurantType.Contains(r.Type));
            }

            if(string.IsNullOrWhiteSpace(filter.RestaurantName) == false)
            {
                predicate = predicate.Or(r => r.Name.Contains(filter.RestaurantName));
            }

            //if(filter.Latitude > 0 && filter.Longitude > 0 && filter.Range > 0)
            //{
            //    // http://stackoverflow.com/questions/2234204/latitude-longitude-find-nearest-latitude-longitude-complex-sql-or-complex-calc
            //    //SELECT latitude, longitude, SQRT(
            //    //    POW(69.1 * (latitude - [startlat]), 2) +
            //    //    POW(69.1 * ([startlng] - longitude) 
            //    //       * COS(latitude / 57.3), 2)
            //    // ) AS distance
            //    //FROM TableName HAVING distance < 25 ORDER BY distance;

            //    predicate = predicate.Or(
            //        r =>
            //        Math.Sqrt(
            //            Math.Pow(69.1 * (Convert.ToDouble(r.Latitude) - Convert.ToDouble(filter.Latitude)), 2) +
            //            Math.Pow(69.1 * (Convert.ToDouble(filter.Longitude) - Convert.ToDouble(r.Longitude))
            //                * Math.Cos(Convert.ToDouble(r.Latitude) / 57.3), 2)
            //        ) <= filter.Range
            //    );
            //}

            var results = await _context.Restaurants
                .AsExpandable()
                .AsNoTracking()
                .Where(predicate)
                .ToListAsync();

            // TODO: tentar colocar diretamente na query
            if(filter.Latitude != 0 && filter.Longitude != 0 && filter.Range > 0)
            {
                results = results.Where(r =>
                    Math.Sqrt(
                                Math.Pow(69.1 * (Convert.ToDouble(r.Latitude) - Convert.ToDouble(filter.Latitude)), 2) +
                                Math.Pow(69.1 * (Convert.ToDouble(filter.Longitude) - Convert.ToDouble(r.Longitude))
                                    * Math.Cos(Convert.ToDouble(r.Latitude) / 57.3), 2)
                            ) <= filter.Range
                    )
                .ToList();
            }

            return Mapper.Map<IEnumerable<RestaurantModel>>(results);
        }
    }
}

using AutoMapper;
using AutoMapper.QueryableExtensions;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using MyMenu.Api.Models.Filters;
using System;
using LinqKit;

namespace MyMenu.Api.DataEf.Infrastructure
{
    public class DishRepositoryEf : IDishRepository
    {
        private ApplicationDbContext _context;

        public DishRepositoryEf(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<DishModel> CreateAsync(DishModel dish)
        {
            var d = Mapper.Map<Dish>(dish);
            _context.Dishes.Add(d);
            await _context.SaveChangesAsync();
            var final = await _context.Restaurants.FindAsync(d.Id);
            return Mapper.Map<DishModel>(final);
        }

        public async Task<DishModel> EditAsync(int id, DishModel dish)
        {
            var d = Mapper.Map<Dish>(dish);
            var currentDish = await _context.Dishes.FindAsync(id);

            _context.Entry(currentDish).CurrentValues.SetValues(d);

            await _context.SaveChangesAsync();
            await _context.Entry(currentDish).ReloadAsync();

            return Mapper.Map<DishModel>(currentDish);
        }

        public async Task<DishModel> FindAsync(int id)
        {
            var rest = await _context.Dishes.FindAsync(id);

            return Mapper.Map<DishModel>(rest);
        }

        public async Task<IEnumerable<DishModel>> GetAllAsync(IEnumerable<int> restaurantsId)
        {
            return await _context.Dishes
                 .Where(d => restaurantsId.Contains(d.RestaurantId))
                 .ProjectTo<DishModel>()
                 .ToListAsync();
        }

        public async Task<IEnumerable<DishModel>> GetAllAsync(int restaurantId)
        {
            return await _context.Dishes
                .Where(d => d.RestaurantId == restaurantId)
                .ProjectTo<DishModel>()
                .ToListAsync();
        }

        public async Task<IEnumerable<DishModel>> GetSearchRefineAsync(IEnumerable<int> restaurantsId, RestaurantFilter filter)
        {
            var predicateKeywords = PredicateBuilder.New<Dish>(false);
            if(filter.Keywords.Any())
            {
                foreach(var word in filter.Keywords)
                {
                    predicateKeywords = predicateKeywords.Or(d => d.Name.ToLower().Contains(word.ToLower()));
                    predicateKeywords = predicateKeywords.Or(d => d.Name.ToLower().Contains(word.ToLower()));
                }
            }

            var predicateRestaurants = PredicateBuilder.New<Dish>(true);
            predicateRestaurants = predicateRestaurants.Or(d => restaurantsId.Contains(d.RestaurantId));

            var predicatePrice = PredicateBuilder.New<Dish>(true);
            if(filter.MaxPrice.HasValue)
            {
                predicatePrice = predicatePrice.Or(d => d.Price <= filter.MaxPrice.Value);
            }

            var predicates = predicateKeywords.And(predicateRestaurants).And(predicatePrice);

            var results = await _context.Dishes
                .AsExpandable()
                .AsNoTracking()
                .Where(predicates)
                .ToListAsync();

            return Mapper.Map<IEnumerable<DishModel>>(results);
        }
    }
}

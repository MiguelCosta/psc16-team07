using AutoMapper;
using AutoMapper.QueryableExtensions;
using LinqKit;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace MyMenu.Api.DataEf.Infrastructure
{
    public class DishRepositoryEf : IDishRepository
    {
        private ApplicationDbContext _context;

        public DishRepositoryEf(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<DishModel> CreateAsync(DishModel restaurant)
        {
            var rest = Mapper.Map<Dish>(restaurant);
            _context.Dishes.Add(rest);
            await _context.SaveChangesAsync();
            var final = await _context.Restaurants.FindAsync(rest.Id);
            return Mapper.Map<DishModel>(final);
        }

        public async Task<DishModel> EditAsync(int id, DishModel restaurant)
        {
            var rest = Mapper.Map<Dish>(restaurant);
            var currentDish = await _context.Dishes.FindAsync(id);

            _context.Entry(currentDish).CurrentValues.SetValues(rest);

            await _context.SaveChangesAsync();
            await _context.Entry(currentDish).ReloadAsync();

            return Mapper.Map<DishModel>(currentDish);
        }

        public async Task<DishModel> FindAsync(int id)
        {
            var rest = await _context.Dishes.FindAsync(id);

            return Mapper.Map<DishModel>(rest);
        }

        public async Task<IEnumerable<DishModel>> GetAllAsync(int restaurantId)
        {
            return await _context.Dishes
                .Where(d => d.RestaurantId == restaurantId)
                .ProjectTo<DishModel>()
                .ToListAsync();
        }

        public async Task<IEnumerable<DishModel>> SearchAsync(string search)
        {
            var filter = new Models.Filters.RestaurantFilter(search);

            var predicate = PredicateBuilder.New<Dish>(false);

            if(string.IsNullOrWhiteSpace(filter.DishName) == false)
            {
                // todo: impletmentar DishModel
            }
            if(string.IsNullOrWhiteSpace(filter.RestaurantName) == false)
            {
                predicate = predicate.Or(r => r.Name.Contains(filter.RestaurantName));
            }

            var results = await _context.Dishes
                .AsExpandable()
                .AsNoTracking()
                .Where(predicate)
                .ToListAsync();

            return Mapper.Map<IEnumerable<DishModel>>(results);
        }
    }
}

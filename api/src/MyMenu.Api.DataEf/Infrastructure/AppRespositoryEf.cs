using System;
using MyMenu.Api.Models.Infrastructure;

namespace MyMenu.Api.DataEf.Infrastructure
{
    public class AppRespositoryEf : IAppRespository
    {
        private ApplicationDbContext _context;

        public AppRespositoryEf()
        {
            _context = new ApplicationDbContext();
            Dishes = new DishRepositoryEf(_context);
            Restaurants = new RestaurantRepositoryEf(_context);
        }

        public IDishRepository Dishes { get; set; }

        public IRestaurantRepository Restaurants { get; set; }
    }
}

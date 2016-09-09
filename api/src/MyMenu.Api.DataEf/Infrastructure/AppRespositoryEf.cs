using MyMenu.Api.Models.Infrastructure;

namespace MyMenu.Api.DataEf.Infrastructure
{
    public class AppRespositoryEf : IAppRespository
    {
        private ApplicationDbContext _context;

        public AppRespositoryEf()
        {
            _context = new ApplicationDbContext();
            Restaurants = new RestaurantRepsitoryEf(_context);
        }

        public IRestaurantRepsitory Restaurants { get; set; }
    }
}

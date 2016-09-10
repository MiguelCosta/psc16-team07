using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace MyMenu.Api.Controllers
{
    public class DishesController : ApiController
    {
        private IAppRespository _repo;

        public DishesController(IAppRespository repo)
        {
            _repo = repo;
        }

        /// <summary>
        /// Get a dish
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(DishModel))]
        public async Task<IHttpActionResult> Get(int id)
        {
            var rest = await _repo.Dishes.FindAsync(id);
            if(rest == null)
            {
                return NotFound();
            }
            return Ok(rest);
        }

        /// <summary>
        /// Get all dish of restaurant
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("api/Restaurants/{id}/Dishes")]
        [ResponseType(typeof(IEnumerable<DishModel>))]
        public async Task<IHttpActionResult> GetByRestaurant(int id)
        {
            var rest = await _repo.Restaurants.FindAsync(id);
            if(rest == null)
                return BadRequest();

            var dishes = await _repo.Dishes.GetAllAsync(id);
            return Ok(dishes);
        }
    }
}

using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace MyMenu.Api.Controllers
{
    public class RestaurantsController : ApiController
    {
        private IAppRespository _repo;

        public RestaurantsController(IAppRespository repo)
        {
            _repo = repo;
        }

        /// <summary>
        /// Obter todos os restaurants.
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(IEnumerable<RestaurantModel>))]
        public async Task<IHttpActionResult> Get()
        {
            var rest = await _repo.Restaurants.GetAllAsync();
            return Ok(rest);
        }

        /// <summary>
        /// Pesquisar restaurantes
        /// </summary>
        /// <param name="search"></param>
        /// <returns></returns>
        [HttpGet]
        [ResponseType(typeof(IEnumerable<RestaurantModel>))]
        public async Task<IHttpActionResult> Search([FromUri] string search)
        {
            if(string.IsNullOrWhiteSpace(search))
            {
                return BadRequest();
            }

            var result = await _repo.Restaurants.GetAllAsync();

            return Ok();
        }
    }
}

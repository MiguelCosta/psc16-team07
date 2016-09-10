using MyMenu.Api.Models.Infrastructure;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace MyMenu.Api.Controllers
{
    public class SearchController : ApiController
    {
        private IAppRespository _repo;

        public SearchController(IAppRespository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        [ResponseType(typeof(Dtos.SearchResultDto))]
        public async Task<IHttpActionResult> Get([FromUri] string query)
        {
            var results = new Dtos.SearchResultDto();

            results.Restaurants = await _repo.Restaurants.SearchAsync(query);

            var restIds = results.Restaurants.Select(r => r.Id);

            results.Dishes = await _repo.Dishes.GetAllAsync(restIds);

            return Ok(results);
        }
    }
}

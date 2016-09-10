using MyMenu.Api.Models.Filters;
using MyMenu.Api.Models.Infrastructure;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace MyMenu.Api.Controllers
{
    /// <summary>
    /// Search actions
    /// </summary>
    public class SearchController : ApiController
    {
        private IAppRespository _repo;

        public SearchController(IAppRespository repo)
        {
            _repo = repo;
        }

        /// <summary>
        /// Search restaurants and dishes.
        /// HeadersRequest:
        /// x-latitude: current latitude of user (decimal);
        /// x-longitude: current longitude of user (decimal);
        /// x-range: range of search (km);
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        [HttpGet]
        [ResponseType(typeof(Dtos.SearchResultDto))]
        public async Task<IHttpActionResult> Get([FromUri] string query = null)
        {
            var results = new Dtos.SearchResultDto();

            var filter = new RestaurantFilter(query);
            filter.Latitude = Helpers.RequestHeaderHelper.GetLatitude(Request);
            filter.Longitude = Helpers.RequestHeaderHelper.GetLongitude(Request);
            filter.Range = Helpers.RequestHeaderHelper.GetRange(Request);

            results.Restaurants = await _repo.Restaurants.SearchAsync(filter);

            var restIds = results.Restaurants.Select(r => r.Id);

            results.Dishes = await _repo.Dishes.GetAllAsync(restIds);

            return Ok(results);
        }
    }
}

using MyMenu.Api.Models.Filters;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
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
        /// <param name="filter"></param>
        /// <returns></returns>
        [HttpPost]
        [ResponseType(typeof(Dtos.SearchResultDto))]
        public async Task<IHttpActionResult> Filter([FromBody] Dtos.SearchFilterDto filter)
        {
            var results = new Dtos.SearchResultDto();

            var restFilter = new RestaurantFilter(string.Empty);
            restFilter.Latitude = Helpers.RequestHeaderHelper.GetLatitude(Request);
            restFilter.Longitude = Helpers.RequestHeaderHelper.GetLongitude(Request);
            restFilter.Range = Helpers.RequestHeaderHelper.GetRange(Request);

            restFilter.Keywords = filter.Keywords ?? new List<string>();
            restFilter.MaxPrice = filter.MaxPrice;
            foreach(var t in filter.Types ?? new List<string>())
            {
                restFilter.RestaurantTypes.Add(Helpers.EnumHelper.GetEnumValue(t));
            }

            results.Restaurants = await _repo.Restaurants.SearchRefineAsync(restFilter);

            var restIds = results.Restaurants.Select(r => r.Id);

            results.Dishes = await _repo.Dishes.GetSearchRefineAsync(restIds, restFilter);

            return Ok(results);
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

            filter.Keywords.Add(query);

            results.Dishes = await _repo.Dishes.GetSearchRefineAsync(restIds, filter);

            return Ok(results);
        }
    }
}

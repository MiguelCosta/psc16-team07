using System.Collections.Generic;
using System.Web.Http;
using System.Web.Http.Description;

namespace MyMenu.Api.Controllers
{
    public class TypesController : ApiController
    {
        /// <summary>
        /// All restaurants types
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(IEnumerable<Dtos.TypeDto>))]
        public IHttpActionResult Get()
        {
            var types = new List<Dtos.TypeDto>();
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Indian));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Italian));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Japanese));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Mexican));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Portuguese));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.SeaFood));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Traditional));
            types.Add(new Dtos.TypeDto(Models.Enums.RestaurantType.Indian));

            return Ok();
        }
    }
}

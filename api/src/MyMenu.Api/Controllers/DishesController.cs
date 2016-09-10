using AutoMapper;
using MyMenu.Api.Dtos;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Hosting;
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

        [HttpGet]
        [Route("api/Dishes/{id}/Photo")]
        public async Task<HttpResponseMessage> Photo(int id)
        {
            var dish = await _repo.Dishes.FindAsync(id);
            if(dish == null)
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound);
            }

            if(string.IsNullOrWhiteSpace(dish.Photo))
            {
                return new HttpResponseMessage(HttpStatusCode.NoContent);
            }

            var result = new HttpResponseMessage(HttpStatusCode.OK);
            string filePath = HostingEnvironment.MapPath($"~/Uploads/Dishes/{dish.Photo}");
            if(File.Exists(filePath) == false)
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound);
            }

            FileStream fileStream = new FileStream(filePath, FileMode.Open);
            Image image = Image.FromStream(fileStream);
            MemoryStream memoryStream = new MemoryStream();
            image.Save(memoryStream, ImageFormat.Jpeg);
            result.Content = new ByteArrayContent(memoryStream.ToArray());
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");
            await fileStream.FlushAsync();
            fileStream.Close();
            await memoryStream.FlushAsync();
            memoryStream.Close();
            return result;
        }

        /// <summary>
        /// Create a dish
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(DishModel))]
        public async Task<IHttpActionResult> Post([FromBody] DishDto dto)
        {
            if(ModelState.IsValid == false)
            {
                return BadRequest(ModelState);
            }

            var dish = Mapper.Map<DishModel>(dto);

            var newDish = await _repo.Dishes.CreateAsync(dish);

            return Created($"api/dishes/{newDish.Id}", newDish);
        }

        /// <summary>
        /// Edit a dish
        /// </summary>
        /// <param name="id"></param>
        /// <param name="dto"></param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(DishModel))]
        public async Task<IHttpActionResult> Put(int id, [FromBody] DishDto dto)
        {
            if(ModelState.IsValid == false)
            {
                return BadRequest(ModelState);
            }

            var currentDish = await _repo.Dishes.FindAsync(id);
            if(currentDish.RestaurantId != dto.RestaurantId)
            {
                return Content(HttpStatusCode.BadRequest, "Restaurant can't be different");
            }

            var restaurant = await _repo.Restaurants.FindAsync(currentDish.RestaurantId);
            if(restaurant.Username != User.Identity.Name)
            {
                return Content(HttpStatusCode.Forbidden, "This restaurant isn't yours");
            }

            var dish = Mapper.Map<DishModel>(dto);
            dish.Id = currentDish.Id;

            var newDish = await _repo.Dishes.EditAsync(id, dish);

            return Ok(newDish);
        }
    }
}

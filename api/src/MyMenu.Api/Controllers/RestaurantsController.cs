﻿using MyMenu.Api.Dtos;
using MyMenu.Api.Models;
using MyMenu.Api.Models.Infrastructure;
using System.Collections.Generic;
using System.Net;
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
        /// Get a restaurant
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(RestaurantModel))]
        public async Task<IHttpActionResult> Get(int id)
        {
            var rest = await _repo.Restaurants.FindAsync(id);
            return Ok(rest);
        }

        /// <summary>
        /// Get all restaurants
        /// </summary>
        /// <returns></returns>
        [ResponseType(typeof(IEnumerable<RestaurantModel>))]
        public async Task<IHttpActionResult> Get()
        {
            var rest = await _repo.Restaurants.GetAllAsync();
            return Ok(rest);
        }

        /// <summary>
        /// Create a restaurant
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(RestaurantModel))]
        public async Task<IHttpActionResult> Post(RestaurantDto dto)
        {
            if(ModelState.IsValid == false)
            {
                return BadRequest(ModelState);
            }

            var restaurant = new RestaurantModel
            {
                Address = dto.Address,
                Description = dto.Description,
                Email = dto.Email,
                Latitude = dto.Latitude,
                Longitude = dto.Longitude,
                Name = dto.Name,
                PhoneNumber = dto.PhoneNumber,
                Photo = dto.Photo,
                Schedule = dto.Schedule,
                Type = dto.Type,
                Username = User.Identity.Name
            };

            var newRestaurant = await _repo.Restaurants.CreateAsync(restaurant);

            return Created($"api/restaurants/{newRestaurant.Id}", newRestaurant);
        }

        /// <summary>
        /// Edit a restaurant
        /// </summary>
        /// <param name="id"></param>
        /// <param name="dto"></param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(RestaurantModel))]
        public async Task<IHttpActionResult> Put(int id, RestaurantDto dto)
        {
            if(ModelState.IsValid == false)
            {
                return BadRequest(ModelState);
            }

            var currentRestaurant = await _repo.Restaurants.FindAsync(id);

            if(currentRestaurant.Username != User.Identity.Name)
            {
                return Content(HttpStatusCode.Forbidden, dto);
            }

            var restaurant = new RestaurantModel
            {
                Address = dto.Address,
                Description = dto.Description,
                Email = dto.Email,
                Latitude = dto.Latitude,
                Longitude = dto.Longitude,
                Name = dto.Name,
                PhoneNumber = dto.PhoneNumber,
                Photo = dto.Photo,
                Schedule = dto.Schedule,
                Type = dto.Type,
                Username = User.Identity.Name
            };

            var newRestaurant = await _repo.Restaurants.EditAsync(id, restaurant);

            return Created($"api/restaurants/{newRestaurant.Id}", newRestaurant);
        }

        /// <summary>
        /// Search restaurants
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

            var result = await _repo.Restaurants.SearchAsync(search);

            return Ok(result);
        }
    }
}
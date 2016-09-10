using MyMenu.Api.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace MyMenu.Api.Dtos
{
    public class RestaurantDto
    {
        [Required]
        public string Address { get; set; }

        public string Description { get; set; }

        public string Email { get; set; }

        [Required]
        public decimal Latitude { get; set; }

        [Required]
        public decimal Longitude { get; set; }

        [Required]
        [StringLength(256, MinimumLength = 3)]
        public string Name { get; set; }

        public string PhoneNumber { get; set; }

        public string Photo { get; set; }

        public string Schedule { get; set; }

        public RestaurantType Type { get; set; } = RestaurantType.Undefined;
    }
}

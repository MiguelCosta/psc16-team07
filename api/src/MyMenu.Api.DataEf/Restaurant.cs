using MyMenu.Api.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace MyMenu.Api.DataEf
{
    public class Restaurant
    {
        [StringLength(256)]
        public string Address { get; set; }

        [StringLength(1024)]
        public string Description { get; set; }

        [StringLength(256)]
        public string Email { get; set; }

        [Key]
        public int Id { get; set; }

        public decimal Latitude { get; set; }

        public decimal Longitude { get; set; }

        [StringLength(256, MinimumLength = 2)]
        public string Name { get; set; }

        [StringLength(256)]
        public string PhoneNumber { get; set; }

        [StringLength(256)]
        public string Photo { get; set; }

        [StringLength(256)]
        public string Schedule { get; set; }

        public RestaurantType Type { get; set; } = RestaurantType.Undefined;

        [StringLength(256)]
        public string Username { get; set; }
    }
}

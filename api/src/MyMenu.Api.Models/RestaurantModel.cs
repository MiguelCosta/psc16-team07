using MyMenu.Api.Models.Enums;

namespace MyMenu.Api.Models
{
    public class RestaurantModel
    {
        public string Address { get; set; }

        public string Description { get; set; }

        public string Email { get; set; }

        public int Id { get; set; }

        public decimal Latitude { get; set; }

        public decimal Longitude { get; set; }

        public string Name { get; set; }

        public string PhoneNumber { get; set; }

        public string Photo { get; set; }

        public string Schedule { get; set; }

        public RestaurantType Type { get; set; } = RestaurantType.Undefined;

        public string Username { get; set; }
    }
}

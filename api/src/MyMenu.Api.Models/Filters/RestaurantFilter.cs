using System.Collections.Generic;
using System.Linq;

namespace MyMenu.Api.Models.Filters
{
    public class RestaurantFilter
    {
        public RestaurantFilter(string search)
        {
            Search = search;
            DishName = search;
            RestaurantName = search;
            RestaurantType = GetRestaurantType(Search);
        }

        public string DishName { get; set; } = string.Empty;

        public string RestaurantName { get; set; } = string.Empty;

        public string Search { get; set; }

        public List<Enums.RestaurantType> RestaurantType { get; set; } = new List<Enums.RestaurantType>();

        private static List<Enums.RestaurantType> GetRestaurantType(string search)
        {
            var result = new List<Enums.RestaurantType>();

            // todo: criar método genérico para fazer isto
            var typesString = new Dictionary<string, Enums.RestaurantType>();
            typesString.Add(Enums.RestaurantType.Indian.ToString(), Enums.RestaurantType.Indian);
            typesString.Add(Enums.RestaurantType.Italian.ToString(), Enums.RestaurantType.Italian);
            typesString.Add(Enums.RestaurantType.Mexican.ToString(), Enums.RestaurantType.Mexican);
            typesString.Add(Enums.RestaurantType.Portuguese.ToString(), Enums.RestaurantType.Portuguese);
            typesString.Add(Enums.RestaurantType.SeaFood.ToString(), Enums.RestaurantType.SeaFood);
            typesString.Add(Enums.RestaurantType.Traditional.ToString(), Enums.RestaurantType.Traditional);

            result = typesString
                .Where(x => x.Key.ToLower().Contains(search.ToLower()))
                .Select(x => x.Value)
                .ToList();

            return result;
        }
    }
}

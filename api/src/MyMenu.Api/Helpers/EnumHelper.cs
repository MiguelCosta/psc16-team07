using MyMenu.Api.Models.Enums;
using System.Collections.Generic;

namespace MyMenu.Api.Helpers
{
    public static class EnumHelper
    {
        private static Dictionary<string, RestaurantType> _enumValues = new Dictionary<string, RestaurantType>
        {
            {RestaurantType.Indian.ToString().ToLower(), RestaurantType.Indian },
            {RestaurantType.Italian.ToString().ToLower(), RestaurantType.Italian },
            {RestaurantType.Japanese.ToString().ToLower(), RestaurantType.Japanese },
            {RestaurantType.Mexican.ToString().ToLower(), RestaurantType.Mexican },
            {RestaurantType.Portuguese.ToString().ToLower(), RestaurantType.Portuguese },
            {RestaurantType.SeaFood.ToString().ToLower(), RestaurantType.SeaFood },
            {RestaurantType.Traditional.ToString().ToLower(), RestaurantType.Traditional }
        };

        public static RestaurantType GetEnumValue(string value)
        {
            RestaurantType v;
            _enumValues.TryGetValue(value.ToLower(), out v);
            return v;
        }
    }
}

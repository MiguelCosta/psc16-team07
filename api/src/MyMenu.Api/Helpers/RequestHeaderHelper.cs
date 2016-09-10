using System.Collections.Generic;
using System.Linq;
using System.Net.Http;

namespace MyMenu.Api.Helpers
{
    public static class RequestHeaderHelper
    {
        public static decimal GetLatitude(HttpRequestMessage request)
        {
            decimal latitude = decimal.Parse(GetValue(request, "x-latitude", "0"));
            return latitude;
        }

        public static decimal GetLongitude(HttpRequestMessage request)
        {
            decimal longitude = decimal.Parse(GetValue(request, "x-longitude", "0"));
            return longitude;
        }

        public static int GetRange(HttpRequestMessage request)
        {
            int range = int.Parse(GetValue(request, "x-range", "1"));
            return range;
        }

        public static string GetValue(HttpRequestMessage HttpRequestMessage, string key, string defaultvalue)
        {
            IEnumerable<string> valueHeader = new List<string>();
            if(HttpRequestMessage.Headers.TryGetValues(key, out valueHeader))
            {
                defaultvalue = valueHeader.First();
            }

            return defaultvalue;
        }
    }
}

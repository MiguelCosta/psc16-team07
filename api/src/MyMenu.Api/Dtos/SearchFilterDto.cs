using System.Collections.Generic;

namespace MyMenu.Api.Dtos
{
    public class SearchFilterDto
    {
        public List<string> Keywords { get; set; }

        public decimal? MaxPrice { get; set; }

        public List<string> Types { get; set; }
    }
}

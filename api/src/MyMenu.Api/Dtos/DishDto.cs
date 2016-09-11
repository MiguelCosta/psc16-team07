using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MyMenu.Api.Dtos
{
    public class DishDto
    {
        public bool Ative { get; set; }

        public DateTime? Date { get; set; }

        public int DayOfWeek { get; set; }

        [StringLength(1024)]
        public string Description { get; set; }

        [Required]
        [StringLength(256, MinimumLength = 2)]
        public string Name { get; set; }

        public string Photo { get; set; }

        [Required]
        public decimal Price { get; set; }

        [Required]
        public int RestaurantId { get; set; }
    }
}
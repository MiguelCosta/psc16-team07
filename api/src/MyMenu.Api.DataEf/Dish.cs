using System;
using System.ComponentModel.DataAnnotations;

namespace MyMenu.Api.DataEf
{
    public class Dish
    {
        public bool Ative { get; set; }

        public DateTime? Date { get; set; }

        public int DayOfWeek { get; set; }

        [StringLength(1024)]
        public string Description { get; set; }

        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(256, MinimumLength = 2)]
        public string Name { get; set; }

        public string Photo { get; set; }

        [Required]
        public decimal Price { get; set; }

        public virtual Restaurant Restaurant { get; set; }

        [Required]
        public int RestaurantId { get; set; }
    }
}

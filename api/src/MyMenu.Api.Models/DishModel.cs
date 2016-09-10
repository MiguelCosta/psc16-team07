using System;

namespace MyMenu.Api.Models
{
    public class DishModel
    {
        public bool Ative { get; set; }

        public DateTime? Date { get; set; }

        public int DayOfWeek { get; set; }

        public string Description { get; set; }

        public int Id { get; set; }

        public string Name { get; set; }

        public string Photo { get; set; }

        public decimal Price { get; set; }
    }
}

namespace MyMenu.Api.Dtos
{
    public class TypeDto
    {
        public TypeDto()
        {
        }

        public TypeDto(Models.Enums.RestaurantType value)
        {
            Id = (int)value;
            Name = value.ToString();
        }

        public int Id { get; set; }

        public string Name { get; set; }
    }
}

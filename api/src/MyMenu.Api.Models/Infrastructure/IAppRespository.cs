namespace MyMenu.Api.Models.Infrastructure
{
    public interface IAppRespository
    {
        IRestaurantRepsitory Restaurants { get; set; }
    }
}

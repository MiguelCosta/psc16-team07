namespace MyMenu.Api.Models.Infrastructure
{
    public interface IAppRespository
    {
        IDishRepository Dishes { get; set; }

        IRestaurantRepository Restaurants { get; set; }
    }
}

using Microsoft.Practices.Unity;
using MyMenu.Api.DataEf.Infrastructure;
using MyMenu.Api.Models.Infrastructure;
using System.Web.Http;
using Unity.WebApi;

namespace MyMenu.Api
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
            var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            container.RegisterType<IAppRespository, AppRespositoryEf>();

            GlobalConfiguration.Configuration.DependencyResolver = new UnityDependencyResolver(container);
        }
    }
}

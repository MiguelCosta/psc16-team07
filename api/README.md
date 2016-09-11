# MyMenu Api

An Asp,NET API which provides all HTTP requests of MyMenu’s backoffice an IOs App.

### Environment Development

- Visual Studio 2015

### Dependencies 

- [Asp.Net Web Api](http://www.asp.net/web-api) 
- [AutoMapper](https://www.nuget.org/packages/AutoMapper/)
- [Entity Framework](https://www.nuget.org/packages/EntityFramework)
- [Json.NET](http://www.newtonsoft.com/json)
- [LinqKit](https://www.nuget.org/packages/LinqKit/)
- [Microsoft Asp.Net Identity](http://www.asp.net/identity)
- [Unity](https://www.nuget.org/packages/Unity/)

### Production Access
You can have acess of our API on Azure hosting via [http://mymenuapi.azurewebsites.net/](http://mymenuapi.azurewebsites.net/)

### API Documentation
Please refer to our extensive [Wiki documentation](http://mymenuapi.azurewebsites.net/) for more information.

### Project Structure

- **MyMenu.Api**

Asp.Net Web Api responsible by HTTP client requests and responses

- **MyMenu.Api.Models**

Projeto Class Library Project  with no dependency with base system classes

- **MyMenu.Api.DataEf**

Entity Framework Project responsible of SqlServer Database communication. It provides all MyMenu.Api.Models.Infrastructure Interface for WebApi.

### Database Approach

- Azure Sql Server
- Entity Framework Code First





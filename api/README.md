# MyMenu Api

### Libraries

- [Asp.Net Web Api](http://www.asp.net/web-api) 
- [Entity Framework](https://www.nuget.org/packages/EntityFramework)
- [Microsoft Asp.Net Identity](http://www.asp.net/identity)
- [Json.NET](http://www.newtonsoft.com/json)
- [Unity](https://www.nuget.org/packages/Unity/)
- [AutoMapper](https://www.nuget.org/packages/AutoMapper/)
- [LinqKit](https://www.nuget.org/packages/LinqKit/)

### Hosting

- Azure
- http://mymenuapi.azurewebsites.net/

### Documentation

- http://mymenuapi.azurewebsites.net/Help

### Project Structure

- **MyMenu.Api**

Projecto Asp.Net Web Api que é responsável por receber os pedidos HTTP e responder ao cliente.

- **MyMenu.Api.Models**

Projeto Class Library que não tem dependências e contêm as classes base do sistema.

- **MyMenu.Api.DataEf**

Projecto que utiliza Entity Framework para comunicar com a base de dados SqlServer.
Implementa todos os Interfaces MyMenu.Api.Models.Infrastructure para a WebApi conseguir utilizar.

### Database

- Azure Sql Server
- Entity Framework Code First

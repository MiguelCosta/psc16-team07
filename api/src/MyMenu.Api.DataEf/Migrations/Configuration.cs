namespace MyMenu.Api.DataEf.Migrations
{
    using System.Data.Entity.Migrations;

    internal sealed class Configuration : DbMigrationsConfiguration<MyMenu.Api.DataEf.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(MyMenu.Api.DataEf.ApplicationDbContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            //

            SeedRestaurants(context);
        }

        private static void SeedRestaurants(ApplicationDbContext context)
        {
            context.Restaurants.AddOrUpdate(
                            p => p.Id,
                            new Restaurant
                            {
                                Id = 1,
                                Name = "Tomasso’s Pizza & Subs",
                                Address = "Rua do Almada, 151 A, Porto 4050-037, Portugal",
                                Description = "Located in Florida, Tomasso’s Pizza & Subs is an Italian restaurant that offers the best in Italian food. Their menu ranges from a wide variety of pastas, pizzas, calzones, burgers, sandwiches, subs, and more.",
                                Email = "tomasso.email@mail.com",
                                Latitude = 41.1476430000M,
                                Longitude = -8.6122000000M,
                                PhoneNumber = "24 2010763",
                                Type = Models.Enums.RestaurantType.Italian
                            },
                            new Restaurant
                            {
                                Id = 2,
                                Name = "Arby’s",
                                Address = "Rua das Flores, 32, Baixa, Porto",
                                Description = "Arby’s Restaurant is best known for its delicious sandwiches and burgers. They also offer fresh salads, chicken, subs, desserts, and TJ Cinnamons, among others.",
                                Email = "arby.email@mail.com",
                                Latitude = 41.1435345M,
                                Longitude = -8.6164471M,
                                PhoneNumber = "24 2010761",
                                Type = Models.Enums.RestaurantType.Traditional
                            },
                            new Restaurant
                            {
                                Id = 3,
                                Name = "Heart and Soul",
                                Address = "Rua de Guedes de Azevedo 221, Porto, Portugal",
                                Description = "The Heart and Soul restaurant in UK offers its customers good food and good music at the same time. This restaurant prides itself on its menu being fresh, organic, with the food being prepared in a simple manner in order to satisfy their customers’ heart and soul.",
                                Email = "heartandsoul.email@mail.com",
                                Latitude = 41.1522620000M,
                                Longitude = -8.6092916M,
                                PhoneNumber = "24 2010762",
                                Type = Models.Enums.RestaurantType.Mexican
                            },
                            new Restaurant
                            {
                                Id = 4,
                                Name = "Maxie’s Supper Club and Oyster Bar Supper",
                                Address = "Rua do Ouro 508, Porto, Portugal",
                                Description = "Maxie’s Supper Club and Oyster Bar serves the best seafood particularly fresh fish, clams and oysters. But most of all, it offers great Southern Creole and Cajun food. Maxie’s is known for having the best burger in this side of Ithaca.",
                                Email = "maxie.email@mail.com",
                                Latitude = 41.1484400000M,
                                Longitude = -8.6411512M,
                                PhoneNumber = "24 2010764",
                                Type = Models.Enums.RestaurantType.SeaFood
                            },
                            new Restaurant
                            {
                                Id = 5,
                                Name = "Les Fougères Restaurant",
                                Address = "Rua do Almada, 253, Baixa, Porto 4050-038",
                                Description = "Located near the majestic Gatineau Hills, Les Fougères Restaurant offers a country elegance and a magnificent view to the guests while partaking a scrumptuous meal. Les Fougères Restaurant’s menu changes depending on the seasons. They have an la carte menu, a monthly table d’hâute, an 11-course tasting menu, and many more.",
                                Email = "fougeres.email@mail.com",
                                Latitude = 41.1488144M,
                                Longitude = -8.6143679M,
                                PhoneNumber = "24 2010765",
                                Type = Models.Enums.RestaurantType.Italian
                            },
                            new Restaurant
                            {
                                Id = 6,
                                Name = "Ninety Nine Restaurant",
                                Address = "Rua Campo dos Mártires da Pátria, 103, Baixa, Porto",
                                Description = "The Ninety Nine Restaurant offers a great tasting menu to its customers, depending on their varied tastes. From seafood to dessert to Mexican food, everything looks really delicious. Among the Ninety Nine Restaurant’s menu includes the ALL STAR SAMPLER, BONELESS BUFFALO WINGS, TOASTED RAVIOLI, CALYPSO COCONUT SHRIMP, OUTRAGEOUS POTATO SKINS, GOLD FEVER WINGS, and many more.",
                                Email = "ninetynine.email@mail.com",
                                Latitude = 41.1454492M,
                                Longitude = -8.6172115M,
                                PhoneNumber = "24 2010766",
                                Type = Models.Enums.RestaurantType.Mexican
                            },
                            new Restaurant
                            {
                                Id = 7,
                                Name = "Denny’s",
                                Address = "Avenida dos Aliados 237, Porto, Portugal",
                                Description = "Denny’s Restaurant offers a range of delicious American food to their customers. They regularly serve Breakfast, Lunch and Dinner at a great price, and they also offer food especially catered to senior citizens and to the health conscious.",
                                Email = "dennys.email@mail.com",
                                Latitude = 41.1491636M,
                                Longitude = -8.6136065M,
                                PhoneNumber = "24 2010769",
                                Type = Models.Enums.RestaurantType.Indian
                            },
                            new Restaurant
                            {
                                Id = 8,
                                Name = "Culver’s",
                                Address = "Rua de Santa Catarina, 102, Leça da Palmeira, Matosinhos",
                                Description = "Culver’s Restaurant was founded by the Culver family in 1984, which eventually branched out to more than 300 franchised restaurants all over the US. Culver’s is well-known for its ButterBurger, which made the restaurant extremely famous. They also have other items which include salads, sandwiches, desserts, etc.",
                                Email = "culvers.email@mail.com",
                                Latitude = 41.1875969M,
                                Longitude = -8.7036783M,
                                PhoneNumber = "24 2010768",
                                Type = Models.Enums.RestaurantType.Indian
                            },
                            new Restaurant
                            {
                                Id = 9,
                                Name = "Yoshinoya",
                                Address = "Rua Heróis de França, 185, Matosinhos 4450-158",
                                Description = "Yoshinoya is at the same time a Japanese and a fast food restaurant. They offer authentic Japanese food to rice meals to kids meals that are served in a fast and friendly manner.",
                                Email = "yoshina.email@mail.com",
                                Latitude = 41.1840471M,
                                Longitude = -8.6979065M,
                                PhoneNumber = "24 2010767",
                                Type = Models.Enums.RestaurantType.Japanese
                            }
                        );
        }
    }
}

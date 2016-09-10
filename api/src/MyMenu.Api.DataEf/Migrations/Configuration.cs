namespace MyMenu.Api.DataEf.Migrations
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data.Entity.Migrations;
    using System.Text.RegularExpressions;

    internal sealed class Configuration : DbMigrationsConfiguration<MyMenu.Api.DataEf.ApplicationDbContext>
    {
        private static Random _random = new Random();

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
            SeedDishes(context);
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
                                Type = Models.Enums.RestaurantType.Italian,
                                Photo = "1.jpg"
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
                                Type = Models.Enums.RestaurantType.Traditional,
                                Photo = "2.jpg"
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
                                Type = Models.Enums.RestaurantType.Mexican,
                                Photo = "3.jpg"
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
                                Type = Models.Enums.RestaurantType.SeaFood,
                                Photo = "4.jpg"
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
                                Type = Models.Enums.RestaurantType.Italian,
                                Photo = "5.jpg"
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
                                Type = Models.Enums.RestaurantType.Mexican,
                                Photo = "6.jpg"
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
                                Type = Models.Enums.RestaurantType.Indian,
                                Photo = "7.jpg"
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
                                Type = Models.Enums.RestaurantType.Indian,
                                Photo = "8.jpg"
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
                                Type = Models.Enums.RestaurantType.Japanese,
                                Photo = "9.jpg"
                            }
                        );
        }

        private static void SeedDishes(ApplicationDbContext context)
        {
            var info = ReadDishes();

            int restaurantId = 1;
            int dishCount = 0;

            var dishes = new List<Dish>();

            foreach(var i in info)
            {
                var dish = new Dish
                {
                    Ative = true,
                    DayOfWeek = GenerateDayOfWeek(),
                    Description = i.Item3,
                    Id = i.Item1,
                    Name = i.Item2,
                    Photo = $"{i.Item1}.jpg",
                    Price = GeneratePrice(),
                    RestaurantId = restaurantId
                };
                dishes.Add(dish);

                dishCount++;

                if(dishCount == 9) { dishCount = 0; restaurantId++; };
            }

            context.Dishes.AddOrUpdate(
                d => d.Id,
                dishes.ToArray()
            );

        }

        private static int GenerateDayOfWeek()
        {
            int day = _random.Next(7);
            return day;
        }

        private static decimal GeneratePrice()
        {
            double minValue = 3.50;
            double maxValue = 20.50;
            var next = _random.NextDouble();

            var value = minValue + (next * (maxValue - minValue));

            return Convert.ToDecimal(value);
        }

        private static List<Tuple<int, string, string>> ReadDishes()
        {
            List<Tuple<int, string, string>> dishesTuples = new List<Tuple<int, string, string>>();

            var lines = Regex.Split(AllDishesContent(), "\r\n|\r|\n");

            foreach(var line in lines)
            {
                var values = line.Split(';');

                if(values.Length > 1)
                {
                    int id = int.Parse(values[0]);
                    string name = values[1];
                    string description = values.Length == 3 ? values[2] : string.Empty;

                    var info = new Tuple<int, string, string>(id, name, description);

                    dishesTuples.Add(info);
                }
            }

            return dishesTuples;
        }

        /// <summary>
        /// TODO: colocar num ficheiro
        /// </summary>
        /// <returns></returns>
        private static string AllDishesContent()
        {
            string allDishes = @"1;Grilled Salmon   with lentil salad;Premium Copper River King Salmon grilled with salt and pepper and served with a green lentil and grilled vegetable salad.
2;Grilled Salmon Kebabs in an orange and herb marinade;Fresh chunks of salmon marinaded in thyme, lime, lemon and orange juice and then grilled on wooden skewers. These are great summer eats with a cold beer or glass of crisp Sauvignon Blanc.
3;Marsala Risotto with Herbed Shrimp;Marsala Risotto with Herbed Shrimp has a creamy texture of the risotto and all the flavor the herbs gave the shrimp. This lightened up Italian dish is healthy and delicious!
4;Garlic Shrimp Tortellini;This dish as some olive oil, garlic, shrimp, dashes of white wine, salt and pepper are all you need. To jazz up the taste and presentation, I added sun-dried tomato. 
5;Grilled branzino fish with lime and herbs;Grilled whole branzino stuffed with limes and herbs a tasty and healthy dish.
6;Grilled Red Fish with carrot pure;A well-seasoned tomato salsa dresses up these tender, flaky fillets. I'm an empty-nester now, but my sons love this recipe. My husband, Ron, never complains when I make it either! 
7;Southwestern Catfish;Catfish fillets are rubbed with a blend that includes chili powder, cumin, coriander, cayenne and paprika, then topped with homemade salsa. A green salad, garlic bread and baked sweet potatoes round out the meal nicely.
8;Trout with Garlic Vinegar ;This is a traditional sauce from the Azores islands of Portugal that is served over fried fish and often boiled potatoes on the side. Good bread is also a must to dip in the sauce and gather the garlic.
9;Octopus with potatoes;This is based spanish dish. A well cooked octopus with roasted potatoes with herbs & lemon. A fresh and healthy option.
10;Charred Octopus;The Charred Octopus at dell?anima in NYC is unexpectedly delightful mix of rice, beans, chorizo (pork sausage) and chicories (plants related to lettuces that are more bitter in flavor).
11;Gomes de Sa Cod Fish;A typical portuguese dish with cod fish and good oiled potatoes.
12;Mariscada;Mariscada is an Atlantic Seafood inspiration based on rice and very popular along coastal Portugal. The dish often has lobster, shrimp, clams, mussels, as well as cuttlefish and is seasoned with olive oil, sea salt, pepper and Portuguese paprika.
13;Salt Cod and Black Eyed Pea Salad;A fresh salad for a quick lunch, and a hot day. Made with fresh and local ingredients.
14;Bourride - Provencal Soup;Bouillabaisse is traditionally served in two courses starting with the broth ladled into warm bowls and served with garlic croutons, shredded Parmesan, rouille and aioli. After seconds are offered, the whole fish poached in the broth are presented to the table, than fileted and served glistening in more broth. Bourride is made from fish filets cooked in the broth and enriched by a liaison of egg yolks and aioli whisked in at the last moment.
15;Rancheros Skillet;Refried beans, crispy potatoes, warm corn tortillas, poached eggs drenched in Tomato-Chipotle Salsa, avocado slices?..
16;Green Chili Chicken Enchiladas;These Green Chile Chicken Enchiladas use shredded chicken, white beans, corn and plenty of Pepper. This is a hot dish.
17;Mexican Brown Rice Bake  ;Mexican Brown Rice Bake. Fresh, homemade Mexican Style Brown Rice Bake layered with chicken, refried beans & enchilada sauce. 
18;Mexican Chicken Pasta;Mexican Chicken Pasta ? sliced chicken cooked in Mexican spices, with bell peppers and green chiles, in a creamy sauce made with Cheddar and Mozzarella cheeses and spices! You?ll love this easy-to-make comfort food!
19;Sweet Glazed Salmon with Peach Salsa;Sweet Glazed Salmon with Peach Salsa is delicious and healthy! The spicy and sweet jalapeno peach salsa is the perfect combination!
20;Mexican Pizza;A fun Mexican Pizza with a layer of refried beans and spicy ground beef sandwiched between two flour tortillas, topped with salsa, shredded
21;Steak Fajitas;A fun Mexican dish with a layer of refried good and spicy ground beef.
22;Twice baked  chicken fajita sweet potatoes;Chicken Fajita Sweet Potatoes | Healthy and filling comfort food and a deliciously creamy way to change a meal from boring to fiesta!
23;Chicken milanese with spaghetti;This is rainy-day comfort food at its best - flat pasta strips tossed with a rich meaty ragu, creamy chestnuts and fragrant orange zest
24;Aubergine rolls with spinach & ricotta;This spin on Italian 'melanzane alla Parmigiana' makes a deliciously creamy, veggie bake
25;Fig & prosciutto pizzettas;This is rainy-day comfort food at its best - flat pasta strips tossed with a rich meaty ragu, creamy chestnuts and fragrant orange zest
26;Pappardelle with rabbit & chestnut ragu;This is rainy-day comfort food at its best - flat pasta strips tossed with a rich meaty ragu, creamy chestnuts and fragrant orange zest
27;Spinach & feta cannelloni;A plate with fresh spinach and a fresh cannelloni. Made with love.
28;Margherita Pizza;This is a simple Italian classic, topped with tomato sauce, fresh mozzarella and basil. Made with wood-fire which give?s pizza crisp crust.
29;Pasta al forno;This is a simple Italian classic, topped with tomato sauce, fresh mozzarella and basil. 
30;Cheesy Spinach And Artichoke Lasagna;If you know spinach-artichoke dip is the best way to start a party, you can only guess what layering it in lasagna does.
31;Zucchini Lattice Lasagna;This knockout dish is so good, you won't miss the carbs.
32;Pizzagna;The food mashup to end them all.
33;Zucchini Lasagna Roll-Ups;Your low-carb lasagna dreams have come true.
34;Mexican Lasagna;You'll definitely want seconds of this south-of-the-border lasagna.
35;Deconstructed Ricotta Lasagna;All the cheesy goodness of lasagna without the fussy layering.
36;Skillet Ravioli Lasagna With Spicy Italian Sausage;This cheater's lasagna is genius: You start with simmering marinara in a skillet, add ravioli and cooked sausage, and top it off with cheese for a melty one-pot meal.
37;Vodka Lasagna;If you love vodka sauce, this cheesy lasagna recipe will steal your heart.
38;Chicken Parm Lasagna;Any true chicken Parm fan knows that you can turn it into everything from dip to soup. This lasagna might be better than both.
39;Cheesy Taco Lasagna;It's like a five-layer dip lasagna: Salsa swaps in for marinara and beef gets taco seasoning in this tasty Mexican-inspired recipe
40;Cheesy Ravioli Lasagna;This is lasagna made with cheese-stuffed ravioli. Commence freak out.
41;Neapolitan Pizza;This Neapolitan pizza crust is thin, crispy and has the most amazing flavor. My homemade pizza-making is forever changed!
42;Italian Sausage grilled Flatbread Pizza;If you love hot Italian sausage, you just may enjoy our bacon honey bourbon chicken meatballs! The ground chicken is flavored with hot Italian sausage and is totally addicting, I bet you can?t eat just one!
43;Jalape¤o Popper Pizza;Jalape¤o Popper Pizza - All the flavors of a jalape¤o popper is so much better in cheesy pizza form!
44;Shrimp Scampi Pizza;Shrimp Scampi Pizza topped with a light garlic-lemon sauce, shrimp, and cheeses.
45;Three Cheese Pesto Spinach Flatbread Pizza;Aiming to eat more veggies? This Three Cheese Pesto Spinach Flatbread Pizza packs an entire box of spinach into one glorious single-serving?
46;Four Cheese Pizza;This is the perfect dish when you?re craving pizza.
47;Butternut Squash Veggie Pizza;This is the perfect dish when you?re craving pizza but want something new and different.
48;Hawaiian Flatbread Pizzas;This is the perfect dish when you?re craving pizza.
49;Carbonara;This simple Roman pasta dish derives its name from 'carbone' meaning coal. It was a pasta popular with the coal miners. The original recipe calls for guanciale, which is pig's cheek, but since its not easily available, the chef has used bacon instead.
50;Caprese Salad with Pesto Sauce;A great antipasto bite to start your meal with. Juicy tomatoes and mozzarella cheese salad topped with freshly made pesto sauce.
51; Panzenella;Panzenella is a Tuscan bread salad, ideal for summer. It does not follow a particular recipe. but the two ingredients that do not change are tomatoes and bread. This salad is great with a chilled glass of Prosecco and lots of sunshine!
52;Goat Cheese Bruschetta ;Fresh dough is topped with caramelized onions, olives, tomato slices, basil leaves, grated parmesan cheese and baked delicious!
53;Mushroom Risotto;A plateful of buttery risotto with the goodness of mushrooms. Great to feed a hungry horde!
54;Pasta Con Pomodoro E Basilico;This is the most basic and simplest cooked pasta sauce, hence it is the benchmark of a good Italian home cook.
55;Spicy Mushroom Rice;Before you think this Spicy Mushroom Rice is just another average side dish, just give me a minute and let me explain how good it is.
56;Chicken and Potatoes with Garlic Parmesan Cream Sauce;Crisp-tender chicken baked to absolute perfection with potatoes and spinach. A complete meal in one!
57;Salisbury Meatballs and Mashed Potatoes;Baked Meatballs with Mozzarella! Italian meatballs baked in tangy marinara and topped with gobs of buttery, gooey mozzarella.
58;Chicken Chow Mein;A perfect Panda Express Chow Mein Copycat recipe! The only difference you will find is that it is about half as much oil!
59;Gyudon (Japanese Beef & Rice Bowls);This gyudon recipe (or beef donburi recipe) features seasoned, pan-fried beef strips on a bed of Japanese rice.
60;Japanese Kabocha Curry ;This vegan Japanese curry is a more traditional take on our popular Japanese Kabocha Curry recipe. We?ve substituted potatoes for the slightly seasonal kabocha squash, making this a more accessible and year-round vegan Japanese curry.
61;Soba Noodle Soup;This Japanese recipe for soba noodle soup features soba (buckwheat) noodles in a hot dashi broth with fish and vegetable toppings.
62;Veggie Sushi & 3 Different Ways ;A simple vegan sushi you will love it.
63;Dragon Roll;Crunchy shrimp tempura and ttobiko wrapped in nori and rice covered with a layer of sliced avocado.
64;Sushi Burrito;Sushiritto is an inflated sushi roll with Asian & Latin flavors & some organic ingredients.
65;Spicy Honey Garlic Chicken;
66;Oriental Crispy Mushrooms;Oriental crispy mushroom is an Indo Chinese recipe where mushroom are coated in a batter and fried till crisp and then tossed in a spicy
67;Copycat Applebee's Oriental Salad;Sweet and spicy jalape¤o honey garlic chicken recipe. Grilled or pan-fried, this chicken is sure to be a hit!
68;Sesame Kale Noodles;Sesame Kale Noodles - your next last-minute meal. Kale, brussels sprouts, sesame, and noodles equals weeknight, vegan happiness.?
69;Mongolian Beef Noodle Bowls;Gluten-Free Mongolian Beef Noodle Bowls taste just like take out, swapping rice for chewy rice noodles. 
70;Noodles with Pork and Mushrooms;Asian Style Udon Noodles with Pork and Mushrooms - a super quick and incredibly easy udon noodles dish with pork, mushrooms and a spicy sauce. 
71;Quinoa Salad with Chickpeas, Arugula, Feta and Almonds;Salty feta and crunch almonds to round things out.  A touch of sweetness by the addition of raisins and shredded carrots.  And finally, a lemony dressing with a touch of honey helps to keep the arugula from being too overpowering.
72;Beef Taco Salad with cream lime Cilantro Dressing;Along with juicy beef, there?s crisp romaine, sweet corn, juicy tomatoes, hearty black beans, creamy avocado, and crunchy tortilla strips. So many flavors and textures in every bite.
73;Fritos Corn Salad;Fritos Corn Salad will be one salad that no one will forget! Loaded with corn, vegetables, a creamy spiced dressing, and then toss in an entire bag of Fritos Chili Cheese corn chips. Perfect salad for a BBQ, picnic, or a potluck.
74;Cranberry almond broccoli salad;The salad is tossed lightly in a mayo-sour cream based dressing, but I?d say the flavor highlights in this one are the dried cranberries, toasted almonds and crispy prosciutto. It's a good salad recipe to share with friends!
75;Rosemary chicken, bacon and avocado salad.;Creamy avocado, crispy bacon, chicken that is to.die.for ? lots of spring greens and butter lettuce, some sweet cherry tomatoes, watercress and a rosemary vinaigrette that is so wonderful I had to stop myself from drinking it.
76;Skinny Chicken and Avocado Caesar Salad;A beautiful Caesar salad with grilled chicken pieces, creamy avocado slices, eggs and crispy bacon! Turning salad into a main meal!
77;Roasted garlic Pasta Salad;This roasted garlic pasta has a simple ricotta cheese sauce, savory roasted garlic, and fresh spinach and tomato.
78;Avocado Pasta Salad;This yummy pasta salad contains all of my favorites, fresh juicy cherry tomatoes, crispy bacon and deliciously creamy avocados!  However, the best part of this recipe is the luscious avocado dressing?  full of flavor and silky smooth!  To make this a main dish we sometimes add chopped grilled or rotisserie chicken.
79;Spinach Ricotta Pasta;This quick and luxurious Spinach Ricotta Pasta boasts a creamy and garlicky spinach sauce made easy with ricotta cheese.
80;Spinach Enchiladas;Spinach, ricotta cheese, sour cream, and Monterey Jack cheese form the fabulous filling.";

            return allDishes;
        }

    }
}

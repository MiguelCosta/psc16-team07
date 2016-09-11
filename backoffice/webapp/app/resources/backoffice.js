myMenu.factory('BackofficeResource', function ($http, SERVER_ENDPOINT, AUTH_HEADER, BACKOFFICE, common) {
    var backofficeResource = {
        login: function (email, password, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/Token',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    username: email,
                    password: password,
                    grant_type: 'password'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        createAccount: function (email, password, confirmPassword, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/api/Account/Register',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    email: email,
                    password: password,
                    confirmPassword: confirmPassword
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        getRestaurants: function (onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'GET',
                url: SERVER_ENDPOINT + '/api/Restaurants',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        getMenus: function (restaurantId, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'GET',
                url: SERVER_ENDPOINT + '/api/Restaurants/' + restaurantId + '/Dishes',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        createRestaurant: function (token, restaurant, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/api/Restaurants',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'bearer ' + token
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    address: restaurant.address,
                    description: restaurant.description,
                    email: restaurant.email,
                    latitude: restaurant.latitude,
                    longitude: restaurant.longitude,
                    name: restaurant.name,
                    phoneNumber: restaurant.phoneNumber,
                    photo: '',
                    schedule: restaurant.schedule,
                    type: restaurant.type
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        editRestaurant: function (token, restaurantId, restaurant, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'PUT',
                url: SERVER_ENDPOINT + '/api/Restaurants/' + restaurantId,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'bearer ' + token
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    address: restaurant.address,
                    description: restaurant.description,
                    email: restaurant.email,
                    latitude: restaurant.latitude,
                    longitude: restaurant.longitude,
                    name: restaurant.name,
                    phoneNumber: restaurant.phoneNumber,
                    photo: '',
                    schedule: restaurant.schedule,
                    type: restaurant.type
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        createMenu: function (token, menu, onSuccessCallback, onErrorCallback) {

            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/api/Dishes',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'bearer ' + token
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    active: true,
                    //date: menu.date,
                    dayOfWeek: menu.dayOfWeek,
                    description: menu.description,
                    name: menu.name,
                    photo: "photo1.jpg",
                    price: menu.price,
                    restaurantId: menu.restaurantId
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        editMenu: function (token, menu, dishId, onSuccessCallback, onErrorCallback) {

            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/api/Dishes/' + dishId,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'bearer ' + token
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    active: true,
                    //date: menu.date,
                    dayOfWeek: menu.dayOfWeek,
                    description: menu.description,
                    name: menu.name,
                    photo: "photo1.jpg",
                    price: menu.price,
                    restaurantId: menu.restaurantId
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        getImage: function (imageUrl, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'GET',
                url: imageUrl,
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        getAddress: function (lat, lon, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'GET',
                url: 'http://maps.google.com/maps/api/geocode/json?latlng=' + lat + ',' + lon + '&sensor=false',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        }
    };
    return backofficeResource;
});
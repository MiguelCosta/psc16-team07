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
        createRestaurant: function (restaurant, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'POST',
                url: SERVER_ENDPOINT + '/api/Restaurants',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'bearer uDyeGBV0xTkWQevYxCDD-iP1vwsX_FDpmMfmqFOZ5ikzgk6ivAotO1gFEtuplDkBlpV7_owxvH3rPKKnkzyuSzI0d4gxTHPrxdlB7TcmeGYDFPAKLGNXi-AxBijto8inwnTdtTKdxESgIN-V3btZnPGreX9PUzq5r2KUDWPFq1lep5ymi0DW1Y6D4ycCgXapSXtXLJDHlc6SEvWkoypddWrp4omxnvIr4Lyu7NitcJrjMx9NTPKt0nXBO1k6hdZAKk-qk3HNbu-L8-8LxqLNAjZDGzqwcVMOkYP1MdrVV6fzi9uxKxRVLjQGTfNDz_NQ8ShXDt9Uggv2Hc-z3JejHrYmp-25u-v0prOHLOTH2sexQ28OisRKc15kn-ah9dAHKqpi-uiBqdecQlr9as89imQ0kFr5srNPk0u1wXsIzDP-mD9GsRbY6-WH_WEqsSyEXLoVOlSIGqatKJrrar5SLIIglL6f0aKKiRWyd7gs8WX5XqWrSG-flfS8Bn-WZOSx'
                },
                transformRequest: function (obj) {
                    var str = [];
                    for (var p in obj)
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    return str.join("&");
                },
                data: {
                    address: 'Rua Almeida Garrete, 151 A, Porto 4050-241, Portugal',
                    description: restaurant.description,
                    email: restaurant.email,
                    latitude: 0.1,
                    longiture: 0.2,
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
        editRestaurant: function (restaurantId, restaurant, onSuccessCallback, onErrorCallback) {
            var request = $http({
                method: 'PUT',
                url: SERVER_ENDPOINT + '/api/Restaurants/' + restaurantId,
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
                    address: 'Rua Almeida Garrete, 151 A, Porto 4050-241, Portugal',
                    description: restaurant.description,
                    email: restaurant.email,
                    latitude: 0.1,
                    longiture: 0.2,
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
        changeRestaurantStatus: function (restaurantId, status, onSuccessCallback, onErrorCallback) {

            var data = {
                data: {
                    token: "asdasdsad",
                    restaurantId: 12332
                }
            };
            //onErrorCallback(data);
            onSuccessCallback(data);
            return;


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
                    restaurantId: restaurantId,
                    status: status,
                    grant_type: 'password'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        menuEnabledChanged: function (menuId, enabled, onSuccessCallback, onErrorCallback) {

            var data = {
                data: {
                    token: "asdasdsad",
                    restaurantId: 12332
                }
            };
            //onErrorCallback(data);
            onSuccessCallback(data);
            return;


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
                    restaurantId: restaurantId,
                    status: status,
                    grant_type: 'password'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        },
        saveMenu: function (menu, onSuccessCallback, onErrorCallback) {

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
                    restaurantId: restaurantId,
                    status: status,
                    grant_type: 'password'
                }
            });
            request.success(onSuccessCallback);
            request.error(onErrorCallback);
        }
    };
    return backofficeResource;
});
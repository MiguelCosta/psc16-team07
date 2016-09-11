var myMenu = myMenu || {};

myMenu.controller('RestaurantInfo', function ($scope, $filter, $modalInstance, SessionManager, BackofficeResource, SERVER_ENDPOINT, RESTAURANT_TYPE, type, restaurant) {

    $scope.map = {
        center: {
            latitude: 41.1484,
            longitude: -8.6106
        },
        zoom: 16,
        marker: {
            coords: {
                latitude: 41.1484,
                longitude: -8.6106
            }
        },
        events: {
            click: function (map, eventName, originalEventArgs) {
                var e = originalEventArgs[0];
                var lat = e.latLng.lat(), lon = e.latLng.lng();
                var marker = {
                    coords: {
                        latitude: lat,
                        longitude: lon
                    }
                };
                $scope.map.marker = marker;

                BackofficeResource.getAddress(marker.coords.latitude, marker.coords.longitude,
                        function (data) {
                            $scope.data.address = data.results[0].formatted_address;
                            // TODO: actualizar a lista do restaurante que foi editado, na view
                        },
                        function (data, status) {
                            console.log('Error gettings address');
                        });

                $scope.$apply();
            }
        }
    };

    $scope.session = SessionManager;
    $scope.messageType = "Create Restaurant";
    $scope.restaurantType = RESTAURANT_TYPE;
    $scope.errorMessage = "";

    $scope.data = {
        name: "",
        email: "",
        description: "",
        type: {id: 0, name: "Undefined"},
        phoneNumber: "",
        schedule: {
            opening: new Date(1970, 0, 1, 00, 00, 0),
            close: new Date(1970, 0, 1, 23, 59, 0)
        },
        photo: {
            src: "libs/images/image_not_found.jpg",
            isDefaultPhoto: true
        }
    };

    $scope.init = function () {
        if (type === 'editRestaurant') {
            $scope.messageType = 'Edit Restaurant Information';
            $scope.data.name = restaurant.name;
            $scope.data.email = restaurant.email;
            $scope.data.description = restaurant.description;
            $scope.data.type = $scope.restaurantType[restaurant.type];
            $scope.data.phoneNumber = restaurant.phoneNumber;
            $scope.data.address = restaurant.address;
            $scope.map.center.latitude = restaurant.latitude;
            $scope.map.center.longitude = restaurant.longitude;
            $scope.map.marker.coords.latitude = restaurant.latitude;
            $scope.map.marker.coords.longitude = restaurant.longitude;

            if (restaurant.schedule !== null) {
                //var tmpSchedule = '04:17 AM - 20:31 PM';
                var array = restaurant.schedule.split(' - ');
                $scope.data.schedule.opening = $scope.convertHourToDateFormat(array[0]);
                $scope.data.schedule.close = $scope.convertHourToDateFormat(array[1]);
            }

            var menuImage = SERVER_ENDPOINT + "/api/Restaurants/" + restaurant.id + "/Photo";
            BackofficeResource.getImage(menuImage,
                    function (data) {
                        $scope.data.photo.src = menuImage;
                        $scope.data.photo.isDefaultPhoto = false;
                    },
                    function (data, status) {
                        // image not available
                    });
        } else {
            BackofficeResource.getAddress($scope.map.marker.coords.latitude, $scope.map.marker.coords.longitude,
                    function (data) {
                        if (data.results.length > 0) {
                            $scope.data.address = data.results[0].formatted_address;
                        }
                    },
                    function (data, status) {
                        // error getting the address
                    });
        }
    };

    $scope.cancel = function () {
        $modalInstance.close(null);
    };

    $scope.saveRestaurant = function () {

        var newRestaurant = {
            description: $scope.data.description,
            email: $scope.data.email,
            name: $scope.data.name,
            phoneNumber: $scope.data.phoneNumber,
            schedule: $scope.extractFormatedDate($scope.data.schedule.opening) + ' - ' + $scope.extractFormatedDate($scope.data.schedule.close),
            type: $scope.data.type.id,
            address: $scope.data.address,
            latitude: $scope.map.marker.coords.latitude,
            longitude: $scope.map.marker.coords.longitude
        };

        $scope.errorMessage = "";
        if (type === 'createRestaurant') {

            BackofficeResource.createRestaurant($scope.session.getToken(), newRestaurant,
                    function (data) {
                        $modalInstance.close(true);
                    },
                    function (data, status) {
                        $scope.errorMessage = "Error creating restaurant. Try again later.";
                    });

        } else if (type === 'editRestaurant') {

            BackofficeResource.editRestaurant($scope.session.getToken(), restaurant.id, newRestaurant,
                    function (data) {
                        $modalInstance.close(true);
                    },
                    function (data, status) {
                        $scope.errorMessage = "Error editing restaurant. Try again later";
                    });

        }
    };

    $scope.extractFormatedDate = function (date) {
        return $filter('date')(date, 'HH:mm a');
    };

    $scope.convertHourToDateFormat = function (date) {
        var array = date.split(':');
        var hour = array[0];
        array = array[1].split(' ');
        var minute = array[0];
        return new Date(1970, 0, 1, hour, minute, 0);
    };

    $scope.init();
});
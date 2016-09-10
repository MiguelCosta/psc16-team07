var myMenu = myMenu || {};

myMenu.controller('RestaurantInfo', function ($scope, $filter, $modalInstance, SessionManager, BackofficeResource, RESTAURANT_TYPE, type, restaurant) {

    $scope.messageType = "Create Restaurant";
    $scope.restaurantType = RESTAURANT_TYPE;

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
        if (type === 'createRestaurant') {

        } else if (type === 'editRestaurant') {
            $scope.messageType = 'Edit Restaurant Information';
            $scope.data.name = restaurant.name;
            $scope.data.email = restaurant.email;
            $scope.data.description = restaurant.description;
            $scope.data.type = $scope.restaurantType[restaurant.type];
            $scope.data.phoneNumber = restaurant.phoneNumber;

            if (restaurant.schedule !== null) {
                //var tmpSchedule = '04:17 AM - 20:31 PM';
                var array = restaurant.schedule.split(' - ');
                $scope.data.schedule.opening = $scope.convertHourToDateFormat(array[0]);
                $scope.data.schedule.close = $scope.convertHourToDateFormat(array[1]);
            }
        }
    };

    $scope.cancel = function () {

        //var schedule = $scope.extractFormatedDate($scope.data.schedule.opening) + ' - ' + $scope.extractFormatedDate($scope.data.schedule.close);
        //console.log(schedule);

        $modalInstance.close(null);
    };

    $scope.saveRestaurant = function () {

        var newRestaurant = {
            description: $scope.data.description,
            email: $scope.data.email,
            name: $scope.data.name,
            phoneNumber: $scope.data.phoneNumber,
            schedule: $scope.extractFormatedDate($scope.data.schedule.opening) + ' - ' + $scope.extractFormatedDate($scope.data.schedule.close),
            type: $scope.data.type.id
        };

        if (type === 'createRestaurant') {

            BackofficeResource.createRestaurant(newRestaurant,
                    function (data) {
                        // TODO: Data vai receber um restaurante de volta, guarda-o para actualizar à lista
                        //$scope.restaurants.push(restaurant);
                    },
                    function (data, status) {
                        console.log('Error ao criar restaurante');
                        // TODO: mostrar erro ao ir buscar restaurantes
                        // TODO: filtrar para mostrar só os restaurantes desta conta
                    });

        } else if (type === 'editRestaurant') {

            BackofficeResource.editRestaurant(restaurant.id, newRestaurant,
                    function (data) {
                        // TODO: actualizar a lista do restaurante que foi editado, na view
                    },
                    function (data, status) {
                        console.log('Error ao editar restaurante');
                        // TODO: mostrar erro ao ir buscar restaurantes
                        // TODO: filtrar para mostrar só os restaurantes desta conta
                    });

        }

        // TODO: se der erro, fica na modal e mostra o erro

        $modalInstance.close($scope.abc);
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
var myMenu = myMenu || {};

myMenu.controller('Home', function ($scope, $rootScope, $location, SessionManager, BackofficeResource, common, RESTAURANT_TYPE, RESTAURANT_STATUS, DAY_OF_WEEK) {

    $scope.session = SessionManager;
    $scope.location = $location;

    if (angular.isUndefined($scope.session.getToken())) {
        $location.path('/');
    }

    $scope.init = function () {
        $scope.fetchRestaurants();
    };

    /* Restaurant Management */
    $scope.restaurantType = RESTAURANT_TYPE;
    $scope.restaurants = [];
    $scope.selectedRestaurant = null;
    $scope.idSelectedRestaurant = null;

    $scope.getRestaurantType = function (typeId) {
        return $scope.restaurantType[typeId].name;
    };

    $scope.createRestaurant = function () {
        common.showRestaurantInfo('createRestaurant', null, function (result) {
            if (result) {
                $scope.fetchRestaurants();
            }
        });
    };

    $scope.editRestaurantInfo = function (restaurant) {
        common.showRestaurantInfo('editRestaurant', restaurant, function (result) {
            if (result) {
                $scope.fetchRestaurants();
            }
        });
    };

    $scope.showRestaurantMenus = function (restaurant) {
        $scope.idSelectedRestaurant = restaurant.id;

        $scope.menus = [];
        $scope.selectedRestaurant = restaurant;

        BackofficeResource.getMenus(restaurant.id,
                function (data) {
                    $scope.menus = data;
                },
                function (data, status) {
                    // TODO: mostrar erro ao ir buscar restaurantes
                    // TODO: filtrar para mostrar só os restaurantes desta conta
                });
    };

    /* Menu Management */
    $scope.menus = [];
    $scope.mSortType = 'name';
    $scope.mSortReverse = false;

    $scope.getMenuDay = function (menu) {
        if (menu.date !== null) {
            return menu.date;
        }

        return DAY_OF_WEEK[menu.dayOfWeek];
    };

    $scope.createMenu = function () {
        common.showMenuInfo('createMenu', null, $scope.selectedRestaurant.id, function (result) {
            if (result) {
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);
            }
        });
    };

    $scope.editMenu = function (m) {
        common.showMenuInfo('editMenu', m, $scope.selectedRestaurant.id, function (result) {
            if (result) {
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);
            }
        });
    };

    /* Restaurant management */
    $scope.searchDay = new Date();


    /* End of restaurant management */

    /* Account management */
    $scope.rSortType = 'name';
    $scope.rSortReverse = false;
    $scope.status = RESTAURANT_STATUS;

    $scope.restaurantStatusChanged = function (id, status) {
        $scope.session.changeRestaurantStatus(id, status,
                function (data, status) {
                    console.log('restaurant status alterado com sucesso');
                },
                function (data, status) {
                    console.log('deu erro ao alterar restaurant status');
                });
    };

    /* End of account management */


    /* Web Services Call */
    $scope.fetchRestaurants = function () {
        $scope.restaurants = [];

        BackofficeResource.getRestaurants(
                function (data) {
                    $scope.restaurants = data;
                },
                function (data, status) {
                    // TODO: mostrar erro ao ir buscar restaurantes
                    // TODO: filtrar para mostrar só os restaurantes desta conta
                });
    };



    $scope.init();
});


var myMenu = myMenu || {};

myMenu.controller('Home', function ($scope, $rootScope, $location, SessionManager, BackofficeResource, common, RESTAURANT_TYPE, RESTAURANT_STATUS) {

    $scope.session = SessionManager;
    $scope.location = $location;
    $scope.userName = "";

    if (angular.isUndefined($scope.session.getToken())) {
        //$location.path('/');
    }

    $scope.logout = function () {
        $scope.session.logout();
    };

    $scope.showNavbar = function () {
        if ($location.path() !== '/' && $location.path() !== '/create/account')
            return true;
        else
            return false;
    };

    $scope.init = function () {
        $scope.userName = $scope.session.userName;
        console.log('username: ' + $scope.userName);

        $scope.fetchRestaurants();
    };

    /* Restaurant Management */
    $scope.restaurantType = RESTAURANT_TYPE;
    $scope.restaurants = [];
    $scope.selectedRestaurant = null;

    $scope.getRestaurantType = function (typeId) {
        return $scope.restaurantType[typeId].name;
    };

    $scope.createRestaurant = function () {
        common.showRestaurantInfo('createRestaurant', null, function (result) {
            if (result) {
                console.log('save button!');
                console.log(result);
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);

                // TODO mostrar pop up de editar restaurant com sucesso
            }
        });
    };

    $scope.editRestaurantInfo = function (restaurant) {
        common.showRestaurantInfo('editRestaurant', restaurant, function (result) {
            if (result) {
                console.log('save button!');
                console.log(result);
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);

                // TODO mostrar pop up de editar restaurant com sucesso
            }
        });
    };

    $scope.showRestaurantMenus = function (restaurant) {
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



    /* Restaurant management */
    $scope.mSortType = 'name';
    $scope.mSortReverse = false;
    $scope.menuEnabled = ["true", "false"];
    $scope.searchDay = new Date();

    $scope.createMenu = function () {
        common.showCreateMenu('createMenu', null, function (result) {
            if (result) {
                console.log('save button!');
                console.log(result);
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);
            }
        });
    };

    $scope.menuEnabledChanged = function (id, enabled) {
        console.log('new valor: ' + enabled);
        $scope.session.menuEnabledChanged(id, enabled,
                function (data, status) {
                    console.log('menu enabled alterado com sucesso');
                },
                function (data, status) {
                    console.log('deu erro ao alterar menu enabled');
                });
    };

    $scope.editMenu = function (m) {
        common.showCreateMenu('editMenu', m, function (result) {
            if (result) {
                console.log('edit successfully!');
                console.log(result);
                //$scope.searchParams.colors = result;
                //$scope.searchParams.flatColors = getColorTags(result);
            }
        });
    };

    $scope.searchMenus = function () {
        var menu1 = {
            id: 00123,
            enabled: "true",
            name: 'Tasquinha Bracarense 0000',
            description: 'Frango, batatas fritas e sopa com bebida',
            price: 5.5,
            photo: 'image1.jpg',
            day: 'SEG QUA'
        };
        $scope.menus.push(menu1);

        var menu2 = {
            id: 43423,
            enabled: "false",
            name: 'Mac Donalds 111111',
            description: 'Feijoada, sopa, pão e bebida',
            price: 7.0,
            photo: 'image2.jpg',
            day: '2016-09-07'
        };
        $scope.menus.push(menu2);
    };

    /* End of restaurant management */

    /* Account management */
    //$scope.restaurants = [];
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


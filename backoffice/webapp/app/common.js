var myMenu = myMenu || {};

myMenu.factory('common', function ($modal) {
    return {
        showRestaurantInfo: function (recType, recRestaurant, onResultCallback) {
            var modalInstance = $modal.open({
                templateUrl: 'app/views/modal/restaurantInfo.html',
                controller: 'RestaurantInfo',
                keyboard: false,
                backdrop: 'static',
                resolve: {
                    type: function () {
                        return recType;
                    },
                    restaurant: function () {
                        return recRestaurant;
                    }
                }
            });

            modalInstance.result.then(onResultCallback);
        },
        showMenuInfo: function (recType, recMenu, recRestaurantId, onResultCallback) {
            var modalInstance = $modal.open({
                templateUrl: 'app/views/modal/menuInfo.html',
                controller: 'MenuInfo',
                keyboard: false,
                backdrop: 'static',
                resolve: {
                    type: function () {
                        return recType;
                    },
                    menu: function () {
                        return recMenu;
                    },
                    restaurantId: function () {
                        return recRestaurantId;
                    }
                }
            });

            modalInstance.result.then(onResultCallback);
        }
    };
});

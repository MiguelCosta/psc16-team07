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
        showCreateMenu: function (recType, recMenu, onResultCallback) {
            var modalInstance = $modal.open({
                templateUrl: 'app/views/modal/createMenu.html',
                controller: 'CreateMenu',
                keyboard: false,
                backdrop: 'static',
                resolve: {
                    type: function () {
                        return recType;
                    },
                    menu: function () {
                        return recMenu;
                    }
                }
            });

            modalInstance.result.then(onResultCallback);
        }
    };
});

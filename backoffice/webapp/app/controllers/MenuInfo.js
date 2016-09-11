var myMenu = myMenu || {};

myMenu.controller('MenuInfo', function ($scope, $modalInstance, SessionManager, BackofficeResource, SERVER_ENDPOINT, DAY_OF_WEEK, type, menu, restaurantId) {

    $scope.session = SessionManager;
    $scope.dayOfWeek = DAY_OF_WEEK;
    $scope.messageType = 'Create a Menu';
    $scope.minDate = new Date();

    $scope.errorMessage = "";

    $scope.data = {
        name: "",
        description: "",
        price: 0,
        date: {
            checked: true,
            day: new Date()
        },
        dayOfWeek: {
            checked: false,
            day: 'Monday'
        },
        photo: {
            src: "libs/images/image_not_found.jpg",
            isDefaultPhoto: true
        }
    };


    $scope.init = function () {
        if (type === 'editMenu') {
            $scope.messageType = 'Edit your Menu';
            $scope.data.name = menu.name;
            $scope.data.description = menu.description;
            $scope.data.price = menu.price;

            if (menu.dayOfWeek !== null) {
                $scope.data.dayOfWeek.day = $scope.dayOfWeek[menu.dayOfWeek];
                $scope.data.dayOfWeek.checked = true;
                $scope.data.date.checked = false;
            } else if (menu.date === null) {
                // TODO: mostrar menu date
            }

            var menuImage = SERVER_ENDPOINT + "/api/Dishes/" + menu.id + "/Photo";
            BackofficeResource.getImage(menuImage,
                    function (data) {
                        $scope.data.photo.src = menuImage;
                        $scope.data.photo.isDefaultPhoto = false;
                    },
                    function (data, status) {
                        // image not available
                    });
        }
    };

    $scope.singleDayMenuClicked = function () {
        $scope.data.dayOfWeek.checked = false;
    };

    $scope.weeklyDayMenuClicked = function () {
        $scope.data.date.checked = false;
    };

    $scope.cancel = function () {
        $modalInstance.close(null);
    };

    $scope.saveMenu = function () {

        var newMenu = {
            date: null,
            dayOfWeek: 0,
            description: $scope.data.description,
            name: $scope.data.name,
            price: $scope.data.price,
            restaurantId: restaurantId
        };

        if ($scope.data.dayOfWeek.checked) {
            if ($scope.data.dayOfWeek.day === 'Sunday') {
                newMenu.dayOfWeek = 0;
            } else if ($scope.data.dayOfWeek.day === 'Monday') {
                newMenu.dayOfWeek = 1;
            } else if ($scope.data.dayOfWeek.day === 'Tuesday') {
                newMenu.dayOfWeek = 2;
            } else if ($scope.data.dayOfWeek.day === 'Wednesday') {
                newMenu.dayOfWeek = 3;
            } else if ($scope.data.dayOfWeek.day === 'Thursday') {
                newMenu.dayOfWeek = 4;
            } else if ($scope.data.dayOfWeek.day === 'Friday') {
                newMenu.dayOfWeek = 5;
            } else if ($scope.data.dayOfWeek.day === 'Saturday') {
                newMenu.dayOfWeek = 6;
            }
        } else {

        }

        if (type === 'createMenu') {

            BackofficeResource.createMenu($scope.session.getToken(), newMenu,
                    function (data) {
                        $modalInstance.close(true);
                    },
                    function (data, status) {
                        $scope.errorMessage = "Error creating menu. Try again later";
                    });

        } else if (type === 'editMenu') {

            BackofficeResource.editMenu($scope.session.getToken(), newMenu, menu.id,
                    function (data) {
                        $modalInstance.close(true);
                    },
                    function (data, status) {
                        $scope.errorMessage = "Error editing menu. Try again later";
                    });
        }
    };

    $scope.init();

});
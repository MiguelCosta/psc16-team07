var myMenu = myMenu || {};

myMenu.controller('CreateMenu', function ($scope, $modalInstance, SessionManager, type, menu) {

    $scope.session = SessionManager;
    $scope.messageType = 'Create a new Menu';
    $scope.minDate = new Date();

    $scope.data = {
        name: "",
        description: "",
        price: 0,
        date: {
            day: new Date(),
            days: {
                mon: false,
                tue: false,
                wed: false,
                thu: false,
                fri: false,
                sat: false,
                sun: false
            }
        },
        photo: {
            src: "libs/images/image_not_found.jpg",
            isDefaultPhoto: true
        }
    };

    if (type === 'createMenu') {

    } else if (type === 'editMenu') {
        $scope.messageType = 'Edit your Menu';
        $scope.data.name = menu.name;
        $scope.data.description = menu.description;
        $scope.data.price = menu.price;
    }

    $scope.toggleWeekDay = function (button) {
        if (button === 1) {
            $scope.data.date.days.mon = !$scope.data.date.days.mon;
        } else if (button === 2) {
            $scope.data.date.days.tue = !$scope.data.date.days.tue;
        } else if (button === 3) {
            $scope.data.date.days.wed = !$scope.data.date.days.wed;
        } else if (button === 4) {
            $scope.data.date.days.thu = !$scope.data.date.days.thu;
        } else if (button === 5) {
            $scope.data.date.days.fri = !$scope.data.date.days.fri;
        } else if (button === 6) {
            $scope.data.date.days.sat = !$scope.data.date.days.sat;
        } else if (button === 7) {
            $scope.data.date.days.sun = !$scope.data.date.days.sun;
        }
    };


    console.log(type);
    console.log(menu);
    $scope.abc = 'return';

    $scope.cancel = function () {
        $modalInstance.close(null);
    };

    $scope.saveMenu = function () {

        var menu = {
            name: $scope.data.name,
            description: $scope.data.description,
            price: $scope.data.price,
        };

        $scope.session.saveMenu(menu,
                function (data, status) {
                    console.log('save menu alterado com sucesso');
                },
                function (data, status) {
                    console.log('save menu error');
                });

        $modalInstance.close($scope.abc);
    };

});
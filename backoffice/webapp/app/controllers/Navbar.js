var myMenu = myMenu || {};

myMenu.controller('Navbar', function ($scope, $timeout, $location, SessionManager) {

    $scope.session = SessionManager;
    $scope.location = $location;
    $scope.userName = "";

    $scope.callAtTimeout = function () {
        if ($scope.session.userName !== null && $scope.session.userName !== "") {
            $scope.userName = $scope.session.userName;
            return;
        }

        $timeout(function () {
            $scope.callAtTimeout();
        }, 1000);
    };

    $timeout(function () {
        $scope.callAtTimeout();
    }, 1000);

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
    };

    $scope.init();
});
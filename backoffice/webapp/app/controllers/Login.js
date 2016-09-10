var myMenu = myMenu || {};

myMenu.controller('Login', function ($scope, $rootScope, $location, SessionManager) {

    $scope.session = SessionManager;
    $scope.credentials = {
        email: "sergio.fil@gmail.com",
        password: "12345"
    };

    $scope.status = {
        error: {
            message: null
        },
        isProcessing: false
    };

    /* ---------- Web Service calls ---------- */
    /**
     * Processes an attempt of a Backoffice login.
     */
    $scope.processLogin = function () {
        $scope.resetStatus();
        $scope.status.isProcessing = true;

        $scope.session.login($scope.credentials.email, $scope.credentials.password,
                function (data, status) {
                    $scope.status.isProcessing = false;
                    $location.path('/home').replace();
                },
                function (data, status) {
                    $scope.status.isProcessing = false;
                    if (data !== null && data.error_description !== null) {
                        $scope.status.error.message = data.error_description;
                    } else {
                        $scope.status.error.message = "Unexpected error. Try again later.";
                    }
                });
    };

    $scope.createAccount = function () {
        $location.path('/create/account').replace();
    };


    /* ----------- View  functions ----------- */
    /**
     * Resets the Status properties to their default values.
     */
    $scope.resetStatus = function () {
        $scope.status.error.message = null;
    };

});
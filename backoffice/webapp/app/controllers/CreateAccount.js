var myMenu = myMenu || {};

myMenu.controller('CreateAccount', function ($scope, $rootScope, $location, SessionManager, RESTAURANT_TYPE) {

    $scope.session = SessionManager;
    $scope.type = RESTAURANT_TYPE;
    $scope.data = {
        email: "",
        password: "",
        confirmPassword: ""
    };

    $scope.status = {
        error: {
            message: null
        },
        isProcessing: false
    };

    $scope.isDataValid = function () {
        if ($scope.data.email === "" || $scope.data.password === "" || $scope.data.confirmPassword === "") {
            return false;
        }

        return true;
    };

    /* ---------- Web Service calls ---------- */
    /**
     * Processes an attempt of a Backoffice login.
     */
    $scope.createAccount = function () {

        if ($scope.data.email === undefined) {
            $scope.status.error.message = "Invalid email address.";
            return;
        }

        if ($scope.data.password !== $scope.data.confirmPassword) {
            $scope.status.error.message = "Password and Confirm Password don't match.";
            return;
        }

        $scope.resetStatus();
        $scope.status.isProcessing = true;

        $scope.session.createAccount($scope.data.email, $scope.data.password, $scope.data.confirmPassword,
                function (data, status) {
                    $scope.status.isProcessing = false;
                    $location.path('/home').replace();
                },
                function (data, status) {
                    $scope.status.isProcessing = false;
                    if (data !== null && data.modelState !== null && data.modelState !== null && data.modelState.lenght >= 1) {
                        $scope.status.error.message = data.modelState[0];
                    } else {
                        $scope.status.error.message = "Unexpected error. Try again later.";
                    }

                });
    };

    /* ----------- View  functions ----------- */
    /**
     * Resets the Status properties to their default values.
     */
    $scope.resetStatus = function () {
        $scope.status.error.message = null;
    };

});

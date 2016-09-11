var myMenu = myMenu || {};

myMenu.factory('SessionManager', function ($rootScope, $cookieStore, AUTH_HEADER, BackofficeResource, $location) {

    var sessionState = {
        client: null,
        token: null,
        userName: null,
        isAdmin: false,
        login: function (email, password, onSuccessCallback, onErrorCallback) {
            var me = this;

            BackofficeResource.login(email, password,
                    function (data) {
                        me.storeToken(data.access_token);
                        me.storeUserName(data.userName);
                        onSuccessCallback();
                    },
                    function (data, status) {
                        onErrorCallback(data, status);
                    });
        },
        createAccount: function (email, password, confirmPassword, onSuccessCallback, onErrorCallback) {

            BackofficeResource.createAccount(email, password, confirmPassword,
                    function (data) {
                        onSuccessCallback();
                    },
                    function (data, status) {
                        onErrorCallback(data, status);
                    });
        },
        /**
         * Attempts to log out a client from the Backoffice
         */
        logout: function () {
            var me = this;

            me.storeUserName(null);
            me.clearToken();
            $location.path('/');
        },
        /**
         * Retrieves a token from a cookie
         */
        getToken: function () {
            return $cookieStore.get(AUTH_HEADER);
        },
        /**
         * Removes a token from a cookie
         */
        clearToken: function () {
            this.token = null;
            $cookieStore.remove(AUTH_HEADER);
        },
        /**
         * Stores a token in a cookie
         * @param {type} token Token to be stored in the cookie
         */
        storeToken: function (token) {
            if (token) {
                this.token = token;
                $cookieStore.put(AUTH_HEADER, token);
            }
        },
        storeUserName: function (userName) {
            if (userName) {
                this.userName = userName;
            }
        }
    };

    sessionState.storeToken($cookieStore.get(AUTH_HEADER));

    return sessionState;
});

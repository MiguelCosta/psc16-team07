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
        createClient: function (name, email, onSuccessCallback, onErrorCallback) {
            var me = this;

            /*ClientResource.createClient(this.token, name, email,
             function (data) {
             onSuccessCallback(data);
             },
             function (data, status) {
             if (status === 401) {
             me.logout();
             }
             onErrorCallback(data, status);
             });*/
        },
        changeRestaurantStatus: function (restaurantId, status, onSuccessCallback, onErrorCallback) {

            BackofficeResource.changeRestaurantStatus(restaurantId, status,
                    function (data) {
                        onSuccessCallback();
                    },
                    function (data, status) {
                        onErrorCallback(data, status);
                    });
        },
        menuEnabledChanged: function (menuId, enabled, onSuccessCallback, onErrorCallback) {

            BackofficeResource.changeRestaurantStatus(menuId, enabled,
                    function (data) {
                        onSuccessCallback();
                    },
                    function (data, status) {
                        onErrorCallback(data, status);
                    });
        },
        saveMenu: function (menu, onSuccessCallback, onErrorCallback) {

            BackofficeResource.saveMenu(menu,
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
            /*ClientResource.logout(this.token,
             function () {
             me.client = null;
             me.token = null;
             me.clearToken();
             $location.path('/');
             },
             function (data, status) {
             // TODO: Replace with a Modal dialog
             console.log('Failed to log out with server ', status);
             });*/
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
                this.getClient();
            }
        },
        storeUserName: function (userName) {
            if (userName) {
                this.userName = userName;
            }
        },
        /**
         * Attempts to retrieve profile details of a client with a given token
         */
        getClient: function () {
            var me = this;

            /*ClientResource.getClientProfile(me.token,
             function (data) {
             me.client = data.data;
             $rootScope.isClientAdmin = me.client.isAdmin;
             me.clientId = data.data.clientId;
             me.clientKey = data.data.clientKey;
             //me.fetchPermissions();
             },
             function () {
             // TODO: Add a Modal dialog
             me.logout();
             });*/
        }
    };

    sessionState.storeToken($cookieStore.get(AUTH_HEADER));

    return sessionState;
});

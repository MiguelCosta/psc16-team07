var myMenu = angular.module('myMenu', ['ngRoute', 'ngCookies', 'ngGrid', 'ui.bootstrap', 'ui.sortable', 'ngMaterial', 'ngMessages']).run(function ($rootScope, $timeout) {

});

myMenu.config(function ($locationProvider, $routeProvider, CONTEXT_ROOT) {

    $locationProvider.html5Mode(false).hashPrefix('!');
    $routeProvider
            .when('/', {
                templateUrl: CONTEXT_ROOT + 'app/views/other/login-page.html',
                controller: 'Login'
            })
            .when('/create/account', {
                templateUrl: CONTEXT_ROOT + 'app/views/other/create-account.html',
                controller: 'CreateAccount'
            })
            .when('/home', {
                templateUrl: CONTEXT_ROOT + 'app/views/home.html',
                controller: 'Home'
            })
            .when('/404', {
                templateUrl: CONTEXT_ROOT + 'app/views/other/404-page.html'
            })
            .when('/account', {
                templateUrl: CONTEXT_ROOT + 'app/views/account.html',
                controller: 'Account'
            })
            .otherwise({redirectTo: '/404'});
});

myMenu.config(function ($mdDateLocaleProvider) {
    $mdDateLocaleProvider.formatDate = function (date) {
        return moment(date).format('YYYY-MM-DD');
    };
});

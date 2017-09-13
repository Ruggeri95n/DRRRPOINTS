// create the module
var indexApp = angular.module('pointApp', ['ngRoute', 'ngStorage']);

//  Aggiunta della variabile e funzione globali per nascondere/mostrare il menù
indexApp.run(function ($rootScope) {
    $rootScope.logIn = false;
    $rootScope.hideMenu = function (value) {
        $rootScope.logIn = value;
    };
});

// configure our routes
indexApp.config(function ($routeProvider) {
    $routeProvider.when('/', {
        templateUrl: './home.html',
        controller: 'homeController'
    })
        .when('/login', {
            templateUrl: './login.html',
            controller: 'gestisciLogin'
        })
        .when('/screen', {
            templateUrl: './screenForum.html',
            controller: 'gestisciScreen'
        })
        .when('/singup', {
            templateUrl: './singup.html',
            controller: 'gestisciSingup'
        })
        .when('/logout', {
            templateUrl: './out.html',
            controller: 'gestisciLogout'
        });
});

//  variabile contenente il token
var curToken = { value: "", enable: false };

// create the controller and inject Angular's $scope
indexApp.controller('homeController', function ($scope, $http) {
    $scope.message = "Home Page";
    $scope.page = 1;

    $scope.next = function () {
        var extra = 0;

        if ($scope.allUsers.length % 16 > 0)
            extra = 1;

        if ($scope.page + 1 <= ($scope.allUsers.length / 16) + extra)
        {
            $scope.page++;
            visualizza($scope.page, $scope.allUsers);
        }
    };

    $scope.previous = function () {
        if ($scope.page > 1) {
            $scope.page--;
            visualizza($scope.page, $scope.allUsers);
        }
    };

    $http({
        method: "POST",
        url: "http://localhost:3001/users",
        headers: { 'Content-Type': 'application/json' }
    }).then(function (response) {
        if (response.data.success) {
            $scope.allUsers = response.data.users;

            visualizza($scope.page, $scope.allUsers);
        }
    });

    var visualizza = function(pagina, utenti) {
        var dataMat = [];
        var i = (16 * (pagina - 1)), j = 0;

        dataMat[0] = [];

        while (i < (pagina * 16) && i < utenti.length) {
            if (!utenti[i].punti)
                utenti[i].punti = 0;

            dataMat[j].push(utenti[i]);
            i++;

            if ((i < (pagina * 16) && i < utenti.length) && (i % 4 == 0)) {
                j++;
                dataMat[j] = [];
            }
        }
        $scope.Users = dataMat;
    };
});

indexApp.controller('gestisciLogout', function ($scope, $location) {
    $scope.hideMenu(false);
    curToken = { value: "", enable: false };
    $location.path('/home');
});

/**
 * Username is the e-mail of the persone who want to access in it's personal profile
 */
indexApp.controller('gestisciLogin', function ($scope, $http, $location) {
    //messaggio di entrata
    $scope.message = "Login page";

    //   Autenticazione via token (se si è precedentementi loggati)
    if (curToken.enable == true) {
        $http({
            method: "POST",
            url: "http://localhost:3001/api",
            headers: { 'Content-Type': 'application/json' },
            data: { 'token': curToken.value }
        }).then(function (response) {
            if (response.data.success) {
                alert(response.data.message);
                $location.path('/home');
            }
            else
                alert("Error! " + response.data.message);
        });
    }

    // funzione per l'invio dei dati di login a node
    $scope.login = function () {
        var parametri = {
            name: $scope.username,
            password: $scope.password
        };

        $http({
            method: "POST",
            url: "http://localhost:3001/api/authenticate",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                curToken.value = response.data.token;
                curToken.enable = true;
                $scope.hideMenu(true);
                $location.path('/home');
            }
            else
                alert("Error! " + response.data.message);
        }, function (response) {
            alert("Si è verificato un errore nella richiesta di autenticazione!");
        });
    }
});

indexApp.controller("gestisciSingup", function ($scope, $http) {
    $scope.message = "Registrati";

    $scope.registra = function () {
        var parametri = {
            user: {
                name: $scope.username,
                password: $scope.password,
                pic: $scope.selectedPic
            }
        };

        $http({
            method: "POST",
            url: "http://localhost:3001/singup",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                alert(response.data.message);
                $location.path('/home');
            }
            else
                alert(response.data.message);
        }, function (response) {
            alert("Si è verificato un errore nella richiesta di registrazione!");
        });
    }
});

// gestisciScreen
indexApp.controller("gestisciScreen", function ($scope, $http) {
    $scope.message = "Area Screen";
    $scope.notLogin = false;

    var parametri = {
        token: curToken.value,
        start: 0,
        end: 10
    };

    $http({
        method: "POST",
        url: "http://localhost:3001/api/getScreen",
        headers: { 'Content-Type': 'application/json' },
        data: parametri
    }).then(function (response) {
        if (response.data.success)
            $scope.Foto = response.data.post;
        else
            alert(response.data.message)
    }, function (errore) {
        $scope.notLogin = true;
    });

    $scope.plusOne = function (index) {
        $scope.Foto[index].like++;
    };

    $scope.minusOne = function (index) {
        $scope.Foto[index].dislike++;
    };
});

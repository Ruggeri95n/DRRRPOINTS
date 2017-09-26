// create the module
var indexApp = angular.module('pointApp', ['ngRoute', 'ngStorage', 'ngFileUpload', 'ngStorage']);
var ipserver = "2.226.207.189";

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

var menuSet = function (val) {
    if (val == 0) {
        e1 = document.getElementById("linkHome");
        e1.setAttribute("class", "active");

        e2 = document.getElementById("linkScreen");
        e2.setAttribute("class", "");

        //e3 = document.getElementById("mio_elemento");
        //e3.setAttribute("class", "");
    }
    else
        if (val == 1) {
            e1 = document.getElementById("linkHome");
            e1.setAttribute("class", "");

            e2 = document.getElementById("linkScreen");
            e2.setAttribute("class", "active");

            //e3 = document.getElementById("mio_elemento");
            //e3.setAttribute("class", "");
        }
        else
            if (val == 2) {
                e1 = document.getElementById("linkHome");
                e1.setAttribute("class", "");

                e2 = document.getElementById("linkScreen");
                e2.setAttribute("class", "");

                //e3 = document.getElementById("mio_elemento");
                //e3.setAttribute("class", "active");
            }
            else {
                e1 = document.getElementById("linkHome");
                e1.setAttribute("class", "");

                e2 = document.getElementById("linkScreen");
                e2.setAttribute("class", "");

                //e3 = document.getElementById("mio_elemento");
                //e3.setAttribute("class", "");
            }

};

// create the controller and inject Angular's $scope
indexApp.controller('homeController', function ($scope, $http, $localStorage) {
    if ($localStorage.XToken) {
        curToken = $localStorage.XToken;
        $scope.hideMenu(true);
    }

    menuSet(0);

    $scope.message = "Home Page";
    $scope.Users = [];
    $scope.Users[0] = [{ pic: '' }, { pic: '' }, { pic: '' }, { pic: '' }];
    $scope.page = 1;

    $scope.next = function () {
        var extra = 0;

        if ($scope.allUsers.length % 16 > 0)
            extra = 1;

        if ($scope.page + 1 <= ($scope.allUsers.length / 16) + extra) {
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
        url: "http://"+ipserver+":3001/users",
        headers: { 'Content-Type': 'application/json' }
    }).then(function (response) {
        if (response.data.success) {
            $scope.allUsers = response.data.users;
            visualizza($scope.page, $scope.allUsers);
        }
    });

    var visualizza = function (pagina, utenti) {
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

indexApp.controller('gestisciLogout', function ($scope, $location, $localStorage) {
    $scope.hideMenu(false);
    curToken = { value: "", enable: false };
    $localStorage.XToken = null;
    $location.path('/');
});

/**
 * Username is the e-mail of the persone who want to access in it's personal profile
 */
indexApp.controller('gestisciLogin', function ($scope, $http, $location, $localStorage) {
    if ($localStorage.XToken) {
        curToken = $localStorage.XToken;
        $scope.hideMenu(true);
    }

    menuSet();

    $scope.message = "Login page";

    //   Autenticazione via token (se si è precedentementi loggati)
    if (curToken.enable == true) {
        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/api",
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

        if ($scope.username == undefined)
            return;
        else
            if ($scope.username.length < 4)
                return;

        if ($scope.password == undefined)
            return;
        else
            if ($scope.password.length < 4)
                return;

        var parametri = {
            name: $scope.username,
            password: CryptoJS.SHA1($scope.password).toString()
        };

        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/api/authenticate",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                curToken.value = response.data.token;
                curToken.enable = true;
                $scope.hideMenu(true);
                $localStorage.XToken = curToken;
                $location.path('/screen');
            }
            else
                alert("Errore! " + response.data.message);
        }, function (response) {
            alert("Si è verificato un errore nella richiesta di autenticazione!");
        });
    }
});

indexApp.controller("gestisciSingup", function ($scope, $http, $location, $localStorage) {
    if ($localStorage.XToken) {
        curToken = $localStorage.XToken;
        $scope.hideMenu(true);
    }

    menuSet();

    $scope.message = "Registrati";

    $scope.registra = function () {
        var pic = $scope.selectedPic || 'pic/shinra.png';

        var parametri = {
            user: {
                name: $scope.username,
                password: CryptoJS.SHA1($scope.password).toString(),
                pic: pic
            }
        };

        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/singup",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                alert(response.data.message);
                $location.path('/login');
            }
            else
                alert(response.data.message);
        }, function (response) {
            alert("Si è verificato un errore nella richiesta di registrazione!");
        });
    }
});

indexApp.controller("gestisciScreen", function ($scope, $http, $window, $localStorage, Upload) {
    if ($localStorage.XToken) {
        curToken = $localStorage.XToken;
        $scope.hideMenu(true);
    }
    else
        if (!curToken.value)
            return;

    menuSet(1);

    $scope.page = 1;
    $scope.notLogin = true;
    $scope.orderBy = 'numero';
    $scope.orderValue = 1;

    var parametri = {
        token: curToken.value,
        end: 50,
        orderBy: $scope.orderBy,
        orderValue: $scope.orderValue
    };

    $http({
        method: "POST",
        url: "http://"+ipserver+":3001/api/getScreen",
        headers: { 'Content-Type': 'application/json' },
        data: parametri
    }).then(function (response) {
        if (response.data.success) {
            $scope.notLogin = false;
            $scope.allScreen = response.data.post;

            visualizza($scope.page, $scope.allScreen);
        }
        else
            alert(response.data.message);
    }, function (errore) {
        $scope.notLogin = true;
    });

    var visualizza = function (pagina, post) {
        var post_for_page = 10;
        var start = post_for_page * (pagina - 1);
        var end = post_for_page * pagina;

        if (end > post.length)
            end = post.length;

        var app = [];
        var j = 0;

        for (var i = start; i < end; i++) {
            app[j] = post[i];
            j++;
        }

        $scope.Foto = app;
    };

    var chiediScreen = function (morePag) {
        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/api/getScreen",
            headers: { 'Content-Type': 'application/json' },
            data: {
                token: curToken.value,
                end: (($scope.page + 1) * 10) + 50,
                orderBy: $scope.orderBy,
                orderValue: $scope.orderValue
            }
        }).then(function (response) {
            if (response.data.success) {
                $scope.allScreen = response.data.post;

                if (morePag) {
                    var extra = 0;

                    if (($scope.allScreen.length % 10) > 0)
                        extra = 1;

                    if ($scope.page + 1 <= ($scope.allScreen.length / 10) + extra) {
                        $scope.page++;
                        visualizza($scope.page, $scope.allScreen);
                        $window.scrollTo(0, 0);
                    }
                }
                else
                    visualizza($scope.page, $scope.allScreen);
            }
            else
                alert(response.data.message);
        }, function (errore) {
            //$scope.notLogin = true;
            alert('Errore!');
        });
    };

    $scope.plusOne = function (index) {
        var parametri = {
            token: curToken.value,
            id_screen: $scope.Foto[index].numero,
            voto: 1
        };

        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/api/votaScreen",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                $scope.Foto[index].n_like++;
                if (response.data.reverse)
                    $scope.Foto[index].n_dislike--;
            }
        });
    };

    $scope.minusOne = function (index) {
        var parametri = {
            token: curToken.value,
            id_screen: $scope.Foto[index].numero,
            voto: 0
        };

        $http({
            method: "POST",
            url: "http://"+ipserver+":3001/api/votaScreen",
            headers: { 'Content-Type': 'application/json' },
            data: parametri
        }).then(function (response) {
            if (response.data.success) {
                $scope.Foto[index].n_dislike++;
                if (response.data.reverse)
                    $scope.Foto[index].n_like--;
            }
        });
    };

    $scope.nextPost = function () {
        var extra = 0;

        if (($scope.allScreen.length % 10) > 0)
            extra = 1;

        if ($scope.page + 1 <= ($scope.allScreen.length / 10) + extra) {
            $scope.page++;
            visualizza($scope.page, $scope.allScreen);
            $window.scrollTo(0, 0);
        }
        else
            chiediScreen(true);
    };

    $scope.previousPost = function () {
        if ($scope.page > 1) {
            $scope.page--;
            visualizza($scope.page, $scope.allScreen);
            $window.scrollTo(0, 0);
        }
    };

    $scope.sendScreen = function () {
        if ($scope.titolo == undefined || $scope.titolo.length < 1) {
            $scope.fileError = "Impossibile inviare uno screen senza titolo.";
            return;
        }

        if (!$scope.file) {
            $scope.fileError = "Devi prima selezionare lo screen...";
            return;
        }

        $scope.fileError = "";

        Upload.upload({
            url: "http://"+ipserver+":3001/api/uploadScreen",
            method: 'POST',
            data: {
                titolo: $scope.titolo,
                descrizione: $scope.descrizione,
                token: curToken.value
            },
            file: $scope.file
        }).then(function (response) {
            if (response.data.success) {
                alert(response.data.message);
                var modal = $('#ScreenModal');
                modal.modal('hide');
                $scioe.file = null;
                $scope.titolo = "";
                $scope.descrizione = "";
                $scope.recentiPiu();
            }
            else
                $scope.fileError = response.data.message || "Errore! File non inviato correttamente.";
        });
    };

    $scope.recentiPiu = function () {
        $scope.page = 1;
        $scope.orderBy = 'numero';
        $scope.orderValue = '1';
        $scope.allScreen = [];
        $window.scrollTo(0, 0);
        chiediScreen();
    };

    $scope.recentiMeno = function () {
        $scope.page = 1;
        $scope.orderBy = 'numero';
        $scope.orderValue = '0';
        $scope.allScreen = [];
        $window.scrollTo(0, 0);
        chiediScreen();
    };

    $scope.votatiPiu = function () {
        $scope.page = 1;
        $scope.orderBy = 'n_like';
        $scope.orderValue = '1';
        $scope.allScreen = [];
        $window.scrollTo(0, 0);
        chiediScreen();
    };

    $scope.votatiMeno = function () {
        $scope.page = 1;
        $scope.orderBy = 'n_dislike';
        $scope.orderValue = '1';
        $scope.allScreen = [];
        $window.scrollTo(0, 0);
        chiediScreen();
    };
});
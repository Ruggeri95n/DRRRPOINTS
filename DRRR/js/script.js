 // create the module
 var indexApp = angular.module('pointApp', ['ngRoute']);
 
 // configure our routes
 indexApp.config(function($routeProvider) {
     $routeProvider.when('/', {
             templateUrl : './home.html',
             controller  : 'homeController'
         })
         .when('/login', {
             templateUrl : './login.html',
             controller  : 'gestisciLogin'
         })
         .when('/screen', {
             templateUrl : './screenForum.html',
             controller  : 'gestisciScreen'
         })
         .when('/singup', {
             templateUrl : './singup.html',
             controller  : 'gestisciSingup'
         });
 });
 
 //  variabile contenente il token
 var curToken = {value:"", enable:false};
 
 // I controller ho dovuto spostarli qua perché non venivano trovati 
 //(il router provider li invoca ancora prima che la pagina sia caricata con gli script dentro e da errore)
 
 
 // create the controller and inject Angular's $scope
 indexApp.controller('homeController', function ($scope, $http) {
     $scope.message = "Home Page";

     /*$http({
        method : "POST",
        url : "http://localhost:3001/users",
        }).then(function SucInfinito(response) {
        if (response.data.success)
        { 
            var dataMat = [];
            var i = 0, j = 0;

            dataMat[0] = [];

            while (i < response.data.users.length)
            {
                dataMat[j].push(response.data.users[i]);
                i++;

                if (i % 4 == 0)
                {
                    j++;
                    dataMat[j] = [];                    
                }
            }

            $scope.Users = dataMat;
        }   
    });*/
 });
 
 /**
  * Username is the e-mail of the persone who want to access in it's personal profile
  */
 indexApp.controller('gestisciLogin', function ($scope, $http, $location) {
   //messaggio di entrata
   $scope.message = "Login page";

   //   Autenticazione via token (se si è precedentementi loggati)
   if (curToken.enable == true)
     {
         $http({
         method : "POST",
         url : "http://localhost:3001/api",
         headers: {'Content-Type': 'application/json'},
         data : {'token': curToken.value}
         }).then(function SuccessoInfinito(response) {
         if (response.data.success)
         {      
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
         name:$scope.username, 
         password:$scope.password 
     };
 
     $http({
         method : "POST",
         url : "http://localhost:3001/api/authenticate",
         headers: {'Content-Type': 'application/json'},
         data: parametri
     }).then(function mySuccess(response) {
         if (response.data.success)
         {
             curToken.value = response.data.token;   
             curToken.enable = true;               
             alert(response.data.message);
             $location.path('/home');
         }
         else
             alert("Error! " + response.data.message);
     }, function myError(response) {
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
            method : "POST",
            url : "http://localhost:3001/singup",
            headers: {'Content-Type': 'application/json'},
            data: parametri
        }).then(function mySuccess(response) {
            if (response.data.success)
            {           
                alert(response.data.message);
                //  Cambia pagina
            }
            else
                alert(response.data.message);
        }, function myError(response) {
            alert("Si è verificato un errore nella richiesta di registrazione!");
        });
    }
 });

 // gestisciScreen
 indexApp.controller("gestisciScreen", function ($scope, $http) {
    $scope.message = "Area Screen";

    var parametri = { 
        start: 0,
        end: 10
    };

    $http({
        method : "POST",
        url : "http://localhost:3001/registrami",
        headers: {'Content-Type': 'application/json'},
        data: parametri
    }).then(function mySuccess(response) {
        if (response.data.success)
        {           
            $scope.Foto = response.data.Foto;   //  devo ricevere un vettore di foto (controllare se possibile)
        }
        else
            alert("Error! " + response.data.message);// togliere l'alert
    }, function myError(response) {
        alert("Si è verificato un errore nella richiesta di registrazione!");// togliere l'alert
    });
 });

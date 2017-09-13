// ============================
// = get the packages we need =
// ============================
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var morgan = require('morgan');
var database = require('./app/database');

var jwt = require('jsonwebtoken'); // used to create, sign, and verify tokens
var user = require('./app/models/utenti');

// =======================
// ==== configuration ====
// =======================
var port = 3001 || process.env.PORT; // used to create, sign, and verify tokens

app.set('superSecret', '453ilgb34ig34g9gh4'); // secret variable (prelevata da config.js)

// use body parser so we can get info from POST and/or URL parameters
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// use morgan to log requests to the console
app.use(morgan('dev'));// in realtà non serve ad un cazzo, l'ho copiato da un tutorial scarso

// Creo una funzione per abilitare i CORS (sono i permessi per essere acceduti da server web con porta e/o indirizzo diverso)
var allowCrossDomain = function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*'); // Vanno poi indicate le origini specifiche prima della consegna
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,PATCH,OPTIONS');  // non mi servono tutti
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

  //  Vado avanti solo se non è stata richiesta l'opzione dei cors
  if ('OPTIONS' === req.method) {
    res.send(200);
  } else {
    next();
  }
};

// Abilito i CORS
app.use(allowCrossDomain);

// =======================
// routes ================
// =======================

// basic route (momentaneamente solo di test)
app.get('/', function (req, res) {
  res.send('Hey you!');
});

//  Restituisce la lista degli utenti con i punteggi associati
app.post('/users', function (req, res) {;
  database.getUsers(function (successo, message, result) {
    res.json({
      success: successo,
      message: message,
      users: result
    });
  });
});

//  Registra un nuovo utente
app.post('/singup', function (req, res) {

  if (!req.body.user) {
    console.log('Undefined NON PUO ESSERE SALVATO.');
    res.json({
      success: false,
      message: 'Campi mancanti.'
    });
  }
  else  // save the new user
  {
    database.saveUser(req.body.user, function (successo) {
      res.json({
        success: successo,
        message: 'Sei stato registrato.'
      });
    });
  }
});

// API ROUTES -------------------

// get an instance of the router for api routes
var apiRoutes = express.Router();

// route to authenticate a user
apiRoutes.post('/authenticate', function (req, res) {

  database.findUser(req.body.name, req.body.password, function (ris, messaggio) {
    var token;

    if (ris) {
      // create a token
      token = jwt.sign(req.body.name, app.get('superSecret'), {
        expiresInMinutes: 1440
      });
    }
    // return the information including token as JSON
    res.json({
      success: ris,
      message: messaggio,
      token: token
    });
  });
});

// route middleware to verify a token
apiRoutes.use(function (req, res, next) {

  // check header or url parameters or post parameters or cookie 
  var token = req.headers['x-access-token'] || req.body.token || req.query.token; // || req.cookies.authToken;

  // decode token
  if (token) {

    // verifies secret and checks exp (controllo che non sia tarocco)
    jwt.verify(token, app.get('superSecret'), function (err, decoded) {
      if (err) {
        return res.json({ success: false, message: 'Failed to authenticate token.' });
      } else {
        // if everything is good, save to request for use in other routes
        req.decoded = decoded;
        next();
      }
    });

  } else {
    // if there is no token
    // return an error
    return res.status(403).send({
      success: false,
      message: 'No token provided.'
    });
  }
});

// route to show a random message
apiRoutes.post('/', function (req, res) {
  res.json({
    message: 'Hey You.'
  });
});

apiRoutes.post('/getScreen', function (req, res) {
  var start = req.body.start || 0;
  var end = req.body.end || 10;

  database.findPost(start, end, function (ris, message, result) {
    res.json({
      success: ris,
      message: message,
      post: result
    });
  });
});

app.use('/api', apiRoutes);

// =======================
// start the server ======
// =======================
app.listen(port);
console.log('Node è in funzione su http://localhost:' + port);

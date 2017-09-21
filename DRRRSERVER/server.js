var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var morgan = require('morgan');
var fs = require('fs');
var database = require('./app/database');

var jwt = require('jsonwebtoken');
var user = require('./app/models/utenti');

// Requires multiparty 
var multiparty = require('connect-multiparty');
var multipartyMiddleware = multiparty();

// Requires data store
var DataStoreController = require('./dataStore');



// configuration 
var port = 3001 || process.env.PORT;

app.set('superSecret', '453ilgb34ig34g9gh4');

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
    res.sendStatus(200);
  } else {
    next();
  }
};

// Abilito i CORS
app.use(allowCrossDomain);

var verifyToken = function (req, res, next) {
  var token = req.headers['x-access-token'] || req.body.token || req.query.token; // || req.cookies.authToken;

  if (token) {
    jwt.verify(token, app.get('superSecret'), function (err, decoded) {
      if (err) {
        return res.json({ success: false, message: 'Failed to authenticate token.' });
      } else {
        req.decoded = decoded;
        next();
      }
    });
  } else {
    return res.sendStatus(403).json({
      success: false,
      message: 'No token provided.'
    });
  }
};

// =======================
// routes ================
// =======================

// basic route (momentaneamente solo di test)
app.get('/', function (req, res) {
  res.sendStatus(200);
});

//  Restituisce la lista degli utenti con i punteggi associati
app.post('/users', function (req, res) {
  ;
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
      var messaggio = "Errore durante la registrazione.";

      if (successo)
        messaggio = "Sei stato registrato.";

      res.json({
        success: successo,
        message: messaggio
      });
    });
  }
});

// API ROUTES -------------------
var apiRoutes = express.Router();

apiRoutes.post('/authenticate', function (req, res) {

  database.findUser(req.body.name, req.body.password, function (ris, messaggio) {
    var token;

    if (ris) {

      token = jwt.sign(req.body.name, app.get('superSecret'), {
        expiresInMinutes: 1440
      });
    }

    res.json({
      success: ris,
      message: messaggio,
      token: token
    });
  });
});

apiRoutes.post('/uploadScreen', multipartyMiddleware, verifyToken, DataStoreController.uploadFile, function (req, res) {
  if (req.success) {
    database.getUserId(req.decoded, function (ris, message, result) {
      if (ris) {
        var date = new Date();
        var today = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();

        var screen = {
          id_utente: result.id,
          titolo: req.body.titolo,
          commento: req.body.commento,
          data: today,
          name: req.name
        };
        database.addScreen(screen, function (ris, message) {
          res.json({
            success: ris,
            message: message
          });
        });
      }
      else
        res.json({
          success: ris,
          message: message
        });
    });
  }
  else
    res.json({
      success: false,
      message: 'Errore sconosciuto.'
    });
});

apiRoutes.get('/', function (req, res) {
  res.sendStatus(200);
});

apiRoutes.use(verifyToken);

apiRoutes.post('/getScreen', function (req, res) {
  var end = req.body.end || 50;
  var orderBy = req.body.orderBy || "numero";
  var orderValue = req.body.orderValue || 1;

  if (!(orderBy === "numero" || orderBy === "n_like" || orderBy === "n_dislike")) {
    res.json({
      success: false,
      message: 'Parametro di ordinamento errato.'
    });
    return;
  }

  database.findPost(end, orderBy, orderValue, function (ris, message, result) {
    res.json({
      success: ris,
      message: message,
      post: result
    });
  });
});

apiRoutes.post('/votaScreen', function (req, res) {
  if (req.body.id_screen && (req.body.voto != undefined)) {
    var voto = req.body.voto;
    database.getUserId(req.decoded, function (ris, message, result) {
      if (ris) {
        var user_id = result.id;
        database.getVoto(req.body.id_screen, user_id, function (ris, message, result) {
          if (ris) {
            if (result.voto == voto)
              res.json({
                success: false,
                stop: true,
                reverse: false
              });
            else {
              database.eliminaVoto(req.body.id_screen, user_id, function (ris) {
                if (ris) {
                  database.votaScreen(req.body.id_screen, user_id, voto, function (ris, message) {
                    res.json({
                      success: ris,
                      stop: ris,
                      reverse: ris
                    });
                  });
                }
                else
                  res.json({
                    success: false,
                    stop: false,
                    reverse: false
                  });
              });
            }
          }
          else {
            database.votaScreen(req.body.id_screen, user_id, voto, function (ris, message) {
              res.json({
                success: ris,
                stop: ris,
                reverse: false
              });
            });
          }
        });
      }
      else {
        res.json({
          success: ris,
          message: message
        });
      }
    });
  }
  else
    res.json({
      success: false,
      message: 'Impossibile votare senza l\'id dello screen.',
    });
});

app.use('/api', apiRoutes);

app.listen(port);
console.log('Node è in funzione su http://localhost:' + port);

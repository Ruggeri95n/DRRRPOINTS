var jwt = require('jsonwebtoken');
var bodyParser = require('body-parser');
var express = require('express');

var database = require('./app/database');
var user = require('./app/models/utenti');

var multiparty = require('connect-multiparty');
var multipartyMiddleware = multiparty();

var DataStoreController = require('./dataStore');

var port = process.env.PORT || 3001;
var secret = '453ilgb34ig34g9gh4';

var verifyToken = function (req, res, next) {
  var token = req.headers['x-access-token'] || req.body.token || req.query.token;

  if (token) {
    jwt.verify(token, secret, function (err, decoded) {
      if (err) {
        return res.json({ success: false, message: 'Failed to authenticate token.' });
      } else {
        database.getUserName(decoded, function (ris, message, result) {
          if (ris) {
            req.decoded = result.nome;
            next();
          }
          else
            res.json({
              success: false,
              message: 'Riscontrati problemi con il database.'
            });
        });
      }
    });
  } else {
    return res.sendStatus(403).json({
      success: false,
      message: 'No token provided.'
    });
  }
};

// API ROUTES -------------------
var apiRoutes = express.Router();

// use body parser so we can get info from POST and/or URL parameters
apiRoutes.use(bodyParser.urlencoded({ extended: false }));
apiRoutes.use(bodyParser.json());

//  Restituisce la lista degli utenti con i punteggi associati
apiRoutes.post('/users', function (req, res) {
  database.getUsers(function (successo, message, result) {
    res.json({
      success: successo,
      message: message,
      users: result
    });
  });
});

//  Registra un nuovo utente
apiRoutes.post('/singup', function (req, res) {
  if (!req.body.user)
    res.json({
      success: false,
      message: 'Campi mancanti.'
    });
  else  // save the new user
  {
    if (!req.body.user.name)
      res.json({
        success: false,
        message: 'Campi mancanti.'
      });

    database.userIsReg(req.body.user.name, function (ris, isReg) {
      if (ris)
        if (!isReg)
          database.saveUser(req.body.user, function (successo) {
            var messaggio = "Errore durante la registrazione.";

            if (successo)
              messaggio = "Sei stato registrato.";

            res.json({
              success: successo,
              message: messaggio
            });
          });
        else
          res.json({
            success: false,
            message: 'Nome utente già in uso.'
          });
      else
        res.json({
          success: false,
          message: 'Riscontrati problemi con il database.'
        });
    });
  }
});

apiRoutes.post('/authenticate', function (req, res) {
  database.findUser(req.body.name, req.body.password, function (ris, messaggio, result) {
    var token;

    if (ris)
      token = jwt.sign(result.id, secret);

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
          commento: req.body.descrizione,
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

module.exports = apiRoutes;
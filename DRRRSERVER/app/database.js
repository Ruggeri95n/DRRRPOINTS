var mysql = require('mysql');
var config = require('../config');

exports.saveUser = function(user, callback) {
  var con = mysql.createConnection(config);
    
    con.connect(function(err) {
        if (err) 
          {
            callback(false);
            con.end();
            throw err;
          }

        var sql = "INSERT INTO utenti (nome, password, pic, punti, livello) VALUES ?";
        var values = [
          [user.name, user.password, user.pic, user.punti, user.livello],
        ];

        con.query(sql, [values], function (err, result) {
          if (err) 
          {
            callback(false);
            con.end();
            throw err;
          }
          else
          {
            console.log(" <--- L'utente " + user.name + " è stato registrato --->");
            con.end();
            callback(true);
          }
        });
    });  
};

exports.findUser = function(username, password, callback) {
  var con = mysql.createConnection(config);

  con.connect(function(err) {
    if (err) 
    {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM utenti WHERE nome = \'" + username + "\' AND password = \'" +password + "\';", 
    function (err, result, fields) {
      if (err) 
      {
        callback(false, "Errore di connessione alla tabella degli utenti.");
        con.end();
        throw err;
      }
    else
    {
      if (result.length > 0)
      {
        console.log(" <--- L'utente " + username + " è loggato --->");
        callback(true, "Sei loggato.");
      }
      else
      {
        console.log(" <--- ATTENZIONE! " + username + " dati di login errati --->");
        callback(false, "Utente non trovato.");
      }
      con.end();
    }
    });
  });
};
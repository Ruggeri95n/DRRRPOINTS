var mysql = require('mysql');
var config = require('../config');

exports.saveUser = function (user, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false);
      con.end();
      throw err;
    }

    var sql = "INSERT INTO utenti (nome, password, pic) VALUES ?";
    var values = [
      [user.name, user.password, user.pic],
    ];

    con.query(sql, [values], function (err, result) {
      if (err) {
        callback(false);
        con.end();
        throw err;
      }
      else {
        console.log(" <--- L'utente " + user.name + " è stato registrato --->");
        con.end();
        callback(true);
      }
    });
  });
};

exports.findUser = function (username, password, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM utenti WHERE nome = \'" + username + "\' AND password = \'" + password + "\';",
      function (err, result, fields) {
        if (err) {
          callback(false, "Errore di connessione alla tabella degli utenti.");
          con.end();
          throw err;
        }
        else {
          if (result.length > 0) {
            console.log(" <--- L'utente " + username + " è loggato --->");
            callback(true, "Sei loggato.");
          }
          else {
            console.log(" <--- ATTENZIONE! " + username + " dati di login errati --->");
            callback(false, "Utente non trovato.");
          }
          con.end();
        }
      });
  });
};

exports.getUserId = function (username, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM utenti WHERE nome = " + username + ";",
      function (err, result) {
        if (err) {
          callback(false, "Errore di connessione alla tabella degli utenti.");
          con.end();
          throw err;
        }
        else {
          if (result.length > 0) {
            callback(true, "Id trovato.", result[0]);
          }
          else {
            callback(false, "Id utente non trovato.");
          }
          con.end();
        }
      });
  });
};

exports.findPost = function (end, order, orV, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    var par;

    if (orV == 1)
      par = 'DESC';
    else
      if (orV == 0)
        par = 'ASC';
      else {
        callback(false, "Valore di ordinamento errato.");
        return;
      }

    con.query("SELECT * FROM info_screen ORDER BY " + order + " " + par + " LIMIT " + end + ";",
      function (err, result) {
        if (err) {
          callback(false, "Errore di connessione alla tabella degli utenti.");
          con.end();
          throw err;
        }
        else {
          if (result.length > 0) {
            callback(true, 'Operazione riuscita.', result);
          }
          else {
            callback(false, "Non ci sono screen.");
          }
          con.end();
        }
      });
  });
};

//  Restituisce i primi n_users con punteggio maggiore
exports.getUsers = function (callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM info_user ORDER BY punti DESC;",
      function (err, result) {
        if (err) {
          callback(false, "Errore di connessione alla tabella degli user.");
          con.end();
          throw err;
        }
        else {
          callback(true, "Users prelevati.", result);
          con.end();
        }
      });
  });
};

exports.votaScreen = function (id_screen, id_user, voto, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false);
      con.end();
      throw err;
    }

    var sql = "INSERT INTO like_screen (id_user, id_screen, voto) VALUES ?";
    var values = [
      [id_user, id_screen, voto],
    ];

    con.query(sql, [values], function (err, result) {
      if (err) {
        callback(false);
        con.end();
        throw err;
      }
      else {
        con.end();
        callback(true);
      }
    });
  });
};

exports.getVoto = function (id_screen, id_user, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM like_screen WHERE id_user = " + id_user + " AND id_screen = " + id_screen + ";",
      function (err, result) {
        if (err) {
          callback(false, "Errore di connessione alla tabella dei voti.");
          con.end();
          throw err;
        }
        else {
          if (result.length > 0) {
            callback(true, "Voto trovato.", result[0]);
          }
          else {
            callback(false, "Voto non trovato.");
          }
          con.end();
        }
      });
  });
};

exports.eliminaVoto = function (id_screen, id_user, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false);
      con.end();
      throw err;
    }

    var sql = "DELETE FROM like_screen WHERE id_user = " + id_user + " AND id_screen = " + id_screen + ";";

    con.query(sql, function (err, result) {
      if (err) {
        callback(false);
        con.end();
        throw err;
      }
      else {
        con.end();
        callback(true);
      }
    });
  });
};

exports.addScreen = function (screen, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, 'Riscontrati problemi con il database.');
      con.end();
      throw err;
    }

    var sql = "INSERT INTO screen (id_utente, titolo, commento, data, name) VALUES ?";
    var values = [
      [screen.id_utente, screen.titolo, screen.commento, screen.data, screen.name],
    ];

    con.query(sql, [values], function (err, result) {
      if (err) {
        callback(false, 'Riscontrati problemi con il database.');
        con.end();
        throw err;
      }
      else {
        console.log(" <--- screen aggiunto --->");
        con.end();
        callback(true, 'Screen caricato correttamente.');
      }
    });
  });
};

exports.findScreen = function (nome, callback) {
  var con = mysql.createConnection(config);

  con.connect(function (err) {
    if (err) {
      callback(false, "Errore di connessione al database.");
      con.end();
      throw err;
    }

    con.query("SELECT * FROM screen WHERE name = " + nome + ";",
      function (err, result) {
        if (err) {
          callback(false, "Errore di connessione alla tabella degli screen.");
          con.end();
          throw err;
        }
        else {
          if (result.length > 0) {
            callback(true, "Screen trovato.", result[0]);
          }
          else {
            callback(false, "Screen non trovato.");
          }
          con.end();
        }
      });
  });
};
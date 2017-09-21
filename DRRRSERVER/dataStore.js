var fs = require('fs');
FileUploadController = function () { };

var localPath = '/home/work/KRAKEN/DRRR/screen/';

FileUploadController.prototype.uploadFile = function (req, res, next) {

  fs.readFile(req.files.file.path, function (err, data) {
    if (err) {
      res.json({
        success: false,
        message: 'Errore nella lettura del file.'
      });
      return;
    }

    var file = req.files.file;
    var dati = data;

    fs.readFile(localPath + file.name, function (err, data) {
      if (err) {
        file.path = localPath + file.name;

        fs.writeFile(file.path, dati, function (err) {
          if (err) {
            res.json({
              success: false,
              message: 'Errore nello spostamento del file.'
            });
            return console.warn(err);
          }
          console.log("\nNuovo file salvato:" + file.path);
          req.name = file.name;
          req.success = true;
          next();
        });
      }
      else
        res.json({
          success: false,
          message: 'Esiste già un file con questo nome.'
        });
    });
  });
}

module.exports = new FileUploadController();
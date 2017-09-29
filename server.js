var fs = require('fs');
var http = require('http');
var https = require('https');
var ca = fs.readFileSync('server.ca-bundle', 'utf8');
var privateKey  = fs.readFileSync('server.key', 'utf8');
var certificate = fs.readFileSync('server.cer', 'utf8');

var credentials = {
    ca: ca,
    key: privateKey, 
    cert: certificate
};

var express = require('express');
var app = express();

app.use('/', express.static('public'));

// your express configuration here
app.get('/pork', function (req, res) { 
    res.json('PORK PIE!');
});

var api = require('./api');
app.use('/api', api);

var httpServer = http.createServer(app);
var httpsServer = https.createServer(credentials, app);

/*
httpServer.listen(8080, function () {
    console.log('server started on 8080.');
});
*/

httpsServer.listen(8443, "172.16.0.201", function () {
    console.log('server started on 8443.');
});
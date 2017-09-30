var fs = require('fs');
var http = require('http');
var https = require('https');

var credentials = {
    ca: fs.readFileSync('impo-store.it_ssl_certificate_INTERMEDIATE.cer', 'utf8'),
    key: fs.readFileSync('www.impo-store.it_private_key.key', 'utf8'),
    cert: fs.readFileSync('www.impo-store.it_ssl_certificate.cer', 'utf8')
};

var express = require('express');
var app = express();

app.use(function allowCrossDomain(req, res, next) {
    res.header('Access-Control-Allow-Origin', 'https://impo-store.it');
    res.header('Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE, PATCH, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

    if ('OPTIONS' === req.method)
        res.sendStatus(200);
    else
        next();
});

app.use('/', express.static('public'));

var api = require('./api');
app.use('/api', api);

var redirApp = express();
redirApp.use(function Redirect(req, res) {
    res.redirect('https://www.impo-store.it');
});

var httpServer = http.createServer(redirApp);
var httpsServer = https.createServer(credentials, app);


httpServer.listen(8080, "172.16.0.201", function () {
    console.log('server started on 8080.');
});

httpsServer.listen(8443, "172.16.0.201", function () {
    console.log('server started on 8443.');
});
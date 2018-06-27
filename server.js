const express = require('express');
const https = require('https');
const fs = require('fs');
const helmet = require('helmet');
const path = require('path');
const logger = require('morgan');
const favicon = require('serve-favicon');
const process = require('process');

const app = express();

// Constants
const PORT = 8080;
const HTTPS_PORT = 8443;
const HOST = '0.0.0.0';
const DOMAIN = 'zoomer.pw';

let OPTIONS = {
  cert: fs.readFileSync('./cert/localhost.crt'),
  key: fs.readFileSync('./cert/localhost.key'),
};

const CERT_PATH = path.join('/', 'etc', 'letsencrypt', 'live', DOMAIN);
if (process.platform === 'linux' && fs.existsSync(path.join(CERT_PATH, 'fullchain.pem'))) {
  console.log('Use SSL certificate from letsencrypt.');
  OPTIONS = {
    cert: fs.readFileSync(path.join(CERT_PATH, 'fullchain.pem')),
    key: fs.readFileSync(path.join(CERT_PATH, 'privkey.pem')),
  };
} else {
  console.log('Use default SSL certificate.');
}

app.use(helmet());
app.use(favicon(path.join(__dirname, 'public', 'static', 'images', 'favicon.ico')));
app.use(express.static(path.join(__dirname, 'public', 'static')));
app.use('/.well-known', express.static(path.join(__dirname, 'public', 'certbot_webroot', '.well-known')));
app.use(express.static(path.join(__dirname, 'public', 'static_rw')));

app.use(logger('common'));

app.listen(PORT, HOST, () => console.log(`Running on http://${HOST}:${PORT} and https://${HOST}:${HTTPS_PORT}`));
https.createServer(OPTIONS, app).listen(HTTPS_PORT);

app.use((req, res, next) => {
  // Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', `http://localhost:${PORT}`);

  // Request methods you wish to allow
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

  // Request headers you wish to allow
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

  // Pass to next layer of middleware
  next();
});

app.get('/health-check', (_, res) => res.sendStatus(200));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', '/index.html'));
});

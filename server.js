const express = require('express');
const https = require('https');
const fs = require('fs');
const helmet = require('helmet');
const path = require('path');
const logger = require('morgan');
const favicon = require('serve-favicon');

const app = express();

// Constants
const PORT = 8080;
const HTTPS_PORT = 8443;
const HOST = '0.0.0.0';
const OPTIONS = {
  cert: fs.readFileSync('./cert/localhost.crt'),
  key: fs.readFileSync('./cert/localhost.key'),
};

app.use(helmet());
app.use(favicon(path.join(__dirname, 'public', 'static', 'images', 'favicon.ico')));
app.use(express.static(path.join(__dirname, 'public', 'static')));

app.use(logger('common'));

app.listen(PORT, HOST, () => console.log(`Running on http://${HOST}:${PORT}`));
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

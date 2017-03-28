'use strict';
 
const cluster = require('cluster');

if (cluster.isMaster) {
     const numCPUs = require('os').cpus().length;

     // Fork workers.
     for (let i = 0; i < numCPUs; i++) {
         cluster.fork();
     }
    
     cluster.on('online', (worker, code, signal) => {
         console.log(`worker ${worker.process.pid} is online`);
     });
    
     cluster.on('exit', (worker, code, signal) => {
         console.log(`worker ${worker.process.pid} died`);
     });
} else {
    let express = require('express'),
        app = express(),
        bodyParser = require('body-parser'),
        helmet = require('helmet');

    const port = process.env.PORT || 3000;

    // Let's protect our app..
    app.use(helmet());

    // Setup views folder and view engine, making .ejs to .html
    app.engine('.html', require('ejs').__express);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'html');

    // Basic setup, express static folder (public), body parser and controllers folder
    // public folder available as '/assets'
    app.use('/assets', express.static(__dirname + '/public'));
    // TODO: Revisit the body parser to proper handle each scenario!
    app.use(bodyParser.json({type: '*/*'})); // application/json, text/plain, html, actually anything! =)
    app.use(bodyParser.urlencoded({extended: true})); // https://www.npmjs.com/package/body-parser#extended
    app.use(require('./controllers'));

    app.disable('x-powered-by');

    //var compression = require('compression');
    //app.use(compression());

    // Let's start to listen...
    app.listen(port, () => {
        console.log('Listening on port ' + port);
    });
}
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
        bodyParser = require('body-parser');

    const port = process.env.PORT || 3000;

    // Setup views folder and view engine, making .ejs to .html
    app.engine('.html', require('ejs').__express);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'html');

    // Basic setup, express static folder (public), body parser and controllers folder
    // public folder available as '/assets'
    app.use('/assets', express.static(__dirname + '/public'));
    app.use(bodyParser.json({type: '*/*'}));
    app.use(bodyParser.urlencoded({extended: true}));
    app.use(require('./controllers'));

    // Let's start to listen...
    app.listen(port, () => {
        console.log('Listening on port ' + port);
    });
}
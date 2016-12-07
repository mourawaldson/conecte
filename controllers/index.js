let express = require('express'),
    router = express.Router();

router.get('/', function(req, res) {
  res.render('index');
});

router.use(require('./error'));

//router.use('/comments', require('./comments'))

module.exports = router;


// 'use strict';

// var IndexModel = require('../models/index');

// module.exports = function (router) {
//     var model = new IndexModel();

//     router.get('/', function (req, res) {
//         res.render('index', model);
//     });
// };
"use strict";

let express = require('express'),
    router = express.Router();

router.get('/', function(req, res) {
    res.render('index', {
        title: 'Conecte',
        description: 'Conecte, sempre com você.'
    });
});

router.use(require('./error'));

module.exports = router;

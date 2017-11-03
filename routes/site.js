"use strict";

let express = require('express'),
    router = express.Router();

router.get('/', function(req, res) {
    res.render('index', {
        title: 'Conecte',
        description: 'Conecte, sempre com você.',
        pageName: req.path
    });
});

router.get('/about', function(req, res) {
    res.render('about', {
        title: 'Sobre',
        description: 'Então...',
        pageName: req.path
    });
});

router.get('/contact', function(req, res) {
    res.render('contact', {
        title: 'Contato',
        description: 'Fale conosco!',
        pageName: req.path
    });
});

module.exports = router;

"use strict";

let express = require('express'),
    router = express.Router(),
    bodyParser = require('body-parser'),
    mysql = require('mysql'),
    urlencodedParser = bodyParser.urlencoded({ extended: false });

let con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "conecte"
});

let error = {"status": "error", "message": "missing a parameter"};

router.get('/api/users', function(req, res, next) {
    res.send('respond with a resource');
});

router.get('/api/users/:id', function(req, res) {
    let id = req.params.id;
    if(!id) {
        return res.send(error);
    }
    try {
        con.query('SELECT * FROM user WHERE id = ' + con.escape(id), function (err, rows, fields) {
            if (err) {
                if (err) throw err;
            } else {
                if (rows.length) {
                    res.json({id: id, name: rows[0].name});
                } else {
                    res.sendStatus(404);
                }
            }
        });
    } catch (e) {
        res.sendStatus(404);
    }
});

router.post('/api/users', urlencodedParser, function(req, res) {
    let name = req.body.name;
    if(!name) {
        return res.send(error);
    }
    let data  = {name: name};
    con.query('INSERT INTO user SET ?', data, function(err, result) {
        if (err) {
            res.sendStatus(404);
        } else {
            res.sendStatus(200);
        }
    });
});

router.delete('/api/user/:id', function(req, res) {
    let id = req.params.id;
    if(!id) {
        return res.send(error);
    }
    con.query('DELETE FROM user WHERE id = ' + con.escape(id), function(err, result) {
        if (err) {
            res.sendStatus(404);
        } else {
            res.sendStatus(200);
        }
    });
});

module.exports = router;

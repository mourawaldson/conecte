"use strict";

let express = require('express'),
    router = express.Router(),
    bodyParser = require('body-parser'),
    mysql = require('mysql'),
    urlencodedParser = bodyParser.urlencoded({ extended: true });

let con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "conecte"
});

let error = {"status": "error", "message": "missing a parameter"};

router.get('/users', function (req, res, next) {
    res.send('respond with a resource');
});

router.get('/api/user/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.send(error);
    }
    try {
        con.query('SELECT * FROM member WHERE id = ' + con.escape(id), function (err, rows, fields) {
            if (err) {
                if (err) throw err;
            } else {
                if (rows.length) {
                    res.json(
                        {
                            id: id,
                            name: rows[0].name,
                            username: rows[0].username,
                            birth: rows[0].birth,
                            active: rows[0].active,
                        }
                    );
                } else {
                    res.sendStatus(404);
                }
            }
        });
    } catch (e) {
        res.sendStatus(404);
    }
});

router.post('/api/user', urlencodedParser, function (req, res) {
    let name = req.body.name,
        username = req.body.username,
        password = req.body.password,
        birth = req.body.birth;

    if (!name) {
        return res.send(error);
    }

    let now = new Date().toISOString().slice(0, 10),
        data = {
            id: null,
            name: name,
            username: username,
            password: password,
            birth: birth,
            sign_up_token: 'random test',
            active: true,
            creation: now,
            sign_up: now
        };

    con.query('INSERT INTO member SET ?', data, function (err, result) {
        if (err) {
            res.sendStatus(404);
        } else {
            res.sendStatus(200);
        }
    });
});

router.delete('/api/user/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.send(error);
    }
    con.query('DELETE FROM member WHERE id = ' + con.escape(id), function (err, result) {
        if (err) {
            res.sendStatus(404);
        } else {
            res.sendStatus(200);
        }
    });
});

module.exports = router;

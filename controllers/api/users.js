var bodyParser = require('body-parser');
var mysql = require('mysql');

var urlencodedParser = bodyParser.urlencoded({ extended: false });

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "conecte"
});

var error = {"status": "error", "message": "missing a parameter"};

module.exports = function(app) {
    app.get('/api/users/:id', function(req, res) {
        var id = req.params.id;
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

    app.post('/api/users', urlencodedParser, function(req, res) {
        var name = req.body.name;
        if(!name) {
            return res.send(error);
        }
        var data  = {name: req.body.name};
        con.query('INSERT INTO user SET ?', data, function(err, result) {
            if (err) {
                res.sendStatus(404);
            } else {
                //res.json({id: result.insertId, name: name});
                res.sendStatus(200);
            }
        });
    });

    app.delete('/api/user/:id', function(req, res) {
        var id = req.params.id;
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
};
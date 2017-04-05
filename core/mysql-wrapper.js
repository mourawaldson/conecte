'use strict';

let mysql = require("mysql");

let mysqlWrapper = function (hostname, username, password, database, port = 3306) {
    this.connection = mysql.createConnection({
        host: hostname,
        user: username,
        password: password,
        database: database,
        port: port,
        debug: false
    });
};

mysqlWrapper.prototype = {
    query: function (query, values, callback) {
        this.connection.query(query, values, callback);
    }
};

module.exports = mysqlWrapper;

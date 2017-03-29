"use strict";

let router = require('express').Router();

router.use(require('./api/users'));

module.exports = router;

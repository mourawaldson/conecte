function Repository() {}

/**
 * Find by id
 * Param: id of the item to find
 * Returns: the item corresponding to the specified id
 */
Repository.prototype.find = function (id) {}

/**
 * Find the index of a item
 * Param: id of the item to find
 * Returns: the index of the item identified by id
 */
Repository.prototype.findIndex = function (id) {}

/**
 * Retrieve all items
 * Returns: array of items
 */
Repository.prototype.findAll = function () {
    return this.items;
}

/**
 * Save (create or update)
 * Param: item to save
 */
Repository.prototype.save = function (item) {}

/**
 * Remove
 * Param: id the of the item to remove
 */
Repository.prototype.remove = function (id) {}
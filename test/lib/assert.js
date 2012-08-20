var assert = require("assert");

module.exports = {
    equal: function(expected, actual) {
        return assert.equal(actual, expected);
    },

    equals: function(expected, actual) {
        return assert.equal(actual, expected);
    },

    ok: function(expected) {
        return assert.ok(expected);
    }
};

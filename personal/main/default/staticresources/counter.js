window._counter = (function() {
    var value = 0; // private

    return { //public API
        increment: function() {
            value = value + 1;
            return value;
        },

        getValue: function() {
            return value;
        }
    };
}());
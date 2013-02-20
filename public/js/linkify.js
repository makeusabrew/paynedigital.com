var linkify = (function(document) {
    "use strict";

    var camera = null,
        buffer = 2,
        that   = {};

    that.init = function() {
        camera = $(".header__camera");

        that.focus("li.active > a");
    };

    that.focus = function(selector) {
        var elem = $(selector);
        if (elem.length) {
            var left  = elem.position().left;
            var width = elem.width();

            camera.css({
                "margin-left": left - buffer,
                "width": width + (buffer*2)
            });
        }
    };

    return that;

}(document));

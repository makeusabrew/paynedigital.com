var linkify = (function(window, document) {
    "use strict";

    var camera = null,
        buffer = 2,
        timer  = null,
        that   = {};

    that.init = function() {
        camera = $(".header__camera");

        that.focus("li.active > a");

        $(window).on("resize", function(e) {
            clearTimeout(timer);
            timer = setTimeout(function() {
                that.focus("li.active > a");
            }, 40);
        });
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

}(window, document));

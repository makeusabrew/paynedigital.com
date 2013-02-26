var linkify = (function(window, document) {
    "use strict";

    var camera = null,
        buffer = 4,
        timer  = null,
        offset = 0,
        that   = {};

    that.init = function() {
        camera = $(".header__camera");

        // all we're actually doing here is capturing
        // $half-spacing-unit from SASS which we set as the
        // width property of the camera to save us hard-coding it here
        offset = camera.width();

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
                "margin-left": left - buffer - offset,
                "width": width + (buffer*2)
            });
        }
    };

    return that;

}(window, document));

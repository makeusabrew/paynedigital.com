var linkify = (function(window) {
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

        var selector = "li.active > a";

        that.focus(selector);

        $(window).on("resize", function(e) {
            clearTimeout(timer);

            timer = setTimeout(function() {
                that.focus(selector);
            }, 40);
        });
    };

    that.focus = function(selector) {
        var elem = $(selector);
        return that.focusElem(elem);
    };

    that.focusElem = function(elem) {
        if (camera.is(":hidden")) {
            return;
        }

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

}(window));

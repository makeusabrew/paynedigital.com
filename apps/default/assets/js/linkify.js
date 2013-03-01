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

        that.waitForTypekitActive(function() {
            that.focus(selector);
        });

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

    that.waitForTypekitActive = function(callback) {
        var timer, start, threshold;

        // repeatedly perform a task waiting for typekit
        // fonts to load - but give up after a defined threshold

        start = new Date();
        threshold = 3000;

        timer = setInterval(function() {
            // always invoke the callback...
            callback();

            // ... but stop the timer if appropriate
            var now = new Date();
            if (typekitActive || now - start >= threshold) {
                clearInterval(timer);
            }

        }, 30);
    };

    return that;

}(window));

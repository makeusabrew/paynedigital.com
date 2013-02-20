var pjaxify = (function() {
    "use strict";

    var _timeout   = 1000,
        _body      = null,
        _links     = [],
        currentUrl = null,
        that       = {};

    var removeTimestamp = function(elem) {
        $(elem).attr("href", $(elem).attr("href").replace(/\?__t=\d+$/, ''));
    }

    var finishTransition = function() {
        // we remove this because we only actually *apply transitions* to
        // any selectors under .transition
        $("html").removeClass("transition");

        $(".inner a").each(function(i) {
            removeTimestamp(this);
        });

        if (typeof twttr !== 'undefined') {
            twttr.widgets.load();
        }

    }

    var linkNav = function() {
        var i = _links.length;

        if (currentUrl.search(/^\/\d{4}\/\d{2}/) !== -1 ||
            currentUrl.search(/^\/tag\/[a-z0-9%\s\.]+$/) !== -1) {
            currentUrl = "/articles";
        }

        while (i--) {
            var href = _links[i].attr("href");
            if (href == currentUrl.substr(0, href.length)) {
                _links[i].parent().addClass("active");
                break;
            }
        }
    }

    that.init = function() {
        _body = $("body").get(0);

        // always listen out for when the theme has finished transitioning
        $(document).on("transitionend webkitTransitionEnd oTransitionEnd", ".theme", finishTransition);

        // a bit of manky link sorting
        $(".nav li a").each(function(i, v) {
            _links.push($(v));
        });

        _links.sort(function(a, b) {
            return a.attr("href").length - b.attr("href").length;
        });

        currentUrl = window.location.pathname;

        if ($(".nav li.active").length == 0) {
            linkNav();
        }

        $(document).on("click", ".inner a", function(e) {
            removeTimestamp(this);
        });

        // wire up pjax stuff
        $(document).on("click", "a.pjax", function(e) {
            currentUrl = $(this).attr("href");
        });

        $(document).pjax("a.pjax", ".inner", {timeout: _timeout});

        $(document).on("pjax:end", function() {
            // for balance you'd want this in start.pjax, but then
            // if there's a delay loading the content, things look a bit weird
            $(".nav li").removeClass("active");

            linkNav();

            // @todo we should make this better, but it's still an improvement on
            // simply not moving the window viewport at all
            window.scrollTo(0, 0);

            // transition baby!
            $("html").addClass("transition");

            $(".inner a").each(function(i) {
                var dt = new Date().getTime();
                $(this).attr("href", $(this).attr("href")+"?__t="+dt);
            });

            linkify.focus("li.active > a");

            // even though the HTML has *already* changed by this point,
            // set a miniscule timeout for FF, otherwise link transitions fail
            setTimeout(function() {
                var themeValue = $(".theme-identifier", _body).text();
                var theme = "theme theme--"+$.trim(themeValue);

                // transition stuff won't be fired, so manually invoke any cleanup
                if (theme == _body.className) {
                    finishTransition();
                }

                // set the new classname (triggers the transition)
                _body.className = theme;

                // bosh! cya later theme element, you've done your job
                $(".theme-identifier", _body).remove();
            }, 4);
        });
    };

    return that;
})();

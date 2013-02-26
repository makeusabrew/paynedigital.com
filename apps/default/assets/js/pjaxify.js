var pjaxify = (function() {
    "use strict";

    var _timeout   = 1000,
        _body      = null,
        _links     = [],
        startTheme = null,
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
        var i = _links.length,
            currentUrl = window.location.pathname;

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

        startTheme = _body.className.match(/theme--([\w-]+)/)[1];

        // always listen out for when the theme has finished transitioning
        // not sure if this selector is the most efficient way of doing this
        $(document).on("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", ".theme", finishTransition);

        // a bit of manky link sorting
        $(".nav li a").each(function(i, v) {
            _links.push($(v));
        });

        _links.sort(function(a, b) {
            return a.attr("href").length - b.attr("href").length;
        });

        if ($(".nav li.active").length == 0) {
            linkNav();
        }

        $(document).on("click", ".inner a", function(e) {
            removeTimestamp(this);
        });

        var options = {
            timeout: _timeout,
            scrollTo: 0
        };

        $(document).pjax("a.pjax", ".inner", options);

        $(document).on("pjax:end", function() {
            // for balance you'd want this in start.pjax, but then
            // if there's a delay loading the content, things look a bit weird
            $(".nav li").removeClass("active");

            linkNav();

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
                var themeValue, theme;
                var themeFragment = $(".theme-identifier");

                theme = "theme theme--";

                if (themeFragment.length) {
                    theme += $.trim(themeFragment.text());
                } else {
                    theme += startTheme;
                }

                // transition stuff won't be fired, so manually invoke any cleanup
                if (theme == _body.className) {
                    finishTransition();
                }

                // set the new classname (triggers the transition)
                _body.className = theme;
            }, 4);
        });
    };

    return that;
})();

var pjaxify = (function(window, document) {

    "use strict";

    var _timeout   = 1000,
        _links     = [],
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
        var _body      = $("body").get(0),
            _window    = $(window),
            startTheme = _body.className.match(/theme--([\w-]+)/)[1];

        // always listen out for when the theme has finished transitioning
        $(document).on("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", ".theme", finishTransition);

        // a bit of manky link sorting
        $(".nav li a").each(function(i, v) {
            _links.push($(v));
        });

        _links.sort(function(a, b) {
            return a.attr("href").length - b.attr("href").length;
        });

        $(document).on("click", ".inner a", function(e) {
            removeTimestamp(this);
        });

        var options = {
            timeout: _timeout,
            scrollTo: false
        };

        $(document).pjax("a.pjax", ".inner", options);

        $(document).on("pjax:end", function() {

            // we can't easily cache the nav height due to resize / orientation
            // changes, so we have to check it here
            var navHeight = $(".header").outerHeight();
            if (_window.scrollTop() > navHeight) {

                console.log(_window.scrollTop(), navHeight);
                _window.scrollTop(0);
            }

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

            // clear any search queries
            $(".search__input").val("");

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
}(window, document));

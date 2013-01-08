var pjaxify = (function() {
    var _timeout = 1000,
        _body = null,
        _links = [],
        currentUrl = null,
        that = {};

    var removeTimestamp = function(elem) {
        $(elem).attr("href", $(elem).attr("href").replace(/\?__t=\d+$/, ''));
    }

    var finishTransition = function() {
        // we remove this because we only actually *apply transitions* to
        // any selectors under .transition
        $("html").removeClass("transition");
        $("#inner a").each(function(i) {
            removeTimestamp(this);
        });
        if (twttr) {
            twttr.widgets.load();
        }

    }

    var linkNav = function() {
        var i = _links.length;
        //var currentUrl = window.location.pathname;
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

        // always listen out for when the header has finished transitioning
        $("#header").live("transitionend webkitTransitionEnd oTransitionEnd", finishTransition);

        /*
        $("#inner").bind("start.pjax", function(e) {
            // nothing at the moment
        });
        */

        // a bit of manky link sorting
        $(".navbar-inner li a").each(function(i, v) {
            _links.push($(v));
        });

        _links.sort(function(a, b) {
            return a.attr("href").length - b.attr("href").length;
        });

        currentUrl = window.location.pathname;
        if ($(".navbar-inner li.active").length == 0) {
            linkNav();
        }

        $("#inner a").live("click", function(e) {
            removeTimestamp(this);
        });

        // wire up pjax stuff
        $("a.pjax").live("click", function(e) {
            currentUrl = $(this).attr("href");
        });

        $("a.pjax").pjax("#inner", {
            "timeout": _timeout,
            "success": function() {
                // for balance you'd want this in start.pjax, but then
                // if there's a delay loading the content, things look a bit weird
                $(".navbar-inner li").removeClass("active");

                // if the collapsed nav state is open, get rid
                $(".nav-collapse.in").collapse('hide');

                linkNav();

                // @todo we should make this better, but it's still an improvement on
                // simply not moving the window viewport at all
                window.scrollTo(0, 0);

                // transition baby!
                $("html").addClass("transition");

                // temporarily give all the links a unique timestamp. we'll blat this
                // as soon as the transition's finished. Entirely for WebKit's benefit
                // @see http://code.google.com/p/chromium/issues/detail?id=101245
                $("#inner a").each(function(i) {
                    var dt = new Date().getTime();
                    $(this).attr("href", $(this).attr("href")+"?__t="+dt);
                });

                // even though the HTML has *already* changed by this point,
                // set a miniscule timeout for FF, otherwise link transitions fail
                setTimeout(function() {
                    var theme = $(".theme", _body).html();

                    // transition stuff won't be fired, so manually invoke any cleanup
                    if (theme == _body.className) {
                        finishTransition();
                    }

                    // set the new classname (triggers the transition)
                    _body.className = theme;

                    // bosh! cya later theme element, you've done your job
                    $(".theme", _body).remove();
                }, 4);
            }
        });
    }

    return that;
})();

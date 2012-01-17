var pjaxify = (function() {
    var _timeout = 1250,
        _body = null,
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

    that.init = function() {
        _body = $("body").get(0);

        // always listen out for when the header has finished transitioning
        $("#header").live("transitionend webkitTransitionEnd oTransitionEnd", finishTransition);

        /*
        $("#inner").bind("start.pjax", function(e) {
            // nothing at the moment
        });
        */

        $("#inner").bind("end.pjax", function() {
            // for balance you'd want this in start.pjax, but then
            // if there's a delay loading the content, things look a bit weird
            $(".topbar-inner li").removeClass("active");

            // a bit of manky link sorting
            var links = [];
            $(".topbar-inner li a").each(function(i, v) {
                links.push($(v));
            });

            links.sort(function(a, b) {
                return a.attr("href").length - b.attr("href").length;
            });
            var i = links.length;
            var currentUrl = window.location.pathname;
            if (currentUrl.search(/^\/\d{4}\/\d{2}/) !== -1 ||
                currentUrl.search(/^\/tag\/[a-z\s\.]+$/) !== -1) {
                currentUrl = "/articles";
            }
            while (i--) {
                var href = links[i].attr("href");
                if (href == currentUrl.substr(0, href.length)) {
                    links[i].parent().addClass("active");
                    break;
                }
            }
        });

        $("#inner a").click(function(e) {
            removeTimestamp(this);
        });

        // wire up pjax stuff
        $("a").pjax("#inner", {
            "success": function(html) {
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
            },
            "timeout": 1250 // generous timeout for now
        });
    }

    return that;
})();

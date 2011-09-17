var Forms = {
    handle: function(selector, callback) {
        $(selector).submit(function(e) {
            var self = this;
            e.preventDefault();

            $(self).find("input[type='submit']").attr("disabled", "");
            // clear out any error states we had before
            $(self).find(".clearfix.error").removeClass("error");
            $(self).find("span.help-block").html("");
            $.post($(self).attr("action"), $(self).serialize(), function(response) {
                $(self).find("input[type='submit']").removeAttr("disabled");
                if (response._errors != null) {
                    // deal with em
                    for (var i in response._errors) {
                        $(self).find("span#"+i+"_error").html(
                            response._errors[i]
                        ).parents("div.clearfix").addClass("error");
                    }
                    return;
                }
                callback(self);
            }, "json");
        });
    }
};

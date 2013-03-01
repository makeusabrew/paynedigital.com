var Forms = {
    handle: function(selector, callback) {
        $(selector).submit(function(e) {
            var self = this;
            e.preventDefault();

            var submit = $(self).find("input[type='submit']");
            submit.attr("disabled", "").addClass("btn-disabled");

            var buttonText = submit.val();
            submit.val("Sending...");
            // clear out any error states we had before
            $(self).find(".error").removeClass("error");
            $(self).find(".error__help").html("");
            $.post($(self).attr("action"), $(self).serialize(), function(response) {

                // aesthetically a small delay on setting the button text
                // back is a bit more appealing
                setTimeout(function() {
                    submit.removeAttr("disabled").removeClass("btn-disabled").val(buttonText);
                }, 200);

                if (response._errors != null) {
                    // deal with em
                    for (var i in response._errors) {
                        $(self).find("#"+i+"_error").html(
                            response._errors[i]
                        ).parents("li").addClass("error");
                    }
                    return;
                }
                callback(self);
            }, "json");
        });
    }
};

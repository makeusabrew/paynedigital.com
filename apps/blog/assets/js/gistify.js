var Gistify = (function(document) {
    "use strict";

    var ow    = document.write,
        head  = null,
        that  = {};

    that.init = function() {
        document.write = that.onDocumentWrite;
        head = $("head");
    };

    that.onDocumentWrite = function(v) {
        if (v.search(/^<link/) !== -1) {
            head.append(v);
        } else {
            var id = v.match(/id="gist([^\s]+)"/)[1];

            $("#g"+id).html(v);
        }
    };

    return that;

}(document));

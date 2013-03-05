var Runs = (function(d3) {
    "use strict";

    var runs = [],
        that = {};

    that.load = function(path, callback) {
        d3.csv(path, function(error, data) {
            data.reverse();

            runs = [];

            var parse = d3.time.format("%a, %e %b %Y %H:%M").parse;

            var total = 0;
            data.forEach(function(d) {

                var gain  = +d["Elevation Gain"];
                var miles = +d.Distance;
                var start = parse(d.Start);

                total += miles;

                var run = {
                    miles: miles,
                    gain: gain,
                    gainMile: (gain / miles),
                    paceSecs: that.minsToSecs(d["Avg Speed(Avg Pace)"]),
                    calories: +d.Calories.replace(/,/, ''),
                    start: start,
                    timeStart: new Date(2013, 0, 1, start.getHours(), start.getMinutes()),
                    totalMiles: total
                };

                runs.push(run);

            });

            callback();
        });
    };

    that.getAll = function() {
        return runs;
    };

    that.getElevationGroups = function(data, numGroups) {
        var min = 99999,
            max = 0;

        min = 100;
        max = 800;
        numGroups = 14;

        var block = 50;

        var i = numGroups;
        var groups = [];

        while (i--) {
            var _min = (i*block)+min;
            var _max = ((i+1)*block)+min;
            var str = _min+" - "+_max;
            groups.push({
                "label": str,
                "min"  : _min,
                "max"  : _max
            });
        }

        return groups;
    };

    that.getTotalDistance = function() {
        var total = 0;
        runs.forEach(function(r) {
            total += r.miles;
        });

        total = Math.floor(total * 100) / 100;

        return total;
    };

    that.minsToSecs = function(d) {
        var parts = d.split(":");
        return parseInt(parts[0])*60 + parseInt(parts[1]);
    };

    return that;

}(window.d3));

var Scatter = (function(document, d3) {
    "use strict";

    var x, y,  // scales
        svg,
        xAxis,
        yAxis,
        width,
        height,
        that = {};

    that.init = function() {
        var margin = {
            top    : 20,
            right  : 20,
            bottom : 30,
            left   : 40
        };

        width  = 960 - margin.left - margin.right;
        height = 600 - margin.top - margin.bottom;

        x = d3.scale.linear()
            .range([0, width]);

        y = d3.scale.linear()
            .range([height, 0]);

        xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        yAxis = d3.svg.axis()
            .scale(y)
            .orient("left")
            .tickFormat(secsToMins);

        svg = d3.select(".scatter").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .append("text")
          .attr("class", "label")
          .style("text-anchor", "end");

        // y axis and label
        svg.append("g")
          .attr("class", "y axis")
        .append("text")
          .attr("class", "label")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Pace (mins / mile)");

        renderTargetLine("10k", "8:00", 6.2);

        renderTargetLine("Half Marathon", "8:30", 13.1);

        renderTargetLine("Marathon", "9:00", 26.2);

        svg.append("text")
        .attr("x", width)
        .attr("y", 0)
        .attr("class", "label-legend")
        .attr("text-anchor", "end")
        .text("Elevation gain (ft)");
        
        $(document).on("change", "select[name=chart-type]", function(e) {
            e.preventDefault();
            var chart = $(this).val();
            
            that.plot(Runs.getAll(), chart);
        });
    };

    that.plot = function(data, type) {

        var metrics = {
            "elevation": {
                "x": "gain",
                "label": "Elevation Gain (ft)"
            },
            "elevation-mile": {
                "x": "gainMile",
                "label": "Gain per mile (ft)"
            },
            "distance": {
                "x": "miles",
                "label": "Distance (miles)"
            },
            "date": {
                "x": "start",
                "label": "Date"
            },
            "time": {
                "x": "timeStart",
                "label": "Time of day"
            }
        };

        var metric = metrics[type];

        var color = d3.scale.category20();

        var legends = Runs.getElevationGroups(data, 10);

        if (type === 'date' || type === 'time') {
            x = d3.time.scale();
        } else {
            x = d3.scale.linear();
        }

        x.domain(d3.extent(data, function(d) { return d[metric.x]; }));

        if (type === 'date') {
            x.nice(d3.time.day);
        } else if (type === 'time') {
            x.nice(d3.time.hour);
        } else {
            x.nice();
        }

        x.range([0, width]);

        xAxis.scale(x);

        // nasty, but we always want to show at *least* something below the 8:00 line - nice
        // might not quite cut it
        y.domain(d3.extent(data.concat({paceSecs: 470}), function(d) { return d.paceSecs; })).nice();

        var calories = d3.scale.linear()
                       .range([2, 7]);

        calories.domain(
            d3.extent(data, function(d) { return d.calories; })
        );

        // x axis and label
        svg.selectAll(".x.axis")
        .call(xAxis)
        .select(".label")
        .attr("x", width)
        .attr("y", -6)
        .text(metric.label);

        svg.selectAll(".target-line")
        .attr("transform", function() {
            var line = d3.select(this);
            var cy = y(line.attr("data-target"));
            return "translate(0, "+cy+")";
        });

        svg.selectAll(".y.axis")
        .call(yAxis);

        // legend gubbins
        var legend = svg.selectAll(".legend")
        .data(legends)
        .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function(d, i) { return "translate(0," + (10 + (i * 15)) + ")"; });

        legend.append("rect")
        .attr("x", width - 16)
        .attr("width", 16)
        .attr("height", 8)
        .style("fill", function(d) {
            return color(d.label);
        });

        legend.append("text")
          .attr("x", width - 20)
          .attr("y", 4)
          .attr("dy", ".35em")
          .style("text-anchor", "end")
          .text(function(d) { return d.label; });

        // data points
        var points = svg.selectAll(".dot").data(data);

        points
        .transition()
        .duration(800)
        .attr("cx", function(d) { return x(d[metric.x]); })

        points
        .enter().append("circle")
        .attr("class", "dot")
        .attr("r", function(d) { return calories(d.calories); })
        .attr("cx", function(d) { return x(d[metric.x]); })
        .attr("cy", function(d) { return y(d.paceSecs); })
        .style("fill", function(d) {
            var i = legends.length;
            while (i--) {
                var l = legends[i];
                if (d.gain < l.max) {
                    return color(l.label);
                }
            }
        })
        .on("mouseover", function(d) {
            var point = d3.select(this);

            var oldRadius = calories(d.calories);

            point.transition()
            .duration(1000)
            .attr("r", oldRadius*2)
            .ease("elastic");
        })
        .on("mouseout", function(d) {
            var point = d3.select(this);

            var oldRadius = calories(d.calories);

            point.transition()
            .duration(1000)
            .attr("r", oldRadius)
            .ease("elastic");
        });
    };

    /**
     * private API
     */

    function renderTargetLine(title, target, distance) {
        var line = svg
        .append("g")
        .attr("class", "target-line")
        .attr("data-target", Runs.minsToSecs(target));

        line.append("line")
        .attr("x1", 5)
        .attr("x2", width)
        .attr("y1", 0)
        .attr("y2", 0)
        .style("stroke", "gray")
        .style("stroke-dasharray", "5, 5")

        line.append("text")
        .attr("x", 20)
        .attr("y", 0)
        .attr("dy", "-0.3em")
        .attr("fill", "grey")
        .text(title);

        line.on("mouseover", function() {
            svg.selectAll(".dot")
            .transition()
            .duration(500)
            .style("opacity", function(d) {
                if (withinThreshold(d.miles, distance, 0.05)) {
                    return 1.0;
                }
                return 0.25;
            });
        })
        .on("mouseout", function() {
            svg.selectAll(".dot")
            .transition()
            .style("opacity", 1.0);
        });
    }

    function withinThreshold(actual, target, allowance) {
        var threshold = (target * allowance);
        var min = target - threshold;
        var max = target + threshold;

        return (actual >= min && actual <= max);
    }

    function secsToMins(d) {
        var mins = Math.floor(d / 60);
        var secs = (d % 60);
        if (secs < 10) {
            secs = "0"+secs;
        }
        return mins+":"+secs;
    }

    return that;

}(document, window.d3, window.jQuery));

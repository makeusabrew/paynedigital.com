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

        width  = 1000 - margin.left - margin.right;
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

        svg.append("g")
        .attr("class", "legend-outer")
        .append("text")
        .attr("x", width)
        .attr("y", 0)
        .attr("class", "label-legend")
        .attr("text-anchor", "end")
        .text("");
        
        $(document).on("change", "select[name=chart-type]", function(e) {
            e.preventDefault();
            var chart = $(this).val();
            
            that.plot(Runs.getAll(), chart);
        });
    };

    that.plot = function(data, type) {

        var metrics = {
            "elevation": {
                "x": {
                    "key": "gain",
                    "label": "Elevation Gain (ft)"
                },
                "legend": {
                    "key": "miles",
                    "label": "Distance (miles)"
                }
            },
            "elevation-mile": {
                "x": {
                    "key": "gainMile",
                    "label": "Gain per mile (ft)"
                },
                "legend": {
                    "key": "miles",
                    "label": "Distance (miles)"
                }
            },
            "distance": {
                "x": {
                    "key": "miles",
                    "label": "Distance (miles)"
                },
                "legend": {
                    "key": "gain",
                    "label": "Elevation Gain (ft)"
                }
            },
            "date": {
                "x": {
                    "key": "start",
                    "label": "Date"
                },
                "legend": {
                    "key": "miles",
                    "label": "Distance (miles)"
                }
            },
            "time": {
                "x": {
                    "key": "timeStart",
                    "label": "Time of day"
                },
                "legend": {
                    "key": "miles",
                    "label": "Distance (miles)"
                }
            }
        };

        var metric = metrics[type];

        var color = d3.scale.category20();

        var legends = Runs.getLegendGroups(data, metric.legend.key);

        if (type === 'date' || type === 'time') {
            x = d3.time.scale();
        } else {
            x = d3.scale.linear();
        }

        x.domain(d3.extent(data, function(d) { return d[metric.x.key]; }));

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
        //y.domain(d3.extent(data.concat({paceSecs: 470}), function(d) { return d.paceSecs; })).nice();
        // we've got a serious outlier now in the form of the trail run/walk which ruins the graphs; for
        // now just hard code but this needs revisiting!
        y.domain([420, 600]);

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
        .text(metric.x.label);

        svg.selectAll(".target-line")
        .attr("transform", function() {
            var line = d3.select(this);
            var cy = y(line.attr("data-target"));
            return "translate(0, "+cy+")";
        });

        svg.selectAll(".y.axis")
        .call(yAxis);

        // legend gubbins
        svg.select(".label-legend")
        .text(metric.legend.label);

        d3.select("[data-legend]")
        .text(metric.legend.label)

        var legend = svg
        .select(".legend-outer")
        .selectAll(".legend")
        .data(legends);

        var legendGroup = legend.enter()
        .append("g");

        legendGroup.attr("class", "legend")
        .attr("transform", function(d, i) { return "translate(0," + (10 + (i * 15)) + ")"; })
        .append("rect")
        .attr("class", "legend__rect")
        .attr("x", width - 16)
        .attr("width", 16)
        .attr("height", 8)
        legendGroup.append("text")
          .attr("x", width - 20)
          .attr("y", 4)
          .attr("dy", ".35em")
          .attr("class", "legend__text")
          .style("text-anchor", "end");

        legend.select(".legend__text").text(function(d) { return d.label; });
        legend.select(".legend__rect")
        .style("fill", function(d) {
            return color(d.label);
        });

        legend.exit().remove();

        // data points
        var points = svg.selectAll(".dot").data(data);

        var shortFormat = d3.time.format("%d %B");

        points
        .enter().append("circle")
        .attr("class", "dot")
        .attr("r", function(d) { return calories(d.calories); })
        .attr("cy", function(d) { return y(d.paceSecs); })
        .on("mouseover", function(d) {
            var point = d3.select(this);

            var oldRadius = calories(d.calories);

            point.transition()
            .duration(1000)
            .attr("r", oldRadius*2)
            .ease("elastic");

            var str = ""
            str += "<div><b>"+d.miles+" miles @ "+secsToMins(d.paceSecs)+" min/mi</b></div>";
            str += "<div>"+d.calories+" calories, "+d.gain+"</b> ft climb</div>";
            str += "<div>"+shortFormat(d.start)+"</div>";

            d3.select("body").append("div")
            .attr("class", "running__tip")
            .style("opacity", 0)
            .style("left", (d3.event.pageX + 22) + "px")     
            .style("top", (d3.event.pageY - 30) + "px")
            .html(str)
            .transition()
            .duration(500)
            .style("opacity", 1);

        })
        .on("mouseout", function(d) {
            var point = d3.select(this);

            var oldRadius = calories(d.calories);

            point.transition()
            .duration(1000)
            .attr("r", oldRadius)
            .ease("elastic");

            d3.selectAll(".running__tip")
            .transition()
            .duration(500)
            .style("opacity", 0)
            .remove();
        });

        points
        .style("fill", function(d) {
            var i = legends.length;
            var key = metric.legend.key;
            while (i--) {
                var l = legends[i];
                if (d[key] < l.max) {
                    return color(l.label);
                }
            }
        })
        .transition()
        .duration(800)
        .attr("cx", function(d) { return x(d[metric.x.key]); })

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

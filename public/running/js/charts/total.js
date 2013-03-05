var Total = (function(document, d3) {
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

        width  = 1100 - margin.left - margin.right;
        height = 300 - margin.top - margin.bottom;

        x = d3.time.scale()
        .domain([
            new Date(2013, 0, 1),
            new Date(2013, 11, 31, 23, 59, 999)
        ])
        .range([0, width]);

        y = d3.scale.linear()
        .domain([0, 1000])
        .range([height, 0]);

        xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");

        svg = d3.select(".total").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .append("text")
          .attr("class", "label")
          .style("text-anchor", "end")
          .text("Date");

        // y axis and label
        svg.append("g")
          .attr("class", "y axis")
        .append("text")
          .attr("class", "label")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Total miles");
    };
    
    that.plot = function(data) {

        // x axis and label
        svg.selectAll(".x.axis")
        .call(xAxis)
        .select(".label")
        .attr("x", width)
        .attr("y", -6);

        svg.selectAll(".y.axis")
        .call(yAxis);

        var area = d3.svg.area()
        .x(function(d) { return x(d.start); })
        .y0(height)
        .y1(function(d) { return y(d.totalMiles); });

        svg.append("path")
        .datum(data)
        .attr("class", "area")
        .attr("d", area);

        svg.append("line")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", height)
        .attr("y2", 0)
        .style("stroke", "gray")
        .style("stroke-dasharray", "3, 7");
    };

    return that;

}(document, window.d3, window.jQuery));

{extends 'default/views/base.tpl'}
{block name='title'}The Run 1,000 Challenge{/block}
{block name='theme'}paper{/block}
{block name='content'}
    <div class='running wrapper'>
    <div class='running__body' style='display:none;'>
        <h1>I want to run <del><b>1000</b> miles</del> 1,500 kilometres&#42; in <b>2013</b>.<br />
        <small>So far I&rsquo;ve run <b data-total>&hellip;</b> miles (or <b data-total-km>&hellip;</b> kilometres).</small></h1>


        <div class="total chart">
            <p>The following chart simply plots my total mileage this year against what I need to be running
            to hit 1,000 miles by the 31st December. A knee injury put me out of action from April&ndash;June
            and life got in the way during September so the challenge may well have to start all over again
            in 2014!</p>

            <p class="bump-out">&#42; The gaps from April&ndash;June meant 1,000 miles wasn&rsquo;t going to happen this year.
            But the revised target of 1,500km&mdash;932 miles&mdash;was <i>just</i> hit with a few days to spare!</p>
        </div>

        <div class="scatter chart">
            <p>The next chart plots all my runs this year on a scatter graph. The idea is to
            try and gain an insight into what factors have the most impact on my pace per mile: feel
            free to play around with the x-axis value, though to be honest the chart needs
            to be a little better organised to glean much from it.</p>
            <div class="bump-out">
                <b>X-Axis:</b>
                <select name="chart-type">
                    <option value='distance'>Distance</option>
                    <option value='elevation'>Elevation Gain</option>
                    <option value='elevation-mile'>Gain per mile</option>
                    <option value='date'>Date</option>
                    <option value='time'>Time of day</option>
                </select>
                <span class="split-after"></span>

                <b>Y-Axis:</b> Pace <span class="split-after"></span>

                <b>Legend:</b> <span data-legend>Elevation gain (ft)</span> <span class="split-after"></span>

                <b>Plot size:</b> <span data-legend>Calories burned</span>
            </div>
        </div>

        <p>I ran the <a href="http://www.theyorkshiremarathon.com/">Yorkshire Marathon</a>
        on the 20th October on behalf of <a href="http://www.royalmarsden.org/">The Royal Marsden Cancer Charity</a>,
        a world-leading cancer research centre and hospital which provides treatment and care for more than 40,000
        cancer patients every year. This page does <i>not</i> exist to seek donations, though all those received were
        <a href="https://www.justgiving.com/Nick-Payne-Yorkshire-Marathon">hugely appreciated</a> and helped me hit
        my fundraising target of £1,000.</p>

        <hr class="rule    rule--ornament rule--dotted" />

        <p>The charts on this page use the fantastic <a href="http://d3js.org/">d3js</a> library&mdash;they&rsquo;re
        my first attempt at using it and as such are pretty crude. Check out the official
        <a href="https://github.com/mbostock/d3/wiki/Gallery">d3 gallery</a> to see just what it&rsquo;s actually capable of!</p>
    </div>
{/block}
{block name=script}
    <script src="//d3js.org/d3.v3.min.js"></script>
    <script src="/running/js/runs.js"></script>
    <script src="/running/js/charts/scatter.js"></script>
    <script src="/running/js/charts/total.js"></script>

    <script>
        Runs.load({$runs}, function() {

            var data = Runs.getAll();

            Scatter.init();
            Total.init();

            Scatter.plot(data, 'distance');
            Total.plot(data);

            $("[data-total]").html(Runs.getTotalDistance("miles"));
            $("[data-total-km]").html(Runs.getTotalDistance("km"));

            $(".running__body").fadeIn();

            pjaxify.disable();
        });
    </script>
{/block}

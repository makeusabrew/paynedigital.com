{extends 'default/views/base.tpl'}
{block name='title'}The Run 1,000 Challenge{/block}
{block name='theme'}paper{/block}
{block name='content'}
    <div class='running wrapper'>
    <div class='running__body' style="display:none;">
        <h1>I want to run <b>1,000</b> miles in <b>2013</b>. So far I&rsquo;ve run <b data-total>&hellip;</b> miles.</h1>


        <div class="total chart">
            <p>The following chart simply plots my total mileage this year against what I need to be running
            to hit 1,000 miles by the 31st December. So far so good!</p>
        </div>

        <div class="scatter chart">
            <p>This chart plots all my runs this year on a scatter graph. The idea is to
            try and gain an insight into what factors have the most impact on my pace per mile: feel
            free to play around with the x-axis value, though to be honest the chart needs
            to be a little better organised to glean much from it.</p>
            <p>
                <b>X-Axis:</b>
                <select name="chart-type">
                    <option value='distance'>Distance</option>
                    <option value='elevation'>Elevation Gain</option>
                    <option value='elevation-mile'>Gain per mile</option>
                    <option value='date'>Date</option>
                    <option value='time'>Time of day</option>
                </select>

                <b>Y-Axis:</b> Pace

                <b>Legend:</b> <span data-legend>Elevation gain (ft)</span>

                <b>Circle size:</b> <span data-legend>Calories</span>
            </p>
        </div>

        <p>I&rsquo;m also running the <a href="http://www.theyorkshiremarathon.com/">Yorkshire Marathon</a>
        on the 20th October on behalf of <a href="http://www.royalmarsden.org/">The Royal Marsden Cancer Charity</a>,
        a world-leading cancer centre which provides treatment and care for more than 40,000 cancer patients every
        year. This page does <i>not</i> exist to seek donations, though any would of course be
        <a href="https://www.justgiving.com/Nick-Payne-Yorkshire-Marathon">hugely appreciated</a>.</p>
    </div>
{/block}
{block name=script}
    <script src="//d3js.org/d3.v3.min.js"></script>
    <script src="/running/js/runs.js"></script>
    <script src="/running/js/charts/scatter.js"></script>
    <script src="/running/js/charts/total.js"></script>

    <script>
        Runs.load("/running/data/runs.csv", function() {

            var data = Runs.getAll();

            Scatter.init();
            Total.init();

            Scatter.plot(data, 'distance');
            Total.plot(data);

            $("[data-total]").html(Runs.getTotalDistance());

            $(".running__body").fadeIn();
        });
    </script>
{/block}

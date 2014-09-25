(function(){
  'use strict';

  $(document).ready(initialize);

  function initialize(){
    // getLocation();
    getNews();
    drawGraph(gon.corn_prices, "#ede821", "corn");
    drawGraph(gon.soybean_prices, "#51c461", "soybeans");
    drawGraph(gon.wheat_prices, "#c48d48", "wheat");
  }

  function drawGraph(crop_data, color, crop){
    /* implementation heavily influenced by http://bl.ocks.org/1166403 */
    
    // define dimensions of graph
    var m = [0, 0, 0, 0]; // margins
    var w = 130 - m[1] - m[3]; // width
    var h = 35 - m[0] - m[2]; // height
    
    // create a simple data array that we'll plot with a line (this array represents only the Y values, X will just be the index location)
    var data = crop_data;
    data.reverse();
    var largest = Math.max.apply(Math, data);
    var smallest = Math.min.apply(Math, data);

    // X scale will fit all values from data[] within pixels 0-w
    var x = d3.scale.linear().domain([0, data.length]).range([0, w]);
    // Y scale will fit values from 0-10 within pixels h-0 (Note the inverted domain for the y-scale: bigger is up!)
    var y = d3.scale.linear().domain([(smallest-20), (largest+20)]).range([h, 0]);
      // automatically determining max range can work something like this
      // var y = d3.scale.linear().domain([0, d3.max(data)]).range([h, 0]);

    // create a line function that can convert data[] into x and y points
    var line = d3.svg.line()
      // assign the X function to plot our line as we wish
      .x(function(d,i) { 
        // verbose logging to show what's actually being done
        return x(i); 
      })
      .y(function(d) { 
        // return the Y coordinate where we want to plot this datapoint
        return y(d); 
      })

      // Add an SVG element with the desired dimensions and margin.
      var graph = d3.select("#graph-"+crop+"").append("svg:svg")
            .attr("width", w + m[1] + m[3])
            .attr("height", h + m[0] + m[2])
          .append("svg:g")
            .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

      // create yAxis
      var xAxis = d3.svg.axis().scale(x).ticks(0).tickSize(-h);
      // Add the x-axis.
      graph.append("svg:g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + h + ")")
            .call(xAxis);


      // create left yAxis
      var yAxisLeft = d3.svg.axis().scale(y).ticks(0).tickSize(0).orient("left");
      // Add the y-axis to the left
      graph.append("svg:g")
            .attr("class", "y axis")
            .attr("transform", "translate(0,0)")
            .call(yAxisLeft);
      
      // Add the line by appending an svg:path element with the data line we created above
      // do this AFTER the axes above so that the line is above the tick-lines
      graph.append("svg:path").attr({"d": line(data), "stroke-linejoin": "round", "stroke": color, "stroke-linecap": "round"});
  }

  function getLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(getWeatherConditions);
      navigator.geolocation.getCurrentPosition(getWeatherForecast);
    } else { 
      x.innerHTML = "Geolocation is not supported by this browser.";
    }
  }

  function getNews(){
    var url = 'http://api.usatoday.com/open/articles?tag=agriculture&count=5&encoding=json&api_key=2tpr8mjmcd79dh9ebffs6a8e';
    $.getJSON(url, function(data){
      console.log(data);
      data.stories.forEach(function(story){
        var string = '<li><p><a href="'+story.link+'">'+story.title+'</a></p><p class="news-description">'+story.description+'</p></li>'
        $('.news-articles ul').append(string);
      });
    });
  }

  function getWeatherConditions(position){
    $.ajax({
      url : "http://api.wunderground.com/api/bd42f70292516b80/geolookup/conditions/q/"+position.coords.latitude+","+position.coords.longitude+".json",
      dataType : "jsonp",
      success : function(data) {
        console.log(data)
        var city = data['location']['city'];
        var state = data['location']['state'];
        var temp_f = data['current_observation']['temp_f'];
        var icon = data['current_observation']['icon_url'];
        $('#icon').append('<img src="'+icon+'">');
        $('#temp').append('<p>'+temp_f+'&#176;</p>');
        $('.weather-current').prepend('<p>'+city+', '+state+' - '+data['current_observation']['icon']+'</p>');
      }
    });
  }

  function getWeatherForecast(position){
    $.ajax({
      url : "http://api.wunderground.com/api/bd42f70292516b80/geolookup/forecast/q/"+position.coords.latitude+","+position.coords.longitude+".json",
      dataType : "jsonp",
      success : function(data) {
        console.log(data)
        var days = data['forecast']['simpleforecast']['forecastday']
        days.forEach(function(day){
          $('.weather-forecast').append('<div class="col-xs-3"><p class="day">'+day['date']['weekday_short']+'</p><img src="'+day['icon_url']+'"><p>'+day['high']['fahrenheit']+'&#176;</p></div>');
        });
      }
    });
  }




})();
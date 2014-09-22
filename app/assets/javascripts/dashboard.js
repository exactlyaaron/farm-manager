(function(){
  'use strict';

  $(document).ready(initialize);

  function initialize(){
    getLocation();
    getNews();
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
    var url = 'http://api.usatoday.com/open/articles?tag=agriculture&count=10&encoding=json&api_key=2tpr8mjmcd79dh9ebffs6a8e';
    $.getJSON(url, function(data){
      console.log(data);
      data.stories.forEach(function(story){
        var string = '<li><p><a href="'+story.link+'">'+story.title+'</a></p><p>'+story.description+'</p></li>'
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
        $('.weather-current').append('<p>Conditions in '+city+', '+state+'</p><img src="'+icon+'"><p>'+temp_f+' degrees</p>');
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
          $('.weather-forecast').append('<img src="'+day['icon_url']+'">');
        });
        // var city = data['location']['city'];
        // var state = data['location']['state'];
        // var temp_f = data['current_observation']['temp_f'];
        // var icon = data['current_observation']['icon_url'];
      }
    });
  }


})();
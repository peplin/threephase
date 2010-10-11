$ = jQuery.noConflict();

$(document).ready(function() {
  $(".load-profile").each(function() {
    var element = this;
    var city_id = $(this).attr('rel');
    $.ajax({
      type : "GET",
      url: '/cities/' + $(this).attr('rel') + '/load-profile',
      success : function(data){

        var hours = [];
        for(var i = 1; i < 25; i++) {
          hours.push(i);
        }

        var demand = [];
        $.each(data, function(key, value) {
          demand.push(value.load_profile.demand);
        });

        var raphael = Raphael(city_id + "-load-profile");
        var graph = raphael.g.linechart(10, 0, 500, 150, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        raphael.g.text(250, 130, "Hour");
        raphael.g.text(40, 75, "MW");
      }
    });
  });

  $(".bids").each(function() {
    var element = this;
    var generator_id = $(this).attr('rel');

    $.ajax({
      type : "GET",
      url: '/cities/' + $(this).attr('rel') + '/load-profile',
      success : function(data){

        var hours = [];
        for(var i = 1; i < 25; i++) {
          hours.push(i);
        }

        var demand = [];
        $.each(data, function(key, value) {
          demand.push(value.load_profile.demand);
        });

        var raphael = Raphael(city_id + "-load-profile");
        var graph = raphael.g.linechart(10, 0, 500, 150, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        raphael.g.text(250, 130, "Hour");
        raphael.g.text(40, 75, "MW");
      }
    });
  });
});

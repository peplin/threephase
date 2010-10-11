$ = jQuery.noConflict();

$(document).ready(function() {
  $(".load-profile").each(function() {
    element = this;
    $.ajax({
      type : "GET",
      url: '/cities/' + $(this).attr('rel') + '/load-profile',
      success : function(data){

        hours = [];
        for(var i = 1; i < 25; i++) {
          hours.push(i);
        }

        demand = [];
        $.each(data, function(key, value) {
          demand.push(value.load_profile.demand);
        });

        var raph = Raphael("load-profile");
        var graph = raph.g.linechart(10, 0, 500, 150, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        raph.g.text(250, 130, "Hour");
        raph.g.text(40, 75, "MW");
      }
    });
  });
});

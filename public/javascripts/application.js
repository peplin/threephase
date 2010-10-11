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

        var r = Raphael(city_id + "-load-profile", 500, 155);
        var graph = r.g.linechart(20, 0, 480, 130, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        r.g.text(250, 145, "Hour");
        r.g.text(10, 75, "MW");
      }
    });
  });

  $(".bids").each(function() {
    var element = this;
    var generator_id = $(this).attr('rel');

    $.ajax({
      type : "GET",
      url: '/generators/' + $(this).attr('rel') + '/bids',
      success : function(data){
        var count = [];
        for(var i = 1; i <= data.length; i++) {
          count.push(i);
        }

        var prices = [];
        $.each(data, function(key, value) {
          prices.push(value.bid.price);
        });

        if(data.length > 0) {
          var r = Raphael(generator_id + "-bids", 500, 155);
          var graph = r.g.linechart(10, 0, 480, 130, count, prices,
              {nostroke: false, axis: "0 0 0 1", symbol: "o", smooth: true}
              ).hoverColumn(function() {
                this.tags = r.set();
                for (var i = 0, ii = this.y.length; i < ii; i++) {
                  this.tags.push(
                      r.g.tag(this.x, this.y[i], this.values[i], 160, 10
                      ).insertBefore(this).attr([{fill: "#fff"},
                      {fill: this.symbols[i].attr("fill")}]));
                }
              }, function() {
                this.tags && this.tags.remove();
            }); 
          r.g.text(10, 75, "$/MW");
          graph.symbols.attr({r: 3}); 
        }
      }
    });
  });
});

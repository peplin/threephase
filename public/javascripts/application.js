$ = jQuery.noConflict();

function drawGraphs() {
  $(".load-profile").each(function() {
    var element = this;
    var cityId = $(this).attr('rel');
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

        var r = Raphael(cityId + "-load-profile", 500, 155);
        var graph = r.g.linechart(20, 0, 480, 130, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        r.g.text(250, 145, "Hour");
        r.g.text(10, 75, "MW");
      }
    });
  });

  $(".bids").each(function() {
    var element = this;
    var generatorId = $(this).attr('rel');

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
          var r = Raphael(generatorId + "-bids", 500, 155);
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
}

function drawPercentageSlider(element, value) {
    drawSlider(element, value, 1, 100, '%');
}

function drawSlider(element, value, min, max, unit, range) {
  var value = typeof(value) != 'undefined' ? value :
      parseInt($('input#' + $(element).attr('rel')).attr('value'));
  var min = typeof(min) != 'undefined' ? min :
      parseInt($(element).attr('data-min'));
  var max = typeof(max) != 'undefined' ? max :
      parseInt($(element).attr('data-max'));
  var unit = typeof(unit) != 'undefined' ? unit : $(element).attr('data-unit');
  var range = typeof(range) != 'undefined' ? range : 'min';
  var prepend = typeof(prepend) != 'undefined' ? prepend :
      $(element).attr('data-prepend');

  $(element).slider({
      range: range,
      value: value,
      min: min,
      max: max,
      slide: function(event, ui) {
          var unitized_value = ui.value;
          if(unit == "%") {
              unitized_value += unit; 
          } else {
              if(prepend == "1") {
                unitized_value = unit + ui.value; 
              } else {
                unitized_value += " " + unit; 
              }
          }
          $('input#' + $(element).attr('rel')).val(ui.value);
          $('span[name=' + $(element).attr('rel') + ']').text(unitized_value);
      }
  });
}

function drawSliders() {
  $(".percentage").each(function() {
      drawPercentageSlider(this);
  });

  $(".slider").each(function() {
      drawSlider(this);
  });
}

$(document).ready(function() {
  drawGraphs();
  drawSliders();
});

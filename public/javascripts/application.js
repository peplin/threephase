$ = jQuery.noConflict();

function drawGraphs() {
  // TODO DRY the graph creation, once we figure out a common implementation

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
          demand.push(value);
        });

        var r = Raphael(cityId + "-load-profile", 450, 155);
        var graph = r.g.linechart(20, 0, 430, 130, hours, demand,
            {nostroke: false, axis: "0 0 1 1", smooth: true});
        r.g.text(250, 145, "Hour");
        r.g.text(50, 75, "MW");
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
          var r = Raphael(generatorId + "-bids", 450, 155);
          var graph = r.g.linechart(10, 0, 380, 130, count, prices,
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
          r.g.text(50, 75, "$/MW");
          graph.symbols.attr({r: 3});
        }
      }
    });
  });

  $(".levels").each(function() {
    var element = this;
    var cityId = $(this).attr('rel');
    $.ajax({
      type : "GET",
      // TODO need a generic technical component instances endpoint
      url: '/generators/' + $(this).attr('rel') + '/levels',
      success : function(data){
        var days = [];
        for(var i = data.length; i > 0; i--) {
          days.push(i);
        }

        var levels = [];
        $.each(data, function(key, value) {
          levels.push(value.average_operating_level.operating_level);
        });

        var r = Raphael(cityId + "-levels", 450, 155);
        var graph = r.g.linechart(20, 0, 430, 130, days, levels,
            {nostroke: false,
              axis: "0 0 1 1",
              smooth: true});
        r.g.text(250, 145, "Days Ago");
        r.g.text(50, 75, "MW");
      }
    });
  });

  $(".costs").each(function() {
    var element = this;
    var cityId = $(this).attr('rel');
    $.ajax({
      type : "GET",
      url: '/generators/' + $(this).attr('rel') + '/costs',
      success : function(data){
        var days = [];
        for(var i = data.length; i > 0; i--) {
          days.push(i);
        }

        var costs = [];
        $.each(data, function(key, value) {
          costs.push(value);
        });

        var r = Raphael(cityId + "-costs", 450, 155);
        var graph = r.g.linechart(20, 0, 430, 130, days, costs,
            {nostroke: false,
              axis: "0 0 1 1",
              smooth: true});
        r.g.text(250, 145, "Days Ago");
        r.g.text(50, 75, "MC ($)");
      }
    });
  });

  $(".prices").each(function() {
    var element = this;
    var cityId = $(this).attr('rel');
    $.ajax({
      type : "GET",
      url: '/states/' + $(this).attr('rel') + '/prices',
      success : function(data){
        var days = [];
        for(var i = data.length; i > 0; i--) {
          days.push(i);
        }

        var prices = [];
        $.each(data, function(key, value) {
          prices.push(value.marginal_price.marginal_price);
        });

        var r = Raphael(cityId + "-prices", 450, 155);
        var graph = r.g.linechart(20, 0, 430, 130, days, prices,
            {nostroke: false,
              axis: "0 0 1 1",
              smooth: true});
        r.g.text(250, 145, "Days Ago");
        r.g.text(50, 75, "MC ($)");
      }
    });
  });

  $(".curve").each(function() {
    var element = this;
    var cityId = $(this).attr('rel');
    $.ajax({
      type : "GET",
      url: '/states/' + $(this).attr('rel') + '/curve',
      success : function(data){
        var days = [];
        for(var i = data.length; i > 0; i--) {
          days.push(i);
        }

        var lines = [];
        var metCapacity = 0;
        var highestCost = 0;
        $.each(data.generators, function(key, value) {
            var line = []
            line.push([metCapacity, value.marginal_cost]);
            line.push([metCapacity + value.capacity, value.marginal_cost]);
            metCapacity += value.capacity;
            lines.push({data: line, label: "Gen. " + value.id})
            highestCost = value.marginal_cost;
        });
        lines.push({data: [[data.demand, highestCost - 25],
              [data.demand, highestCost + 25]],
            label: "Demand"}); 

        $.plot($("#" + cityId + "-curve"), lines);
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
  var step = typeof(step) != 'undefined' ? step :
      parseInt($(element).attr('data-step'));
  var prepend = typeof(prepend) != 'undefined' ? prepend :
      $(element).attr('data-prepend');
  var disabled = typeof(disabled) != 'undefined' ? disabled :
      $(element).attr('data-disabled');

  $(element).slider({
      range: range,
      value: value,
      min: min,
      max: max,
      step: step,
      disabled: disabled == "1",
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
  //drawGraphs();
  drawSliders();
  if(drawMap != undefined) {
    drawMap();
  }
});

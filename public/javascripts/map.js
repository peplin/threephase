function rangeMap(value, istart, istop, ostart, ostop) {
    return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
};

function drawMap() {
    var stateId = $(".map").attr('rel');
    // TODO get the height/width from API
    var width = 450,
        height = 300,
        map = Raphael(stateId + "-map", width, height);
    getCities(stateId, map);
    getBlocks(stateId, map);
}

function getCities(stateId, map, width, height) {
    $.ajax({
        type : "GET",
        url: '/states/' + stateId + '/cities',
        success : function(data){
            $.each(data, function(key, value) {
                var city = value.city;
                renderCircle(map, city.x, city.y, city.customers, 30,
                        city.name);
            });
        }
    });
}

function getBlocks(stateId, map, width, height) {
    $.ajax({
        type : "GET",
        url: '/states/' + stateId + '/map',
        success : function(data){
            $.each(data.map.blocks, function(key, value) {
                var size = 1;
                switch(value.block_type) {
                    case "mountain":
                        size = 15;
                        break;
                    case "water":
                        size = 10;
                    case "plains":
                        size = 6;
                        break;
                };
                renderCircle(map, value.x, value.y, size, 15);
            });
        }
    });
}

function renderCircle(map, x, y, size, max, name) {
    var R = Math.min(Math.round(Math.sqrt(size / Math.PI)), max);
    (function (dx, dy, R, name) {
        var color = "hsb(" + [(1 - R / max) * .5, 1, .75] + ")";
        var dot = map.circle(dx, dy, R).attr({stroke: "none", fill: color});
        if(name != undefined) {
            var label = map.text(dx, dy, name).attr(
                    {"font": '14px Fontin-Sans, Arial', stroke: "none",
                        fill: "#000"});
        }
    })(rangeMap(x, 0, 600, 0, map.width), rangeMap(y, 0, 400, 0, map.height),
            R, name);
    // TODO get the height/width from API
}

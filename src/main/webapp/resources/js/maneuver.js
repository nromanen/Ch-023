$(document).ready(function(){

    function updatePDF() {
        $.ajax({
            url: "/Carting/SHKP/maneuver",
            type: "POST",
            data: {
                table: $('#maneuver').html()
            }
        });
    }

    $('#add').click(function() {
        $('#head').append('<th class="snake">snake</th>');
        $('.cols').append('<td class="snake"><input type="text" class="snake${racer.getNumberInCompetition()}" maxlength="4" size="1"></td>');
        $("#pointsTable").height($("#maneuverTable").height());
        $("#pointsHead").height($("#head").height());
    });

    $('#remove').click(function() {
        var selectedClass = $( "#del option:selected" ).attr('class');
        $('.' + selectedClass).remove();
        //$("#pointsTable").height($("#maneuverTable").height());
        //$("#pointsHead").height($("#head").height());
    });

    $( ".snake" ).change(function() {
        $("#snake" + $(this).attr('racer')).text($(this).val());
    });

    $( ".flower" ).change(function() {
        $("#flower" + $(this).attr('racer')).text($(this).val());
    });

    $( ".stopLine" ).change(function() {
        $("#stopLine" + $(this).attr('racer')).text($(this).val());
    });

    $( ".hall" ).change(function() {
        $("#hall" + $(this).attr('racer')).text($(this).val());
    });

    $( ".rightCircle" ).change(function() {
        $("#rightCircle" + $(this).attr('racer')).text($(this).val());
    });

    $( ".leftCircle" ).change(function() {
        $("#leftCircle" + $(this).attr('racer')).text($(this).val());
    });

    $( ".leftCol" ).change(function() {
        $("#leftCol" + $(this).attr('racer')).text($(this).val());
    });

    $( ".rightCol" ).change(function() {
        $("#rightCol" + $(this).attr('racer')).text($(this).val());
    });

    $( ".time" ).change(function() {
        $("#time" + $(this).attr('racer')).text($(this).val());
    });

    $('#save').click(function() {
        for (var i = 1; i <= $("#racersCount").val(); i++) {
            var racerId = $("#id" + i).val();
            var snake = Number($("#snake" + racerId).text());
            var flower = Number($("#flower" + racerId).text());
            var stop = Number($("#stopLine" + racerId).text());
            var hall = Number($("#hall" + racerId).text());
            var cirLeft = Number($("#leftCircle" + racerId).text());
            var cirRig = Number($("#rightCircle" + racerId).text());
            var colLeft = Number($("#leftCol" + racerId).text());
            var colRig = Number($("#rightCol" + racerId).text());
            var time = Number($("#time" + racerId).text());

            var sum = (isNaN(snake) ? 0 : snake) + (isNaN(flower) ? 0 : flower) + (isNaN(stop) ? 0 : stop) + (isNaN(hall) ? 0 : hall) + (isNaN(cirLeft) ? 0 : cirLeft) + (isNaN(cirRig) ? 0 : cirRig) + (isNaN(colLeft) ? 0 : colLeft) + (isNaN(colRig) ? 0 : colRig) + (isNaN(time) ? 0 : time);

            $("#sum" + racerId).text(sum);
        }
        getPlaces();
    });

    function sortNumber(a,b) {
        return a - b;
    }

    function getPlaces() {
        var arr = [];
        var count = Number($("#racersCount").val());
        for (var i = 1; i <= count; i++) {
            var racerId = $("#id" + i).val();
            arr.push(Number($("#sum" + racerId).text()));
        }
        arr.sort(sortNumber);
        var tableBarr = $("#tableB").val().replace('[', '').replace(']', '').split(',');
        console.log(tableBarr);
        for (var j = 1; j <= count; j++) {
            var racerId = $("#id" + j).val();
            for (var i = 1; i <= count; i++) {
                var sum = Number($("#sum" + racerId).text());
                if (sum == Number(arr[i-1])) {
                    $("#place" + racerId).text(i);
                    $("#tableB" + racerId).text(tableBarr[i-1]);
                }
            }
        }
        updatePDF();
    }
});
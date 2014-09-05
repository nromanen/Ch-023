$(document).ready(function(){

 //   $('#maneuverTable').DataTable();

    $('body').on('change', 'input.test', function() {
        $(this).val($(this).val().replace(',', '.'));
        var num = Number($(this).val());
        if (validate(num)) {
            var classArr = $(this).attr('class').split(" ");
            var max_allowed_broken_skittles = Number($("#max_skittles").val());
            var loc = classArr[1] + $(this).attr('racer');
            if (num > max_allowed_broken_skittles) {
                $(this).val(max_allowed_broken_skittles);
                num = max_allowed_broken_skittles;
            }
            $("#" + loc).text(num);
        } else {
            $(this).val(0);
        }
    });

    function updatePDF() {
        sorttable.innerSortFunction.apply(document.getElementById('place'), [])
        var idArray = [];
        var timeArray = [];
        $(".timetext").each(function () {
            var id = Number($(this).attr('id').replace('time', ''));
            var time = Number($(this).text());
            idArray.push(id);
            timeArray.push(time);
        });
        var table = $('#maneuver').html();
        table = '<style>' +
            'table {font-size: 14} ' +
            '.position {width: 20px}' +
            '.maneuvers {width: 50px}' +
            '.racername {width: 80px;} ' +
            '.sportcategory {width: 80px;} ' +
            '.teamname {width: 100px;}' +
            '.time {width: 25px;}' +
            '.place {width: 40px}' +
            '</style>' +
            table;
        $.ajax({
            url: "/Carting/SHKP/maneuver",
            type: "POST",
            data: {
                table: table,
                raceId: $("#raceId").val(),
                ids : JSON.stringify(idArray).replace('[','').replace(']',''),
                times: JSON.stringify(timeArray).replace('[','').replace(']','')
            },
            success: function(response) {
                if (response !== 0) {
                    $("#fileId").val(response);
                    $("#pdf").removeAttr("disabled");
                    $("#prevVersion").remove();
                }
            }
        });
    }

    $("#pdf").click(function() {
        window.open("../../document/showFile/" + $("#fileId").val() ,'_blank');
    });

    $('#remove').click(function() {
        var selectedClass = $( "#del").find("option:selected" ).attr('class');
        $('.' + selectedClass).remove();
    });

    $( ".stopLine" ).change(function() {
        var result;
        var penalty = 50;
        if($(this).is(":checked")) {
            result = penalty;
        } else {
            result = 0;
        }
        $("#stopLine" + $(this).attr('racer')).text(result);
    });

    $( ".time" ).change(function() {
        $(this).val($(this).val().replace(',', '.'));
        var num = $(this).val();
        if (validate(num)) {
            $("#time" + $(this).attr('racer')).text(num);
        } else {
            $("#time" + $(this).attr('racer')).text(0);
        }
    });

    $('#save').click(function() {
        $("#pdf").attr("disabled", true);
        for (var i = 1; i <= Number($("#racersCount").val()); i++) {
            var sum = 0;
            var racerId = $("#id" + i).val();
            for (var j = 1; j <= Number($("#maneuverCount").val()); j++) {
                var manId = "#maneuver" + j + racerId;
                var tmpValue = Number($(manId).text()) * Number($("#penalty").val());
                sum = sum + (isNaN(tmpValue) ? 0 : tmpValue);
            }
            var time = Number($("#time" + racerId).text());
            sum = sum + (isNaN(time) ? 0 : time)
            $("#sum" + racerId).text(sum);
        }
        getPlaces();
        updatePDF();
    });

    function validate(number) {
        var intRegex = /^\d+$/;
        var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+))$/;
        return !!(intRegex.test(number) || floatRegex.test(number));
    }

    function sortNumber(a,b) {
        return a - b;
    }

    function getPlaces() {
        var arr = [];
        var racerId;
        var i;
        var count = Number($("#racersCount").val());
        for (i = 1; i <= count; i++) {
            racerId = $("#id" + i).val();
            arr.push(Number($("#sum" + racerId).text()));
        }
        arr.sort(sortNumber);
        var tableBarr = $("#tableB").val().replace('[', '').replace(']', '').split(',');
        for (var j = count; j >= 1; j--) {
            racerId = $("#id" + j).val();
            for (i = count; i >= 1; i--) {
                var sum = Number($("#sum" + racerId).text());
                if (sum == Number(arr[i-1])) {
                    $("#place" + racerId).text(i);
                    $("#tableB" + racerId).text(tableBarr[i-1]);
                }
            }
        }
    }
});
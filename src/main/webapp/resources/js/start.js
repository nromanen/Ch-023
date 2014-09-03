$(document).ready(function(){
    function updatePDF() {
        $.ajax({
            url: "/Carting/SHKP/start",
            type: "POST",
            data: {
                table: $('#table').html(),
                startId: $('#startId').val(),
                raceId: $('#raceId').val()
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

    function clearTable() {
        $(".place").each(function() {
            $(this).text("");
        });
    }

    $("#pdf").click(function() {
        window.open("../../../document/showFile/" + $("#fileId").val() ,'_blank');
    });

    $("#save").click(function() {
        clearTable();
        var arr = [];
        var max = Number($("#maxPos").val());
        var valid = true;
        $(".carPos").each(function() {
            var racerNum = $(this).attr('racer');
            var pos = $(this).val();
            var startPos = ".p" + $(this).val();
            if (pos >=1 && pos <= max) {
                $(startPos).each(function() {
                    $(this).text(racerNum);
                });
            } else {
                valid = false;
            }
            arr.push(pos);
        });
        var sorted_arr = arr.sort();
        for (var i = 0; i < arr.length - 1; i++) {
            if (sorted_arr[i + 1] == sorted_arr[i]) {
                valid = false;
            }
        }

        if (valid == true) {
            $('#correctPositions').css("display", "inline-block").hide().fadeIn();
            $('#correctPositions').delay(2000).fadeOut('slow');
            updatePDF();
        } else {
            $('#incorrectPositions').css("display", "inline-block").hide().fadeIn();
            $('#incorrectPositions').delay(2000).fadeOut('slow');
        }
    });

    var s = Number($("#qual_count").val());
    if (s > 0) {
        $("#save").click()
    }
});
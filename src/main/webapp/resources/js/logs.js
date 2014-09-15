/**
 * Created by manson on 11.09.14.
 */
$(document).ready( function () {
    $('#logsTable').DataTable();

    $('form').bootstrapValidator({
        fields: {
            'year': {
                validators: {
                    notEmpty: {
                    },
                    regexp: {
                        regexp: /^\d{4}$/
                    }
                }
            },
            'date': {
                validators: {
                    notEmpty: {
                    },
                    regexp: {
                        regexp: /^\d{2}$/
                    }
                }
            }
        }
    });

    function getValidString(year, month, day) {
        var result = year;
        var time = '00:00:00.0'
        if (Number(month) >= 1 && Number(month) <= 12) {
            result += '-' + month;
        } else {
            return false;
        }
        if (Number(day) >= 1 && Number(day) <= 12) {
            result += '-' + day;
        } else {
            return false;
        }
        result += ' ' + time;
        return result;
    }

    $('#submit').click(function() {
        var valid = true;
        var start;
        var end;
        var tmp = getValidString($('#starty').val(), $('#startm').val(), $('#startd').val());
        if (tmp != false) {
            start = tmp;
        } else {
            valid = false;
        }
        var end;
        tmp = getValidString($('#endy').val(), $('#endm').val(), $('#endd').val());
        if (tmp != false) {
            end = tmp;
        } else {
            valid = false;
        }
        if (valid) {
            window.location.href = 'search?start=' + start  + '&end=' + end;
        }
    });
});
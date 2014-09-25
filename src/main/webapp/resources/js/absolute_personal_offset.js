$(document).ready(function(){
	$('.table').tablesorter(); 
    $(".pdf").click(function() {
    	var id = this.id.replace("pdf", "");
    	var url = $('#personal_url').val();
    	var table = $('#table_personal_offset' + id).html();
    	if (table.indexOf('qualifying') == -1) {
    		$('.th_hidden').attr('colspan', function(){
    			return +$(this).attr('colspan') - 2;
    		});
    		table = $('#table_personal_offset' + id).html();
    		$('.th_hidden').attr('colspan', function(){
    			return +$(this).attr('colspan') + 2;
    		});
    	} 
    	table = "<style>table{ font-size: 12;} .column-wide {width: 100px;} .column-mid {width: 120px;} .column-md {width: 45px;} .column-sm {width: 20px;} a{color: #000000; cursor: text; text-decoration: none} .hidden {height: 30px;}</style>" + table;
    	$.ajax({
            url: url,
            type: "POST",
            data: {
                table: table,
                carClassCompetitionId: id
            },
            success: function(response) {
                if (response !== '0') {
                	$('#table_personal_offset' + id).css("font-size","14 !important");
                	window.open("../../document/showFile/" + response ,'_blank');
                }
            }
        });
    });
});
$(document).ready(function(){
	$('.table').tablesorter(); 
    $(".pdf").click(function() {
    	var id = this.id.replace("pdf", "");
    	var url = $('#personal_url').val();
    	if (!$('.qualifying')[0]) {
    		$('.th_hidden').attr('colspan', function(){
    			return +$(this).attr('colspan') - 2;
    		});
    	} 
    	var table = $('#table_personal_offset' + id).html();
    	table = "<style>table{ font-size: 14;} .column-wide {width: 110px;} .column-md {width: 41px;} .column-sm {width: 20px;} a{color: #000000; cursor: text; text-decoration: none} .hidden {height: 30px;}</style>" + table;
    	if (!$('.qualifying')[0]) {
    		$('.th_hidden').attr('colspan', function(){
    			return +$(this).attr('colspan') + 2;
    		});
    	} 
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
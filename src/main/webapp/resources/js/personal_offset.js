$(document).ready(function(){
	$('.table').tablesorter(); 
    $(".pdf").click(function() {
    	var id = this.id.replace("pdf", "");
    	var url = $('#personal_url').val();
    	var table = $('#table_personal_offset' + id).html();
    	table = "<style>table{ font-size: 14;} .column-wide {width: 130px;} .column-sm {width: 20px;} a{color: #000000; cursor: text; text-decoration: none}</style>" + table;
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
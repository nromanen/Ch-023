$(document).ready(function(){
	
	function updatePDF() {
        var table = $('#absRanking').html();
        table = '<style>' +
            'table {font-size: 14} ' +
            ' a{color: #000000; cursor: text; text-decoration: none}' +
            'td,th {padding: 5px}' +
            '.pos {width: 20px}' +
            '.team_name {width: 500px}' +
            '.points {width: 60px}' +
            '.place {width: 60px}' +
            '</style>' +
            table;
        $.ajax({
            url: "/Carting/competition/absRanking",
            type: "POST",
            data: {
                table: table,
                competitionId: $("#competitionId").val(),
            },
            success: function(response) {
                if (response !== 0) {
                    $("#fileId").val(response);
                    window.open("../../document/showFile/" + $("#fileId").val() ,'_blank');
                }
            }
        });
    }
	
	 $("#pdf").click(function() {
		 updatePDF();
	    });
	 
	 $('.main_table').tablesorter(); 
})
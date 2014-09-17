$(document).ready(function(){
	
	function updatePDF() {
        var table = $('#absRanking').html();
        table = '<style>' +
            'table {font-size: 14} ' +
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
	 
	 $('.table').tablesorter(); 
})
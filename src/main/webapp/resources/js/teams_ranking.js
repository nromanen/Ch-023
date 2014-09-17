$(document).ready(function(){
	
	function updatePDF() {
        var table = $('#absRanking').html();
        /*table = '<style>' +
            'table {font-size: 14} ' +
            '.position {width: 20px}' +
            '.maneuvers {width: 50px}' +
            '.racername {width: 80px;} ' +
            '.sportcategory {width: 80px;} ' +
            '.teamname {width: 100px;}' +
            '.time {width: 25px;}' +
            '.place {width: 40px}' +
            '</style>' +
            table;*/
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
                }
            }
        });
    }
	
	 $("#pdf").click(function() {
		 updatePDF();
	        window.open("../../document/showFile/" + $("#fileId").val() ,'_blank');
	    });
})
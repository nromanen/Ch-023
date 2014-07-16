$(document).ready(function() {

	/*Page for choosing type of document*/
	$('#select_document_type_modal').modal();

	$('#select_document_type_modal').on('hidden.bs.modal', function(e) {
		history.go(-1);
	});
	
});
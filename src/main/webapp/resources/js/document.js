$(document).ready(function() {
	
	// Setup validator

	if ($('#addDocument').length != 0) {
		$('#addDocument').bootstrapValidator();
	}
	
	// Display ajax loader image if form pass validation
	$('#addDocument').on('success.form.bv', function(e) {
		$("#ajax_loader").css("display", "inline-block");
	});
	
	// reValidate the date when user change it  
	$('#doc_date_picker').on('changeDate', function(e) {

		var name = $('#doc_date_picker').attr('name')
		$('#addDocument').bootstrapValidator('revalidateField', name); 
		$('#doc_date_picker').datepicker('hide');
    });
	
	$('#addFile').click(function() {		
		var count = document.getElementsByClassName('file').length+parseInt($('#fileCount').val());
		if(count<3){
			$('#fileTable').append(
					'<tr><td><div class="form-group">'+
					'<input type="file" name="file" onchange="return ValidateFileUpload(this)" class="form-control file"/>'+
					'</div></td></tr>');
		} else {
			$('#max_count_achieved').css("display", "inline-block").hide().fadeIn();
			$('#max_count_achieved').delay(2000).fadeOut('slow');
		}
	});

	if ($('.datepicker').length != 0) {
		$('.datepicker').datepicker({
			format : 'yyyy-mm-dd',
			todayBtn : 'linked',
		// language: 'ua'
		});
		
		$(".datepicker").keydown(function(){
			return false;
		});
	}
	
	$('#approved_radio').change(function(){
		var document_id = $('#document_id').val();
		var json = {"documentId" : document_id };		
		$.ajax({
			url: $("#approved_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				window.location.reload();
			}
		});
	});
	
	
	$('#unapproved_radio').change(function(){
		$('#unapproved_modal').modal();
	});
	
	$('#unapproved').click(function(){
		var reason = $('#reason').val();
		if (reason.length == 0 || reason.length>255)
		{
			$("#unapproved").css("display", "none");
		}
		else{
			$("#unapproved").css("display", "inline");
			$("#ajax_loader_delete").css("display", "inline");
			var document_id = $('#document_id').val();
			
			var json = {"documentId" : document_id, "reason" : reason };		
			$.ajax({
				url: $("#unapproved_url").val(),
				data: JSON.stringify(json),
				contentType: 'application/json',
				type: "POST",
				success: function(response) {
					window.location.reload();
					$("#ajax_loader_delete").css("display", "none");
				}
			});
		}
		
	});	
	
	$('#reason').change(function(){
		var reason = $('#reason').val();
		if (reason.length == 0 || reason.length>255)
		{
			$("#unapproved").css("display", "none");
		}
		else{
			$("#unapproved").css("display", "inline");			
		}	
	});
	
	$('#delete_document_btn').click(function(){
		$('#delete_document_modal').modal();
	});
	
	$('#delete_document').click(function(){
		$("#ajax_loader_delete").css("display", "block");

		var document_delete_id = $('#document_delete_id').val();
		var document_type = $('#document_type').val();
		var racers_id_string = "";
		$(".racer_id").each(function (i){
			racers_id_string += $(this).val() + "#";
		});
		var team_id = $('#team_id').val();
		var json = { "document_id" : document_delete_id, "racers_id_string" : racers_id_string,
				"document_type" : document_type };

		$.ajax({
			url: $("#document_delete_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				$("#ajax_loader_delete").css("display", "none");
				$('#delete_document_modal').modal('hide');
				$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/team/'+team_id);
			}
		});
		return false;
	});
	
	$('.delete_file_btn').click(function(){
		$('#delete_file_modal').modal();
	});	
	
	$('#delete_file').click(function(){
		var fileId = $(this).attr('id');
		var json = { "fileId" : fileId };
		$.ajax({
			url: $("#file_delete_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				window.location.reload();
			}
		});
	});

});
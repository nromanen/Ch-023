$(document).ready(function(){
		
	$('#feedback_form').submit(function(){
		$("#ajax_loader").css("display", "inline-block");
		var url = $("#feedback_form").attr("action");
		var json = { "from" : $('#from').val(),
					 "subject" : $('#subject').val(),
					 "message" : $('#message').val() };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader").css("display", "none");
	        	if(response == "success"){
					$('#feedback_success').css("display", "block").hide().fadeIn();
					$('#feedback_success').delay(2000).fadeOut('slow');
					$('#feedback_form').each(function(){ 
						this.reset();
					});
	        	} else {
					$('#feedback_error').css("display", "block").hide().fadeIn();
					//$('#feedback_error').delay(2000).fadeOut('slow');
	        	}
	        }
	    });
		return false;
	});
	
});
$(document).ready(function(){
	var email;
	var secureCode;
	
	$('#send_secure_code_btn').click(function(e){
		e.preventDefault();
		email = $('#email').val();
		var json = {"email" : email};
		$.ajax({
			url: $("#send_secure_code_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					$('#user_not_exist').css("display", "none");
					$('#email').attr("disabled", "disabled");
					$('#send_secure_code_btn').attr("disabled", "disabled");
					$('#step_2').delay(2000).fadeIn();
				}
				else {
					$('#user_not_exist').css("display", "block");
				}
			}
		});
	});
	
	$('#secure_code_btn').click(function(e){
		e.preventDefault();
		secureCode = $('#secure_code').val();
		var json = {"email" : email, "secureCode" : secureCode };
		$.ajax({
			url: $("#check_secure_code_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					$('#wrong_secure_code').css("display", "none");
					$('#secure_code').attr("disabled", "disabled");
					$('#secure_code_btn').attr("disabled", "disabled");
					$('#step_3').delay(2000).fadeIn();
				}
				else {
					$('#wrong_secure_code').css("display", "block");
				}
			}
		});
	});
	
	$('#change_password').click(function(e){
		e.preventDefault();
		password = $('#password').val();
		var json = {"email" : email, "secureCode" : secureCode, "password" : password };
		$.ajax({
			url: $("#change_password_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/loginPage');
				}
			}
		});
	});
	
		
});
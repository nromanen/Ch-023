$(document).ready(function(){	
	
	$('#send_secure_code_btn').click(function(){
		var email = $('#email').val();
		var json = {"email" : email};
		$.ajax({
			url: $("#send_secure_code_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					console.log('good');
				}
				else {
					console.log("bad");
				}
			}
		});
	});
	
	$('#secure_code_btn').click(function(){
		var email = $('#email').val();
		var secureCode = $('#secure_code').val();
		var json = {"email" : email, "secureCode" : secureCode };
		$.ajax({
			url: $("#check_secure_code_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					console.log('good');
				}
				else {
					console.log("bad");
				}
			}
		});
	});
	
	$('#change_password').click(function(){
		var email = $('#email').val();
		var secureCode = $('#secure_code').val();
		var password = $('#password').val();
		var json = {"email" : email, "secureCode" : secureCode, "password" : password };
		$.ajax({
			url: $("#change_password_url").val(),
			data: JSON.stringify(json),
			contentType: 'application/json',
			type: "POST",
			success: function(response) {
				if (response == "success") {
					console.log('good');
				}
				else {
					console.log("bad");
				}
			}
		});
	});
	
		
});
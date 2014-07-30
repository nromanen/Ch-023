$(document).ready(function(){	
	
	$('#edit_leader').submit(function(){
       $("#ajax_loader").css("display", "inline-block");
       var id = $('#id').val();
       var firstName = $('#first_name').val();
       var lastName = $('#last_name').val();
       var birthday = $('#birthday').val();
       var document = $('#document').val();
       var address = $('#address').val();
       var license = $('#license').val();
       var json = {"id" : id, "firstName" : firstName, "lastName" : lastName,
    	        	"birthday" : birthday, "document" : document, 
    	        	"address" : address, "license" : license
    	        	};
       $.ajax({
        	url: $("#edit_leader").attr( "action"),
        	data: JSON.stringify(json),
        	contentType: 'application/json',
        	type: "POST",
        	success: function(response) {
        	   $("#ajax_loader").css("display", "none");
        	   $(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/leader/' + response);
        	}
       });

       return false;
    });
	
	$("#change_pass_btn").click(function(){	
		$('#change_password_modal').modal();
	});
	
	$("#change_password_form").submit(function(){
		$("#ajax_loader_change_password").css("display", "block");
		$("#old_password_error").css("display", "none");
		var old_password = $("#old_password").val();
		var new_password = $("#new_password").val();
		if((old_password != "") && (new_password != "")){
			var url = $(this).attr("action");
			var json = { "oldPassword" : old_password, "newPassword" : new_password };
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	$("#ajax_loader_change_password").css("display", "none");
		        	if(response == "success"){		        		
		        		$('#change_password_modal').modal('hide');
		        		bootbox.alert($("#change_password_success").val());
		        	} else {
		        		$("#old_password_error").css("display", "block");
		        	}
		        }
		    });
		}
		return false;
	});
			
	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd',
        todayBtn: 'linked',
        language: $('#locale').val()
	});
	
	$(".datepicker").keydown(function(){
		return false;
	});
	
	Date.prototype.yyyymmdd = function() {               
        var yyyy = this.getFullYear().toString();                                    
        var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based         
        var dd  = this.getDate().toString();                                        
        return yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);
	};  

	$('#new_leader').submit(function(){
		$("#ajax_loader").css("display", "inline-block");		
    		
		var first_name = $('#first_name').val();
	    var last_name = $('#last_name').val();
	    var birthday = $('#birthday').val();
	    var document = $('#document').val();
	    var address = $('#address').val();
	    var license = $('#license').val();
	    var username = $('#username').val();
	    var password = $('#password').val();
	    
	    var json = { 
	    			 "firstName" : first_name, 
	    			 "lastName" : last_name,
	    			 "birthday" : birthday, 
	    			 "document" : document, 
	    			 "address" : address, 
	    			 "license" : license,
	    			 "username" : username,
	    			 "password" : password
	    		   };

	    var jsonCheck = {"username" : username};
	    var urlCheck = window.location.protocol + "//" + window.location.host + '/Carting/leader/isSetUser';
	    $.ajax({  
	        url: urlCheck,  
	        data: JSON.stringify(jsonCheck),  
	        contentType: 'application/json',
	        type: "POST",	        
	        success: function(response) {  
	        	if(response == false){
				    $.ajax({  
				        url: $("#new_leader").attr("action"),  
				        data: JSON.stringify(json),  
				        contentType: 'application/json',
				        type: "POST",
				        success: function(response) {  
				        	$("#ajax_loader").css("display", "none");
				        	if(response){
				        		bootbox.alert($("#error_encoding_passwords").val());
				        		$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/loginPage');
				        	} else {
				        		bootbox.alert($("#error_encoding_passwords").val());
				    		}
				        } 
				    });   
	        	}
	    	    else {
	        		$("#ajax_loader").css("display", "none");
	        		$("#user_exists").css("display", "block");
	        	}
	        }

	    });
		return false;
	});
	
	$(function () { $("input,select,textarea").not("[type=submit]").jqBootstrapValidation(); } );

	//set datepickers start and end date
	$('#birthday').datepicker('setEndDate', (new Date()).yyyymmdd());
	
	$('#birthday').on('changeDate', function() {
		$(this).datepicker('hide');
	});
		
});
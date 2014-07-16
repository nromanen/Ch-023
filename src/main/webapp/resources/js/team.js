$(document).ready(function(){
		
	/*bootbox.alert("Hello world!");*/
	
	$('#new_team').submit(function(){
		$("#ajax_loader").css("display", "inline-block");
		
		var team_name = $('#team_name').val();
		var license = $('#license').val();
	    
	    var jsonCheck = {"team_name" : team_name};
	    var urlCheck = window.location.protocol + "//" + window.location.host + '/Carting/team/isSetTeam';
	    $.ajax({  
	        url: urlCheck,  
	        data: JSON.stringify(jsonCheck),  
	        contentType: 'application/json',
	        type: "POST",	        
	        success: function(response) {  
	        	if(response == false){
	        		
	        		var address = $('#address').val();	        			    
	        	    var json = { 
	        	    			 "team_name" : team_name,
	        	    			 "address" : address,
	        	    			 "license" : license
	        	    		   };
				    $.ajax({  
				        url: $("#new_team").attr("action"),  
				        data: JSON.stringify(json),  
				        contentType: 'application/json',
				        type: "POST",
				        success: function(response) {  
			        	$("#ajax_loader").css("display", "none");
			        	$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/team/'+response);
				        } 
				    });   
	        	}
	    	    else {
	        		$("#ajax_loader").css("display", "none");
	        		$("#team_exists").css("display", "block");
	        	}
	        }

	    });
		return false;
	});
	
	$('#edit_team').submit(function(){
		$("#ajax_loader").css("display", "inline-block");
		
		var team_id = $('#team_id').val();
		var team_name = $('#team_name').val();
	    var address = $('#address').val();
	    var license = $('#license').val();
	    
	    var json = { 
	    			 "team_id" : team_id,
	    			 "team_name" : team_name,
	    			 "address" : address,
	    			 "license" : license
	    		   };
	    $.ajax({  
	        url: $("#edit_team").attr("action"),  
	        data: JSON.stringify(json),  
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {  
	        	$("#ajax_loader").css("display", "none");
	        	$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/team/'+response);
	        } 
	    });   
		return false;
	});
	
	$('#delete_team_btn').click(function(){
		$("#delete_error").css("display", "none");
		$('#delete_team_modal').modal();
	});
	
	$('#delete_team').click(function(){
		$("#ajax_loader_delete").css("display", "block");
	    
		var team_delete_id = $('#team_delete_id').val();
	    var json = { "id" : team_delete_id };
		$.ajax({
	        url: $("#team_delete_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_delete").css("display", "none");
	        	if(response == "success"){		        	
		        	$('#delete_team_modal').modal('hide');
		        	var redirect_url = $("#delete_redirec_url").val();
		        	$(location).attr('href', redirect_url);
	        	} else {
	        		$("#delete_error").css("display", "block");
	        	}	        	
	        }
	    });
		return false;
	});
	
	$('.enabled').change(function(){
		var enabled = $(this).prop('checked');
		var racer_id = $(this).attr('id').replace('enabled', '');
		var json = { "enabled" : enabled, "racerId" : racer_id };
		$.ajax({
	        url: $("#enable_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	if(response != "success"){
	        		alert("Error");
	        	}
	        }
	    });
	});
		
	$(function () { $("input,select,textarea").not("[type=submit]").jqBootstrapValidation(); } );
	
/*	$("#password").change(function(){
		if($("#password2").val() != ''){
			if($("#password").val() == $("#password2").val()){
				$("#password_error").css("display", "none");
			}
			else{
				$("#password_error").css("display", "block");
			}
		}
		
	});
	
	$("#password2").change(function(){
		if($("#password").val() != ''){
			if($("#password").val() == $("#password2").val()){
				$("#password_error").css("display", "none");
			}
			else{
				$("#password_error").css("display", "block");
			}
		}
		
	});*/
	
	$('#add_team').click(function(){
		  if($("#password").val() != $("#password2").val()){
		   return false;
		  }
		 });
});
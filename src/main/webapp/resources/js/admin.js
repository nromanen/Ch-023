$(document).ready(function(){

	$('#add_car_class_form').bootstrapValidator();
	$('#edit_car_class_form').bootstrapValidator();

	$('#createDump').click(function(){
		fileProcessing("createDump", true);
	});

	$('#saveAllFiles').click(function(){
		fileProcessing("downloadFiles", false);
	});

	/*$('#importDump').click(function(){
		$("#loading").css("display", "block");
		$.ajax({
			url: "getDump",
			type: "POST",
			success: function(response) {
				if(response == "success") {
					$("#loading").css("display", "none");
					$('#success').css("display", "inline-block").hide().fadeIn();
					$('#success').delay(1000).fadeOut('slow');
				} else {
					$("#loading").css("display", "none");
					$('#fail').css("display", "inline-block").hide().fadeIn();
					$('#fail').delay(1000).fadeOut('slow');
				}
				document.location.href = response;
			}
		});
	});*/

	function fileProcessing(url, dump) {
		$("#loading").css("display", "block");
		$.ajax({
			url: url,
			type: "POST",
			success: function(response) {
				if(response == "success") {
					$("#loading").css("display", "none");
					$('#success').css("display", "inline-block").hide().fadeIn();
					$('#success').delay(1000).fadeOut('slow');
					if (dump) {
						document.location.href = "/Carting/resources/documents/sql/dump.sql";
					}
				} else {
					$("#loading").css("display", "none");
					$('#fail').css("display", "inline-block").hide().fadeIn();
					$('#fail').delay(1000).fadeOut('slow');
				}
			}
		});
	}

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
	
	$('#add_carclass_btn').click(function(){
		$('#add_carclass_modal').modal();
		return false;
	});

	$('#add_maneuver').click(function(){
		$('#add_maneuver_modal').modal();
		return false;
	});
	
	$("#add_car_class_form").submit(function(){
		$('#age_error').css("display","none");
		var lowerYearsLimit = +$('#lower_years_limit').val();
		var upperYearsLimit = +$('#upper_years_limit').val();
		if ((lowerYearsLimit==0)&&(upperYearsLimit==0)) {
			return false;
		} else
		if (lowerYearsLimit > upperYearsLimit) {
			$('#age_error').css("display","block");
			return false;
		}
		else {
			$("#ajax_loader_add_carclass").css("display", "block");
			var url = $("#add_car_class_form").attr("action");
			var json = { "name" : $('#name').val(),
						 "lowerYearsLimit" : $('#lower_years_limit').val(),
						 "upperYearsLimit" : $('#upper_years_limit').val() };
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	$("#ajax_loader_add_carclass").css("display", "none");
		        	$('#add_carclass_modal').modal('hide');
		        	location.reload();
		        }
		    });
			return false;
		}
		
	});
	
	$('.edit_carclass_btn').click(function(){
		var id = $(this).attr("id").replace("edit", "");
		var name = $('#carClassName' + id).html();
		var lower_years_limit = $('#lowerYearsLimit' + id).html();
		var upper_years_limit = $('#upperYearsLimit' + id).html();
		
		$('#id_edit').val(id);
		$('#name_edit').val(jQuery.trim(name));
		$('#lower_years_limit_edit').val(jQuery.trim(lower_years_limit));
		$('#upper_years_limit_edit').val(jQuery.trim(upper_years_limit));

		$('#edit_carclass_modal').modal();
		
		return false;
		
	});
	
	$("#edit_car_class_form").submit(function(){
		$('#age_error_edit').css("display","none");
		var lowerYearsLimit = +$('#lower_years_limit_edit').val();
		var upperYearsLimit = +$('#upper_years_limit_edit').val();
		if (lowerYearsLimit > upperYearsLimit) {
			$('#age_error_edit').css("display","block");
			return false;
		}
		else {
			$("#ajax_loader_edit_carclass").css("display", "block");		
			var url = $("#edit_car_class_form").attr("action");
			var json = { "id" : $('#id_edit').val(),
						 "name" : $('#name_edit').val(),
						 "lowerYearsLimit" : $('#lower_years_limit_edit').val(),
						 "upperYearsLimit" : $('#upper_years_limit_edit').val() };
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	$("#ajax_loader_edit_carclass").css("display", "none");
		        	$('#edit_carclass_modal').modal('hide');
		        	location.reload();
		        }
		    });
			return false;
		}
	});
	
	function numberTest(value){
		return /^-?\d+$/.test(value);
	}

	function ageTest(value) {
		return /^[1-9]{1}\d{0,1}$/.test(value);
	}
	
	$("#perental_permission_years").keyup(function () {
		if(!ageTest($(this).val())){ 
			$(this).val("");
			$("#change_perental_permission_years_btn").attr("disabled", "disabled");
		} else {
			$("#change_perental_permission_years_btn").removeAttr("disabled");
		}
	});

	$(".points").keyup(function () {
		var valid = validPoints();

		if (valid) {
			$("#edit_place").removeAttr("disabled");
		} else {
			$("#edit_place").attr("disabled", "disabled");
		}

	});	

	function validPoints() {
		var valid = true;
		$(".points").each(function (i){
			var points = $(this).val();
			if(!numberTest(points)) {
				valid = false;
			}
		});	
		return valid;		
	}

	$("#change_perental_permission_years_btn").click(function(){
		var url = $("#change_perental_permission_years_url").val();
		var json = { "perentalPermissionYears" : $('#perental_permission_years').val() };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	if(response == "success"){
					$('#change_perental_permission_years_success').css("display", "inline-block").hide().fadeIn();
					$('#change_perental_permission_years_success').delay(2000).fadeOut('slow');
	        	} else {
					$('#change_perental_permission_years_error').css("display", "inline-block").hide().fadeIn();
					$('#change_perental_permission_years_error').delay(2000).fadeOut('slow');
	        	}
	        }
	    });
		return false;
	});
	
	function getPointsString(){
		var pointsStr = "";
		var first = true;
		$(".points").each(function (i){
			var points = $(this).val();
			if(first){
				pointsStr += points;
				first = false;
			} else {
				pointsStr += ",";
				pointsStr += points;
			}			
		});	
		return pointsStr;
	}
	
	function editPointsByPlaces(pointsStr){
		var url = $("#admin_url").val() + "/changePointsByPlaces";
		var json = { "pointsByPlaces" : pointsStr };	
		if (validPoints()) {
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	if(response == "success"){
		        		$('#edit_place_success').css("display", "block").hide().fadeIn();
						$('#edit_place_success').delay(2000).fadeOut('slow');
						location.reload();
		        	} else {
		        		$('#edit_place_error').css("display", "block").hide().fadeIn();
						$('#edit_place_error').delay(2000).fadeOut('slow');
		        	}
		        }
		    });	
		} else {
    		$('#edit_place_error').css("display", "block").hide().fadeIn();
			$('#edit_place_error').delay(2000).fadeOut('slow');			
		}
	}

	$('.delete_carclass_btn').click(function(){
		$('#carclass_delete_id').val($(this).attr("id").replace("delete", ""));
		$('#carclass_delete_modal').modal();
		return false;
	});

	$("#carclass_delete_confirm").click(function(){
		var id = $('#carclass_delete_id').val();
		var url = $("#admin_url").val() + "/deleteCarClass";
		var json = { "id" : id };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	if (response === "success") {
					location.reload().delay(2000);
	        	} else {
	        		console.log(response);
		    		$('#delete_place_error').css("display", "block").hide().fadeIn();
					$('#delete_place_error').delay(2000).fadeOut('slow');	
	        	}
	        }
	    });
	    $('#carclass_delete_modal').modal('hide');
		return false;
	});
	
	$("#edit_place").click(function(){
		var pointsStr = getPointsString();
		editPointsByPlaces(pointsStr);
	});
	
	$("#delete_place").click(function(){
		if($('#points_table tr').length > 1){
			$('#points_table tr:last').remove();
		}
		var pointsStr = getPointsString();
		editPointsByPlaces(pointsStr);
	});
	
	$("#add_place").click(function(){
		$('#add_place_modal').modal();
	});

	$("#points_count").keyup(function () {
		if(!numberTest($(this).val())){
			$("#add_place_btn").attr("disabled", "disabled");
		} else {
			$("#add_place_btn").removeAttr("disabled");
		}
	});

	$(".delete_maneuver").click(function () {
        $.ajax({
            url: "deleteManeuver",
            data: {
                id: $(this).attr("maneuver")
            },
            type: "POST",
            success: function(response) {
                if (response === "success") {
                    location.reload();
                } else {
                    console.log(response);
                    $('#delete_place_error').css("display", "block").hide().fadeIn();
                    $('#delete_place_error').delay(2000).fadeOut('slow');
                }
            }
        });
	});

    $("#new_maneuver").keyup(function () {
        if($(this).val().length <= 0){
            $("#add_maneuver_btn").attr("disabled", "disabled");
        } else {
            $("#add_maneuver_btn").removeAttr("disabled");
        }
    });

    $("#edit_maneuver").click(function(){
        var json = [];
        $(".man").each(function () {
            var id = $(this).attr("maneuverId");
            var name = $(this).val();
            json.push({id: id, name: name});
        });
        $.ajax({
            url: "/Carting/admin/updateManeuver",
            data: JSON.stringify(json),
            contentType: 'application/json',
            type: "POST",
            success: function(response) {
                if(response == "success"){
                    $('#change_feedback_email_success').css("display", "inline-block").hide().fadeIn();
                    $('#change_feedback_email_success').delay(2000).fadeOut('slow');
                } else {
                    $('#change_feedback_email_error').css("display", "inline-block").hide().fadeIn();
                    $('#change_feedback_email_error').delay(2000).fadeOut('slow');
                }
            }
        });

    });

	$("#add_maneuver_btn").click(function(){
        $.ajax({
            url: "addManeuver",
            data: {
                maneuverName: $("#new_maneuver").val()
            },
            type: "POST",
            success: function(response) {
                if (response === "success") {
                    location.reload();
                } else {
                    console.log(response);
                    $('#delete_place_error').css("display", "block").hide().fadeIn();
                    $('#delete_place_error').delay(2000).fadeOut('slow');
                }
            }
        });
	});

	
	$("#add_place_btn").click(function(){
		var pointsStr = getPointsString();
		pointsStr += ",";
		pointsStr += $("#points_count").val();
		editPointsByPlaces(pointsStr);
	});
	
	$("#change_feedback_email_form").submit(function(){
		var url = $("#change_feedback_email_form").attr("action");
		var json = { "feedbackEmail" : $('#feedback_email').val() };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	if(response == "success"){
					$('#change_feedback_email_success').css("display", "inline-block").hide().fadeIn();
					$('#change_feedback_email_success').delay(2000).fadeOut('slow');
	        	} else {
					$('#change_feedback_email_error').css("display", "inline-block").hide().fadeIn();
					$('#change_feedback_email_error').delay(2000).fadeOut('slow');
	        	}
	        }
	    });
		return false;
	});
		
	$.fn.bootstrapSwitch.defaults.size = 'mini';
	$.fn.bootstrapSwitch.defaults.onColor = 'success';
	$.fn.bootstrapSwitch.defaults.offColor = 'danger';
	$(".enabled").bootstrapSwitch();	
	$('.enabled').on('switchChange.bootstrapSwitch', function(event, state) {
		var enabled = state;
		var username = $(this).attr("id");
		var json = { "enabled" : enabled, "username" : username };
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
	
	$('.delete_leader_btn').click(function(){
		$("#leader_has_team").css("display", "none");
		var leader_id = $(this).attr("id").replace("delete", "");
		var leader_name = $('#name' + leader_id).html();
		$('#leader_delete_id').val(leader_id);
		$('#leader_delete_name').html('"' + leader_name + '"');
		$('#delete_leader_modal').modal();
		return false;
	});
	
	$('#delete_leader').click(function(){		
		$("#ajax_loader_delete_leader").css("display", "block");
		var leader_delete_id = $('#leader_delete_id').val();
	    var json = { "id" : leader_delete_id };
		$.ajax({
	        url: $("#leader_delete_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_delete_leader").css("display", "none");
	        	if(response == "success"){
		        	$('#delete_leader_modal').modal('hide');
		        	location.reload();
	        	} else {
	        		$("#leader_has_team").css("display", "block");
	        	}

	        }
	    });
		return false;
	});
	
	$('.reset_pass_btn').click(function(){
		var leader_id = $(this).attr("id").replace("reset", "");
		var leader_name = $('#name' + leader_id).html();
		$('#reset_pass_leader_id').val(leader_id);
		$('#reset_pass_leader_name').html('"' + leader_name + '"');
		$('#reset_pass_modal').modal();
		return false;
	});
	
	$('#reset_pass').click(function(){		
		$("#ajax_loader_reset_pass").css("display", "block");
		var reset_pass_leader_id = $('#reset_pass_leader_id').val();
	    var json = { "id" : reset_pass_leader_id };
		$.ajax({
	        url: $("#reset_pass_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_reset_pass").css("display", "none");
	        	if(response == "success"){
		        	$('#reset_pass_modal').modal('hide');
		        	bootbox.alert($("#reset_password_success").val());
	        	} else {
	        		bootbox.alert("Error");
	        	}

	        }
	    });
		return false;
	});
	
});
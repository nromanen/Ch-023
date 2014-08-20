$(document).ready(function(){

	function teamFilter(table_id, team_id) {
		var del_count = 0;
		$('#' + table_id + ' tbody tr').each(function(){				
			if(!$(this).hasClass(team_id)){
		    	del_count++;
		    	$(this).fadeOut(200, function() {
		    		$(this).hide();		    		
		    	});
		    }
		});	
		return del_count;
	}
	
	var table_id = "racers_table";
	
	$("#my_team").click(function(){
		$("#all_teams").removeClass("active");
		$(this).addClass("active");
		$("#no_racers").css("display", "none");		
		var team_id = $("#team_id").val();
		var del_count = teamFilter(table_id, team_id);
		if(del_count == $("#" + table_id + " tbody tr").length){
			$("#no_racers").css("display", "block");
		}	
		return false;
	});
	
	$("#all_teams").click(function(){
		$("#my_team").removeClass("active");
		$(this).addClass("active");
		$("#no_racers").css("display", "none");
		$("#" + table_id + " tr").show();
		return false;
	});
	
	$(".unreg_racer_btn").click(function(){
		$("#unreg_error").css("display", "none");
		var racer_id = $(this).attr("id").replace("unreg", "");
		var racer_name = $("#racer" + racer_id).html().trim();
		$("#unreg_racer_id").val(racer_id);
		$("#racer_name").html(racer_name);
		$('#unreg_racer_modal').modal();
		return false;
	});
	
	$("#unreg_racer").click(function(){
		$("#ajax_loader_unreg").css("display", "block");

		var racer_id = $('#unreg_racer_id').val();
		var url = $("#unreg_racer_url").val();
	    var json = { "racerId" : racer_id };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_unreg").css("display", "none");
	        	if(response == "success"){
		        	$('#unreg_racer_modal').modal('hide');
		        	location.reload();
	        	} else {
	        		$("#unreg_error").css("display", "block");
	        	}       	
	        }
	    });
		return false;
	});
	
	$("#reg_racer_btn").click(function(){
		$('#reg_racer_modal').modal();
		return false;
	});
	
	$("#reg_racer_id").change(function(){
		$("#ajax_loader_reg").css("display", "block");
		var racer_id = $(this).val();
		var carclass_id = $("#reg_racer_carclass_id").val();
		var url = $("#reg_racer_get_number_url").val();
		var json = { "racerId" : racer_id, "carClassId" : carclass_id };
		if(racer_id != ""){
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	$("#ajax_loader_reg").css("display", "none");
		        	$("#reg_racer_number").val(response);
		        }
		    });
		} else {
			$("#reg_racer_number").val("");
		}
	});
	
	$("#reg_racer").click(function(){
		if(($("#reg_racer_id").val() != "") && ($("#reg_racer_number").val() != "")){
			$("#reg_racer_empty").css("display", "none");
			$("#ajax_loader_reg").css("display", "block");
			var racer_id = $("#reg_racer_id").val();
			var number = $("#reg_racer_number").val();
			var json = { "racerId" : racer_id, "number" : number };
			var url = $("#reg_racer_url").val();
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        success: function(response) {
		        	$("#ajax_loader_reg").css("display", "none");
		        	$('#reg_racer_modal').modal('hide');
		        	location.reload();
		        }
		    });
		} else {
			$("#reg_racer_empty").css("display", "block");
		}
		return false;
	});

	$('a[href^=#race]').click(function(e){
	    e.preventDefault();
	    $(this).parent().parent().next().slideToggle();
	});
	
	$('.calculateByTableB').change(function(){
		var calculate_by_table_b = $(this).prop('checked');
		console.log(calculate_by_table_b + " " + $("#calculateByTableB_url").val());
		var json = { "calculateByTableB" : calculate_by_table_b };
		$.ajax({
	        url: $("#calculateByTableB_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	if(response != "success"){
	        		alert("Error");
	        	}
	        	else {
	        		location.reload();
	        	}
	        }
	    });
	});
	if ($('#testRace').length != 0) {
	$('#testRace').bootstrapValidator();
	}
	
	
});
$(document).ready(function() {
	$('#uncheck_all').click(function() {
		$(".racer_car_class_competition_number").attr("checked", false);
	});
	
	$('#select_competition_modal').modal();

	$('#select_competition_modal').on('hidden.bs.modal', function(e) {
		history.go(-1);
	});	

	$('#new_team_in_competition').submit(function(){
		$("#ajax_loader").css("display", "inline-block");
		var teamId = $('#teamId').val();
		var competitionId = $('#competitionId').val();
		var carClassesCompetitionNumbers="";
		var inputs = document.getElementsByClassName("racer_car_class_competition_number");
		var separator = "#";
		var isChecked = false;
		for (var i = 0; i < inputs .length; i++) {
			if(inputs[i].checked==true){
				carClassesCompetitionNumbers +=inputs[i].id + separator;
				var isChecked = true;
			}
		}
		if (isChecked==true){
		var json = { 
				"racerCarClassesCompetitionNumbers" : carClassesCompetitionNumbers,
				"teamId": teamId, "competitionId": competitionId };
		var url =  window.location.protocol + "//" + window.location.host + '/Carting/competition/addTeam';
		$.ajax({  
	        url: url,
	        data: JSON.stringify(json),  
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {  
	        	$("#ajax_loader").css("display", "none");
	        	$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/competition/'+response);
	        } 
	    }); 
		return false;
		}
		else{
			$('#not_registered_modal').modal();
			return false;			
		}
	});
	
	$('#not_registered_back').click(function() {
		$("#ajax_loader").css("display", "none");
	});
	
	$('#not_registered_modal').on('hidden.bs.modal', function(e) {
		$("#ajax_loader").css("display", "none");
	});
	
	
});
$(document).ready(function(){

	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd',
        todayBtn: 'linked',
        //language: 'ua'
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

	//set datepickers start and end date
	$('#dateStart').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('#dateEnd').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('#firstRaceDate').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('#secondRaceDate').datepicker('setStartDate', (new Date()).yyyymmdd());
	
	$('#delete_competition_btn').click(function(){
		$("#delete_competition_error").css("display", "none");
		$('#delete_competition_modal').modal();
		return false;
	});

	function compareDate(first, second) {
		var dateOne = first.split('-');
		var yearOne = dateOne[0];
		var monthOne = dateOne[1];
		var dayOne = dateOne[2];
		var firstDate = new Date(yearOne, monthOne, dayOne);

		var dateTwo = second.split('-');
		var yearTwo = dateTwo[0];
		var monthTwo = dateTwo[1];
		var dayTwo = dateTwo[2];
		var secondDate = new Date(yearTwo, monthTwo, dayTwo);		

		if (firstDate >= secondDate) {
			return true;
		} else {
			return false;
		}
	}
	
	$("#new_competition").submit(function(e){
		// Begin and end competition dates
		var dBegin = $('#dateStart').val();
		var dEnd = $('#dateEnd').val();

		// First and second races date
		var firstRace = $('#firstRaceDate').val();
		var secondRace = $('#secondRaceDate').val();

		// Begin date must be <= End date
		var validBegin = compareDate(dEnd, dBegin);
		
		// First race date must be >= Begin date
		var validFirstBegin = compareDate(firstRace, dBegin);
		
		// First race date must be <= End date
		var validFirstEnd = compareDate(dEnd, firstRace);
		
		// Second race date must be >= First date race
		var validRace = compareDate(secondRace, firstRace);
		
		// Second race date must be >= Begin date
		var validSecondBegin = compareDate(secondRace, dBegin);
		
		// Second race date must be <= End date
		var validSecondEnd = compareDate(dEnd, secondRace);		
		
		//	Check everything together
		var validDates = validBegin && validFirstBegin && validFirstEnd && validRace && validSecondBegin && validSecondEnd;
	    
	    if (validDates) {
	         return true;
	    } else {
			$('#add_competition_error').css("display", "inline-block").hide().fadeIn();
			$('#add_competition_error').delay(2000).fadeOut('slow');	    	
			return false;
		}
	});



	$('#delete_competition').click(function(){
		$("#ajax_loader_delete").css("display", "block");

		var competition_delete_id = $('#competition_delete_id').val();
	    var json = { "id" : competition_delete_id };
		$.ajax({
	        url: $("#competition_delete_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_delete").css("display", "none");
	        	if(response == "success"){
	        		$('#delete_competition_modal').modal('hide');
	        		$(location).attr('href', $("#competition_delete_redirect_url").val());
	        	} else {
	        		$("#delete_competition_error").css("display", "block");
	        	}	        	
	        }
	    });
		return false;
	});
	
	$('#add_carclass_competition_btn').click(function(){
		$('#add_carclass_competition_modal').modal();
		return false;
	});
	
	$('#add_car_class_form').submit(function(){
		$("#ajax_loader_add_carclass").css("display", "block");
		var url = $("#add_car_class_form").attr("action");
		var json = { "carClassId" : $('#car_class').val(),
					 "firstRaceTime" : $('#first_race_time').val(),
					 "secondRaceTime" : $('#second_race_time').val(),
					 "lapCount" : $('#lap_count').val(),
					 "percentageOffset" : $('#percentage_offset').val() };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_add_carclass").css("display", "none");
	        	$('#add_carclass_competition_modal').modal('hide');
	        	location.reload();
	        }
	    });
		return false;
	});
	
	$('.delete_carclass_btn').click(function(){
		$("#delete_carclass_error").css("display", "none");
		var car_class_id = $(this).attr("id").replace("delete", "");
		var car_class_name = $('#name' + car_class_id).html();
		$('#carclass_delete_id').val(car_class_id);
		$('#carclass_delete_name').html('"' + car_class_name + '"');
		$('#delete_carclass_modal').modal();
		return false;
	});
	
	$('#delete_carclass').click(function(){
		$("#ajax_loader_delete_carclass").css("display", "block");

		var carclass_delete_id = $('#carclass_delete_id').val();
	    var json = { "id" : carclass_delete_id };
		$.ajax({
	        url: $("#carclass_delete_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_delete_carclass").css("display", "none");
	        	if(response == "success"){
		        	$('#delete_carclass_modal').modal('hide');
		        	location.reload();
	        	} else {
	        		$("#delete_carclass_error").css("display", "block");
	        	}
	        }
	    });
		return false;
	});
	
	$('.edit_carclass_btn').click(function(){
		var car_class_id = $(this).attr("id").replace("edit", "");
		var car_class_name = $('#name' + car_class_id).html();
		var first_race_time = $('#firstRaceTime' + car_class_id).html();
		var second_race_time = $('#secondRaceTime' + car_class_id).html();
		var lap_count = $('#circleCount' + car_class_id).html();
		var percentage_offset = $('#percentageOffset' + car_class_id).html();
		
		$('#carclass_id_edit').val(car_class_id);
		$('#carclass_name_edit').html('"' + car_class_name + '"');
		$('#first_race_time_edit').val(jQuery.trim(first_race_time));
		$('#second_race_time_edit').val(jQuery.trim(second_race_time));
		$('#lap_count_edit').val(jQuery.trim(lap_count));
		$('#percentage_offset_edit').val(jQuery.trim(percentage_offset).replace("%", ""));
		
		$('#edit_carclass_competition_modal').modal();
		return false;
	});
	
	$('#car_class_form_edit').submit(function(){
		$("#ajax_loader_edit_carclass").css("display", "block");

		var url = $('#car_class_form_edit').attr("action");
	    var json = { "id" : $('#carclass_id_edit').val(),
	    		     "firstRaceTime" : $('#first_race_time_edit').val(),
	    		     "secondRaceTime" : $('#second_race_time_edit').val(),
	    		     "circleCount" : $('#lap_count_edit').val(),
	    		     "percentageOffset" : $('#percentage_offset_edit').val(),
	    		   };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_edit_carclass").css("display", "none");
	        	$('#edit_carclass_competition_modal').modal('hide');
	        	location.reload();
	        }
	    });
		return false;
	});
	

	$(".racersCount").each(function (i) {
		var id = $(this).attr("id").replace("count", "");
		var json = { "id": id };
		var url = $('#getRacersCountUrl').val();

		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$('#count' + id).html(response);
	        }
	    });

	});
	
	// check if current page contains switcher
	if ($.fn.bootstrapSwitch != undefined) {			
		$.fn.bootstrapSwitch.defaults.size = 'normal';
		$.fn.bootstrapSwitch.defaults.onColor = 'success';
		$.fn.bootstrapSwitch.defaults.offColor = 'danger';
		$("#enabled").bootstrapSwitch();	
		$('#enabled').on('switchChange.bootstrapSwitch', function(event, state) {
			var enabled = state;
			var competition_id = $('#competition_id').val();
			var json = { "enabled" : enabled, "competitionId" : competition_id };
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
	}
	
	// check if current page contains start_element
	if ($("#start_date").html() != undefined) {
			
		var minutes = 1000*60;
		var hours = minutes*60;
		var days = hours*24;
		
		var startDate = new Date($("#start_date").html().trim());
		var endDate = new Date($("#end_date").html().trim());
		var dayDiff	= new Date(startDate);
		dayDiff.addDays(Math.round((endDate - startDate)/days));
		
		$('#competition_calendar').pickmeup({
			format  : 'Y-m-d',
			flat : true,
			date : [ startDate, dayDiff],
			mode : 'range',
		});
	}	
	    
	jQuery(function($){
		$('tbody tr[data-href]').addClass('clickable').click( function() {
			window.location = $(this).attr('data-href');
		});
	});

	// Event for Cancel button on "add competittion" page
    $('#cancel_add_competition').click(function(){
        parent.history.back();                
        return false;
	});
	
});
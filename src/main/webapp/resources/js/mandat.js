$(document).ready(function(){
	
	var table_id = "team_table";

	function getURLParameter(name) {
	    return decodeURIComponent(
	        (location.search.match(RegExp("[?|&]"+name+'=(.+?)(&|$)'))||[,null])[1]
	    );  
	}
	
	if(getURLParameter('team') != 'null'){
		var team = getURLParameter('team').trim();
		$('#teams').val(team);
		dropdownFiltersAction(team, "all");
		showNotValidAction();
	}
	
	function filter(table_id, right_char, td_class) {
		var del = false;
		$('#' + table_id + ' tbody tr').each(function(){				
		    $(this).find('td.' + td_class).each(function(){
		    	var value = "";
		    	if($(this).children('span.minus').length > 0) {
		    		value = "minus";
		    	} else if($(this).children('span.plus').length > 0) {
		    		value = "plus";
		    	}	        
		        if (value != right_char) {
		        	del = true;
		        	return false;
		        }	    	
		    });
		    if(del) {
		    	$(this).hide();
		    	del = false;
		    }	
		    del = false;
		});
			
	}
	
	function filterInverse(table_id, right_char, td_class) {
		var right = true;
		$('#' + table_id +' tbody tr').each(function(){				
		    $(this).find('td.' + td_class).each(function(){
		    	var value = "";
		    	if($(this).children('span.minus').length > 0) {
		    		value = "minus";
		    	} else if($(this).children('span.plus').length > 0) {
		    		value = "plus";
		    	}	    
		        if (value == right_char) {     
		        	right = false;
		        	return false;
		        }
		    });		    
		    if (right == true) {
		    	$(this).hide();   	
		    }		    
		    right = true;
		});
	}
	
	function dropdownFilters(team, car_class){
		var teamFilter = "[team != '" + team + "']";
		var carClassFilter = "[carclass != '" + car_class + "']";
		if(team != "all" && car_class != "all"){
			$("#" + table_id + " tbody tr").filter(teamFilter + "," + carClassFilter).hide();
		} else if(team == "all" && car_class == "all"){
			showAll();
		} else {
			if(team == "all"){
				$("#" + table_id + " tbody tr").filter(carClassFilter).hide();
			} else if(car_class == "all"){
				$("#" + table_id + " tbody tr").filter(teamFilter).hide();
			}
		}
		
	}
	
	function showAll(){
		$("#" + table_id + " tbody tr").show();
	}
	
	function dropdownFiltersAction(team_id, car_class_id){			
		showAll();						
		dropdownFilters(team_id, car_class_id);
	}
	
	function showValidAction(){
		filter(table_id, "plus", "sortable");
	}	
	
	function showNotValidAction(){
		filterInverse(table_id, "minus", "sortable");
	}	
	
	function resetActiveButtons(){
		$('#show_valid').removeClass("active");
		$('#show_not_valid').removeClass("active");
		$('#show_all').removeClass("active");
	}
	
	function dropdownChangeFunction(){
		var team = $('#teams :selected').val();
		var car_class = $('#car_classes :selected').val();
		dropdownFiltersAction(team, car_class);	
	}
	
	$('#teams').change(function(){		
		dropdownChangeFunction();
		return false;
	});	
	
	$('#car_classes').change(function(){					
		dropdownChangeFunction();
		return false;
	});	
	
	$('#show_valid').click(function(){
		dropdownChangeFunction();
		showValidAction();
		return false;
	});
	
	$('#show_not_valid').click(function(){
		dropdownChangeFunction();
		showNotValidAction();
		return false;
	});
	
	$('#show_all').click(function(){
		dropdownChangeFunction();
		return false;
	});
	
	$(".unreg_racer_btn").click(function(){
		$("#unreg_error").css("display", "none");
		var str = $(this).attr("id").split("_");
		var racer_id = str[1];
		var carclass_id = str[2];
		var racer_name = $("#racer" + racer_id).html().trim();
		var carclass_name = $("#carclass" + carclass_id).html().trim();
		$("#unreg_racer_id").val(racer_id);
		$("#racer_name").html(racer_name);
		$("#unreg_carclass_id").val(carclass_id);
		$("#carclass_name").html(carclass_name);
		$('#unreg_racer_modal').modal();
		return false;
	});
	
	$("#unreg_racer").click(function(){
		$("#ajax_loader_unreg").css("display", "block");

		var racer_id = $('#unreg_racer_id').val();
		var carclass_id = $("#unreg_carclass_id").val();
		var url = $("#unreg_racer_url").val() + carclass_id + "/unregisterRacer";
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

});
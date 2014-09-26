$(document).ready(function(){
	

	
	$(".datepicker").keydown(function(){
		return false;
	});
	if ($("#car_classes").val()=="") {
		$("#edit_numbers_modal").attr("disabled","disabled");
		$("#delete_classes_ER_modal").attr("disabled","disabled");
		$("#delete_classes").attr("disabled", "disabled");
	}
		
	$("#add_class").attr("disabled","disabled");
	$('#new_racer').submit(function(){
	    
		$("#ajax_loader").css("display", "inline-block");
		
		var firstName = $('#first_name').val();  
	    var lastName = $('#last_name').val();
	    var birthday = $('#birthday').val();
	    
	    //��������������������������� ������ ������ ������������ ������������������ ��������������������� ��� ��������� 
	    var jsonCheck = { "firstName" : firstName, "lastName" : lastName, "birthday" : birthday };
	    var urlCheck = window.location.protocol + "//" + window.location.host + '/Carting/racer/isSetRacer';
	    $.ajax({  
	        url: urlCheck,  
	        data: JSON.stringify(jsonCheck),  
	        contentType: 'application/json',
	        type: "POST",	        
	        success: function(response) {  
	        	if(response == false){ // ������������ ������������������ ��������������������� ������ ������������, ������������������ ������������
	        		$("#racer_exists").css("display", "none");
	        		var team = $('#team_id').val();	    
	        	    var document = $('#document').val();
	        	    var address = $('#address').val();
	        	    var sportCategory = $('#sport_category').val();
	        	    var carClasses = $('#car_classes_id').val();
	        	    var carClassNumbers = $('#car_classes_numbers').val();
	        	    var json = { "firstName" : firstName, "lastName" : lastName, "team": team,
	        	    			 "birthday" : birthday, "document" : document, 
	        	    			 "address" : address, "sportCategory": sportCategory,
	        	    			 "carClasses" : carClasses, "carClassNumbers" : carClassNumbers
	        	    		   };
	        	    $.ajax({  
	        	        url: $("#new_racer").attr( "action"),  
	        	        data: JSON.stringify(json),  
	        	        contentType: 'application/json',
	        	        type: "POST",
	        	        success: function(response) {  
	        	        	disableInputRacerinfo()
	        	        	$("#ajax_loader").css("display", "none");
	        	        	$("#label_add_doc").css("display", "block");
	        	        	$("#addDocumentsForm").css("display", "block").hide().fadeIn();
	        	        	var racerId=~~response
	        	        	var x=(+response-racerId)*10;
	        	        	$("#racerId").val(racerId)
	        	        	$('#add_racer').hide();
	        	        	$('#docNum1').focus();
	        	        	if(parseInt(x)<1) {
	        	        		$("#tab4").css("display", "none");
	        	        		$("#permissionInfo").css("display", "none");
	        	        	}
	        	        } 
	        	    });
	        	    
	        	} else { // ������������ ��������������� ������������������ ������������
	        		$("#ajax_loader").css("display", "none");
	        		$("#racer_exists").css("display", "block");
	        	}
	        } 
	    });   

		return false;
		
	});
	
	$("#finish").click(function (e) {
		var racerId = $("#racerId").val()
		if (racerId>0) {
			window.location = '/Carting/racer/' + racerId
		} else window.location = '/Carting/'
	})
	
	$('.addFile').click(function() {
		var index = $(this).attr("typeDocument");
		var count = document.getElementsByClassName('file'+index).length
		if(count<3){
			$('#fileTable'+index).append(
					'<tr><td><div class="form-group">'+
					'<input type="file" name="file" onchange="return ValidateFileUpload(this)" class="form-control file'+index+'"/>'+
					'</div></td></tr>');
		} else {
			$('#max_count_achieved'+index).css("display", "inline-block").hide().fadeIn();
			$('#max_count_achieved'+index).delay(2000).fadeOut('slow');
		}
		
	});
	
	function disableInputRacerinfo() {
    	$("#first_name").attr("disabled", "disabled");
    	$("#last_name").attr("disabled", "disabled");
    	$("#birthday").attr("disabled", "disabled");
    	$("#document").attr("disabled", "disabled");
    	$("#address").attr("disabled", "disabled");
    	$("#sport_category").attr("disabled", "disabled");
    	$("#add_class_modal").attr("disabled", "disabled");
    	$("#delete_classes").attr("disabled", "disabled");
    	$("#add_racer").attr("disabled", "disabled");
    	$("#add_class_modal").hide();
    	$("#delete_classes").hide();
	}
	
	$('#edit_racer').submit(function(){
        		$("#ajax_loader").css("display", "inline-block");
                            var id = $('#id').val();
                            var firstName = $('#first_name').val();
    	                    var lastName = $('#last_name').val();
    	                    var birthday = $('#birthday').val();
        	        		var team = $('#team_id').val();
        	        	    var document = $('#document').val();
        	        	    var address = $('#address').val();
        	        	    var sportCategory = $('#sport_category').val();
        	        	    var carClassesOld = $('#car_classes_id_old').val();
                            var carClassNumbersOld = $('#car_classes_numbers_old').val();
        	        	    var carClasses = $('#car_classes_id').val();
        	        	    var carClassNumbers = $('#car_classes_numbers').val();
        	        	    var registrationDate = $('#registration_date').val();
    	        	        var json = {"id" : id, "firstName" : firstName, "lastName" : lastName, "team": team,
    	        	    			 "birthday" : birthday, "document" : document,
    	        	    			 "address" : address, "address" : address, "sportCategory": sportCategory,
    	        	    			 "carClassesOld" : carClassesOld, "carClassNumbersOld" : carClassNumbersOld,
    	        	    			 "carClasses" : carClasses, "carClassNumbers" : carClassNumbers,
    	        	    			 "registrationDate" : registrationDate
    	        	    		   };
        	        	    $.ajax({
        	        	        url: $("#edit_racer").attr( "action"),
        	        	        data: JSON.stringify(json),
        	        	        contentType: 'application/json',
        	        	        type: "POST",
        	        	        success: function(response) {
        	        	        	$("#ajax_loader").css("display", "none");
        	        	        	$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/racer/' + response);
        	        	        }
        	        	    });
        		return false;
        	});
	
	$("#add_class_ER_modal").click(function(){
		$('#addClassERModal').modal();
	});
	$('#addClassERModal').on('hidden.bs.modal', function (e) {
		$('#car_number').val("");
		$("#added_successfully").css("display", "none");
		$("#car_class_exists").css("display", "none");
		$("#car_number_for_class_exists").css("display", "none");
	});
	
	/*Adding racerCarclassNumber on "Edit Racer" page */
	$("#add_class_ER").click(function(){
		if($("#car_number").val() < 100 && $("#car_number").val()>0){
			if($("#car_number").val() == ""){ 
				$("#car_number_empty").css("display", "block");
			} else { 
				$("#car_number_empty").css("display", "none");			
				$("#ajax_loader-modal").css("display", "block");
				
				var racerId = $("#id").val();
				var carClassId = $("#car_class :selected").val();				
				var number = $("#car_number").val();
				
				/*Checking whether racer already participate in this carClass*/
				var urlCheckClass = window.location.protocol + "//" + window.location.host + '/Carting/racer/isSetCarClass';
			    var jsonCheckClass = {"racerId": racerId,
			    						"carClassId" : carClassId 
			    };			    
        		$.ajax({  
			        url: urlCheckClass,  
			        data: JSON.stringify(jsonCheckClass),  
			        contentType: 'application/json',
			        type: "POST",	        
			        success: function(response) { 
			        	$("#ajax_loader-modal").css("display", "none");
			        	if(response == false){ 	
			        		$("#car_class_exists").css("display", "none");
			        		/*Checking whether number of car for this class already exist*/
			        		var urlCheckClassNumber = window.location.protocol + "//" + window.location.host + '/Carting/racer/isSetNumberForCarClass';
						    var jsonCheckClassNumber = { "carClass" : carClassId, 
						    			"number" : number		    			
						    };
						    
						    $.ajax({  
						        url: urlCheckClassNumber,  
						        data: JSON.stringify(jsonCheckClassNumber),  
						        contentType: 'application/json',
						        type: "POST",	        
						        success: function(response) {  
						        	$("#ajax_loader-modal").css("display", "none");
						        	if(response == false){ 
						        		$("#car_number_for_class_exists").css("display", "none");
										
						        		/*Adding number of a car for the class of cars for the racer to database*/
						        		var url = window.location.protocol + "//" + window.location.host + '/Carting/racer/addRacerCarClassNumber';
									    var json = { "racerId": racerId,
									    			"carClassId" : carClassId, 
									    			"number" : number		    			
									    };
						        		$.ajax({
						        			url: url,
						        			data: JSON.stringify(json),
						        			contentType: 'application/json',
						        			type: "POST",
						        			success: function(response) {
						        				
						        				var car_classes_numbers = $("#car_classes_numbers").val();
												var car_classes = $("#car_classes").val();
												var car_classes_id = $("#car_classes_id").val();			
												var separator = ", ";
														
												if(car_classes_numbers != "") { car_classes_numbers += separator; }
												if(car_classes != "") { car_classes += separator; }
												if(car_classes_id != "") { car_classes_id += separator; }		
														
												car_classes_numbers += $("#car_number").val();
												car_classes += $("#car_class :selected").text() + "(#" + $("#car_number").val() + ")";
												car_classes_id += $("#car_class :selected").val();
														
												$("#car_class :selected").attr("disabled", "disabled");
														
												$("#car_classes_numbers").val(car_classes_numbers);
												$("#car_classes").val(car_classes);
												$("#car_classes_id").val(car_classes_id);		
												window.location.reload();		
												//$("#car_number").val("");
												$('#car_number').val("");
												$("#added_successfully").css("display", "block");
						        			}
						        			
						        		});       
						        		
						        	} 
						        	else { // ������������ ��������������� ��������������� ��������� ������������������ ��������������� ��������� ������������
										$("#added_successfully").css("display", "none");
										$("#car_class_exists").css("display", "none");
										$("#car_number_for_class_exists").css("display", "block");	
									}						        	
						        }
			        		});
			        	} else { // ������������ ��������������� ��������������� ��������� ������������������ ��������������� ��������� ������������
			        		$("#added_successfully").css("display", "none");
			        		$("#car_class_exists").css("display", "block");
			        		$("#car_number_for_class_exists").css("display", "none");
			        	}
			        } 
			    });				
			}
		}
	});
	$("#edit_numbers_modal").click(function(){
		
		$('#editNumbersModal').modal();
		var carClasses = $(".car_class_number");
		for (var i = 0; i < carClasses.length; i++) {
			var carClassId = carClasses[i].id.split(",")[1];
			var racerCarClassNumberId = carClasses[i].id.split(",")[0];
			var fullId = racerCarClassNumberId + "\\," + carClassId;
			var racerNumberInCarClass = $("#"+fullId + " :selected").val();
			var url = $("#get_occupied_numbers_url").val();
			var json = { "carClassId" : carClassId };
			
			$.ajax({
		        url: url,
		        data: JSON.stringify(json),
		        contentType: 'application/json',
		        type: "POST",
		        async: false,
		        success: function(response) {
		        	if(response != null) {
		        		for (var j = 0; j < response.length; j++) {
		        			if (response[j] == racerNumberInCarClass) {
		        				response.splice(j,1);
		        			}
		        		}
		        		disableOccupiedNumbers(fullId, response);
		        	}
		        }
		    });
		}
	});	
	
	$("#delete_classes_ER_modal").click(function(){
		$('#deleteClassesERModal').modal();
	});
	

	$("#delete_classes_ER").click(function(){
		var racerId = $("#id").val();
		var url = window.location.protocol + "//" + window.location.host + '/Carting/racer/deleteRacerCarClassNumbers';
	    var json = { "racerId" : racerId};
	    $.ajax({  
	        url: url,  
	        data: JSON.stringify(json),  
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {  
	        	$("#car_classes").val("");
	    		$("#car_classes_id").val("");
	    		$("#car_classes_numbers").val("");
	    		window.location.reload();		
	        }
	    });
	});
	
	$("#delete_chosen_classes_ER_modal").click(function(){
		$('#deleteChosenClassesERModal').modal();
	});
	
	$("#delete_chosen_classes_ER").click(function(){
		var carClassView="";
		var racerCarClassNumbersIds ="";
		var isChecked = false;
		var separator = ", ";
		var inputs = document.getElementsByClassName("check_to_delete");
		
		for (var i = 0; i < inputs.length; i++) {
			if(inputs[i].checked==true){
				racerCarClassNumbersIds +=inputs[i].id + separator;
				isChecked = true;
			}
			else{
				if(carClassView==""){
					carClassView = document.getElementById("car_class_name"+inputs[i].name).value
					+"(#"+document.getElementById(inputs[i].name).value+")";
				}
				else{
				carClassView +=separator + document.getElementById("car_class_name"+inputs[i].name).value
					+"(#"+document.getElementById(inputs[i].name).value+")";
				}
				
			}
		}
		if(isChecked == true){
		var racerId = $("#id").val();
		var url = window.location.protocol + "//" + window.location.host + '/Carting/racer/deleteChosenRacerCarClassNumbers';
	    var json = { "racerCarClassNumbersIds" : racerCarClassNumbersIds};
	    $.ajax({  
	        url: url,  
	        data: JSON.stringify(json),  
	        contentType: 'application/json',
	        type: "POST",	        
	        success: function(response) {  
	        	$("#car_classes").val(carClassView);	        	
	    		$("#car_classes_id").val("");
	    		$("#car_classes_numbers").val("");
	    		window.location.reload();		
	        }
	    });
		}
		else{
			$('#deleteChosenClassesERModal').modal('hide');
		}
	});
	
	$('#editNumbersModal').on('hidden.bs.modal', function (e) {
		var inputs = document.getElementsByClassName("car_class_number");
		for (var i = 0; i < inputs .length; i++) {
			inputs[i].value = inputs[i].name;
		}
	});

	
	$('#edit_numbers_ER').click(function(){
		$("#edit_numbers_loader").css("display", "block");
	
		var separator = "#";
		var separatorInner = ",";
		var updatedRacerCarClassNumbers="";
		var inputs = document.getElementsByClassName("car_class_number");
		for (var i = 0; i < inputs .length; i++) {			
			updatedRacerCarClassNumbers += inputs[i].id + separatorInner+inputs[i].value + separator;
		}
		var racerId = $("#id").val();
		var url = window.location.protocol + "//" + window.location.host + '/Carting/racer/updateRacerCarClassNumbers';
	    var json = { "racerId" : racerId,
	    		"updatedRacerCarClassNumbers" : updatedRacerCarClassNumbers};

		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#edit_numbers_loader").css("display", "none");
	        	$('#carClassView').val("");
	        	var carClassView = "";
	        	var inputs = document.getElementsByClassName("car_class_number");
	        	var separator = ", ";
	    		for (var i = 0; i < inputs .length; i++) {		
	    			var carClassName = document.getElementById("car_class_name"+inputs[i].id).value;
	    			if (carClassView==""){
	    				carClassView = carClassName+"(#"+inputs[i].value+")";
	    			}
	    			else{
	    				carClassView += separator + carClassName+"(#"+inputs[i].value+")";
	    			}
	    			inputs[i].name = inputs[i].value;
	    			inputs[i].placeholder = inputs[i].value;	    			
	    		}
	    		
	    		$('#car_classes').val(carClassView);
	    		window.location.reload();		
	        }
	    });
		return false;
	});		
	
	$("#add_class_modal").click(function(){
		$('#basicModal').modal();
	});
	
	function disableOccupiedNumbers(dropdown_id, numbers){
		$("#" + dropdown_id + " option").each(function(){
		    $(this).removeAttr('disabled');
		});
		for(var i = 0; i < numbers.length; i++){
			$('#' + dropdown_id + ' option[value="' + numbers[i] + '"]').attr("disabled", "disabled");
		}		
	}
	
	$('#car_class').change(function(){
		$("#ajax_loader_add_carclass").css("display", "block");
		$('#car_number').removeAttr("disabled");
		$('#car_number').val("");
		$("#add_class").attr("disabled", "disabled");
		
		var url = $("#get_occupied_numbers_url").val();
		var car_class_id = $("#car_class :selected").val();
		var json = { "carClassId" : car_class_id };
		$.ajax({
	        url: url,
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_add_carclass").css("display", "none");
	        	if(response == "error"){
	        		$('#car_number').attr("disabled", "disabled");
	        	} else {
	        		console.log(response);
	        		disableOccupiedNumbers("car_number", response);
	        	}
	        }
	    });
	});
	
	$('#car_number').change(function(){
		if($(this).val() != "" && $("#car_class").val() != ""){
			$("#add_class").removeAttr("disabled");
		} else {
			$("#add_class").attr("disabled", "disabled");
		}
	});
		
	$("#add_class").click(function(){
		if($("#car_class :selected").attr("disabled") != "disabled"){ 										        		    		
    		var car_classes_numbers = $("#car_classes_numbers").val();
			var car_classes = $("#car_classes").val();
			var car_classes_id = $("#car_classes_id").val();			
			var separator = ", ";
			
			if(car_classes_numbers != "") { car_classes_numbers += separator; }
			if(car_classes != "") { car_classes += separator; }
			if(car_classes_id != "") { car_classes_id += separator; }		
			
			car_classes_numbers += $("#car_number").val();
			car_classes += $("#car_class :selected").text() + "(#" + $("#car_number").val() + ")";
			car_classes_id += $("#car_class :selected").val();
			
			$("#car_class :selected").attr("disabled", "disabled");
			$("#add_class").attr("disabled","disabled");
			$("#delete_classes").removeAttr("disabled");
			$('#car_class').val("");
			$('#car_number').val("");
			$("#car_classes_numbers").val(car_classes_numbers);
			$("#car_classes").val(car_classes);
			$("#car_classes_id").val(car_classes_id);																
		}
	});
		
	$("#delete_classes").click(function(){
		$("#car_classes").val("");
		$("#car_classes_id").val("");
		$("#car_classes_numbers").val("");
		$('#car_class option').each(function(){
            this.disabled = false;
        });
		$(this).attr("disabled", "disabled");
	});
	
	$('#delete_racer_btn').click(function(){
		$('#delete_racer_modal').modal();
	});
	
	$('#delete_racer').click(function(){
		$("#ajax_loader_delete").css("display", "block");

		var racer_delete_id = $('#racer_delete_id').val();
	    var json = { "id" : racer_delete_id };
		$.ajax({
	        url: $("#racer_delete_url").val(),
	        data: JSON.stringify(json),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        	$("#ajax_loader_delete").css("display", "none");
	        	$('#delete_racer_modal').modal('hide');
	        	$(location).attr('href', $("#racer_delete_redirect_url").val());
	        }
	    });
		return false;
	});
	
	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd',
        todayBtn: 'linked',
        //language: 'ua'
	});
	
	Date.prototype.yyyymmdd = function() {               
        var yyyy = this.getFullYear().toString();                                    
        var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based         
        var dd  = this.getDate().toString();                                        
        return yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);
	};  

	//set datepickers start and end date
	$('#birthday').datepicker('setEndDate', (new Date()).yyyymmdd());
	$('#medical_certificate_expires').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('#insurance_expire').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('.datepicker.docInput3').datepicker('setStartDate', (new Date()).yyyymmdd());
	$('.datepicker.docInput2').datepicker('setStartDate', (new Date()).yyyymmdd());
	
	$('.datepicker').on('changeDate', function() {
		$(this).datepicker('hide');
	});
		
	if ($('#addDocumentsForm').length != 0) {
		$('#addDocumentsForm').bootstrapValidator();
	}
	
	// Display ajax loader image if form pass validation
	$('#add_docs').on('success.form.bv', function(e) {
		$("#ajax_loader_docs").css("display", "inline-block");
	});
	
	// reValidate the date when user change it  
	$('#doc_date_picker').on('changeDate', function(e) {

		var name = $('#doc_date_picker').attr('name')
		$('#addDocument').bootstrapValidator('revalidateField', name); 
		$('#doc_date_picker').datepicker('hide');
    });
	

//adding documents to new added racer
	$('.adding').click(function() {
		var index = $(this).attr("doc_type");
		$('#result').html('');
		var fd = new FormData();
		var fileExtensions = new Array();
//checking files
		$.each($('.file'+index),function (x,val) {
			fd.append("files[]",val.files[0]);
			var name=$(this).val();
			var length=$(this).length;
			fileExtensions.push('.' + name.substr(length-4, 3));
		});
		fd.append("fileExtensions",fileExtensions);
		fd.append("racerId", $('#racerId').val());
		fd.append("docType",index)
//checking document type
		if (index=='1'||index=='2') {
			fd.append("doc_number", $('#docNum'+index).val());
		}
		if (index=='2'||index=='3') {
			fd.append("finish_date", $('#doc_date_picker'+index).val())
		} 
		if (index=='4') {
			var start_date = $('#doc_date_picker4').val();
			fd.append("start_date",start_date)
		}
		$.ajax({
			url: "/Carting/document/addDocs",
			data: fd,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				if (data=="added") {
					afterAdding(index);
				} else if (data=="problem") {
					$('#problem-result').css("display", "block").hide().fadeIn();
					$('#problem-result').delay(2000).fadeOut('slow');
				} else {
					$('#result').html(data);
					$('#result').css("display", "block").hide().fadeIn();
					$('#result').delay(2000).fadeOut('slow');
					//$(location).attr('href', window.location.protocol + "//" + window.location.host + '/Carting/');
				}
			}
		});
	});
});

//hiding buttons and disabling inputs to unable editing after adding data 
//and going to the next tab
function afterAdding(index) {
	$('#success-result').css("display", "block").hide().fadeIn();
	$('#success-result').delay(2000).fadeOut('slow');
	var next=+index+1;
	if (next<6)  {
		$('#myTab a[id="a'+next+'"]').tab('show')
	}
	$('#a'+index).attr({
		style:"color: silver"
	})
	$.each($('.file'+index),function(){
		$(this).attr('disabled',true)
	})
	$.each($('.docInput'+index),function(){
		this.disabled="disabled";
	})
	$('#addFile'+index).hide()
	$('#add'+index).hide()
}

//disabling add-button, when there is no filled all information
function test() {
	for (var index=1;index<5;index++) {
		$.each($('.docInput'+index),function (x,v) {
			if (v.value==''){
				document.getElementById('add'+index).disabled=true;
				return false;
			} else {
				document.getElementById('add'+index).disabled=false;
			}
		});
	}
}
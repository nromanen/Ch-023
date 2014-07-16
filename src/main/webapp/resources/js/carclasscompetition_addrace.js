$(document).ready(function(){
	
	
	//first version of validation

	
	//	//result sequence validation
//	$('#result_sequance').keypress(function(e){
//		
//		// event on keypress space or enter
//		if(e.which == 32 || e.which == 13){
//			var values = $.trim($(this).val());
//			values = values.replace(/\n\r?/g, ' ');
//			var vals = values.split(' ');
//			var arr = $('#validNumbers').data('validnumbers');
//			arr=arr+'';
//			var mass = arr.split(',');
//			if($.inArray(vals[vals.length-1], mass) != -1){
//				$('.error').html('<span style="color:red"></span>');
//			}else{
//				$('.error').html('<span style="color:red">' + vals[vals.length-1] + ' is not valid!  Write the correct number!</span>');
//				vals.splice(vals.length-1,1);
//				$(this).val($.trim((vals.join(' '))));
//			}
//			
//		}
//	});
//	
//	$('#add_race').click(function(){
//		if($('#result_sequance').val()==''){
//			return false;
//		}
//	});
	

//	
	$('#editor').wysiwyg({
	      
	});
	
	function divide(laps,members, array_of_numbers ){
		var temp=[];
		 var k = 0; 
		if (array_of_numbers.length==0){return 0;}
		for(var i=0;i<array_of_numbers.length;i++){
			  
			  if (i<laps*members){
				  while(k<laps){
			  
					  if(!temp[k]){
						  temp[k]=[];
						  }
					  if(k<=laps-1){
					  	if(!temp[k+1]){
					  		temp[k+1]=[];
					  		}
					  }
					  if(temp[k].indexOf(array_of_numbers[i])==-1){
						  temp[k].push(array_of_numbers[i]);
						  break;
					  }else{
						  temp[k+1].push(array_of_numbers[i]);
						  k++;
						  break;
					  }
				  }
			  }
		}
		return temp;
	}
	
	//parse from editor with html tags to array of numbers
	function parse_editor(values_with_html){
		values_with_html=values_with_html.replace(/(<([^>]+)>)/ig," ");
		var values_with_spaces=values_with_html.replace(/\s{2,}/g, ' ');
		var array_of_numbers = values_with_spaces.split(' ');
		array_of_numbers.splice(array_of_numbers.length-1,1);
		
		return array_of_numbers;
	}
	
	
	$('#validate_btn').click(function(){
		$('.error').html('');
		
		var laps =$('#number_of_laps').val();
		var members=$('#number_of_members').val();
		var values_with_html =$('#editor').html();
		//get parsed array of numbers
		var array_of_numbers = parse_editor(values_with_html);
		//get the valid numbers
		var arr = $('#validNumbers').data('validnumbers');
		arr=arr+'';
		var mass = arr.split(',');
		//divide to table
		var temp = divide(laps,members,array_of_numbers);
		//output and highlight if necessary
		
		
		if (temp!=0){
			$('#editor').html('');
			
			for (var i=0; i<laps; i++){
				for (var k=0; k<temp[i].length; k++){
					if ($.inArray(temp[i][k], mass) == -1){
					$('#editor').append('<span style=color:red>'+temp[i][k]+'</span> ');
					}else{
						$('#editor').append(temp[i][k]+' ');
					}
				}
				$('#editor').append('<br>');
			}
		}
	});
	
	$('#add_race_btn').click(function(){
		
		var arr = $('#validNumbers').data('validnumbers');
		arr=arr+'';
		var mass = arr.split(',');
		var hasErrors=0;
		var values_with_html =$('#editor').html();
		var array_of_numbers = parse_editor(values_with_html);

		for (var i=0; i<array_of_numbers.length; i++){
		if	($.inArray(array_of_numbers[i], mass) == -1){
			hasErrors=1;
		}
		}
		if (hasErrors==1){
			$('.error').html('<span style="color:red"> Please, validate your numbers first!</span>');
			return false;}
		
		$('#result_sequance').val($.trim(array_of_numbers.join(' ')));
		
		 $('#add_race_form').submit();
	});
	
	
});
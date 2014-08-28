$(document).ready(function(){

	$('#editor').wysiwyg({
	      
	});
	$('#validate_btn').click(function(){
		$('.error').html('');
		var laps =$('#number_of_laps').val();
		var members=$('#number_of_members').val();
		var values_with_html =$('#editor').html();
		//get parsed array of numbers
		var array_of_numbers = parse_editor(values_with_html);
		var arr = $('#validNumbers').data('validnumbers');
		arr=arr+'';
		var mass = arr.split(',');
		//get the valid numbers	
		var correctNumbers = getValidNumbers(array_of_numbers, mass);
		showAllEnteredCharacters (values_with_html, mass);
		var count = 0;
		for (var i = 0; i< array_of_numbers.length; i++)
			{
			if ($.inArray(array_of_numbers[i], correctNumbers) != -1) count++;
			}
		
		if (count == array_of_numbers.length) {
			var temp = divide(laps,members,array_of_numbers);
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
	  }
	});
	
	function getValidNumbers (array_of_numbers, mass){
		var array = [];
		for (var i = 0; i < array_of_numbers.length; i++){
				if ($.inArray(array_of_numbers[i], mass) != -1){
					array.push(array_of_numbers[i]);
					}
			}
		return array;
	}

	function showAllEnteredCharacters (values_with_html, mass) {
		$('#editor').html('');
		values_with_html=values_with_html.replace(/(<([^>]+)>)/ig," ");
		var values_with_spaces=values_with_html.replace(/\s{2,}/g, ' ');
		var arrayOfCharacters = values_with_spaces.split(' ');
		for (var i = 0; i< arrayOfCharacters.length; i++)
			{
			if ($.inArray(arrayOfCharacters[i], mass) == -1){
				$('#editor').append('<span style=color:red>'+arrayOfCharacters[i]+'</span> ');
				}else{
					$('#editor').append(arrayOfCharacters[i]+' ');
				}
			}
		
	}

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
		values_with_html=values_with_html.replace(/\D/gm,' ');	
		values_with_html=values_with_html.trim()
		var values_with_spaces=values_with_html.replace(/\s{2,}/g, ' ');
		var array_of_numbers = values_with_spaces.split(' ');	
		return array_of_numbers;
	}

	$('#edit_race_btn').click(function(){
		
		var arr = $('#validNumbers').data('validnumbers');
		arr=arr+'';
		var mass = arr.split(',');
		var hasErrors=0;
		var values_with_html =$('#editor').html();
		values_with_html=values_with_html.replace(/\D/gm,' ');		
		var array_of_numbers = parse_editor(values_with_html);
		for (var i=0; i<array_of_numbers.length; i++){
				if	($.inArray(array_of_numbers[i], mass) == -1){
					hasErrors=1;
				}
			}
			if (hasErrors==1){
				$('.error').html('<span style="color:red"> Please, validate your numbers first!</span>');
				return false;
				}
			$('#result_sequance').val($.trim(array_of_numbers.join(' ')));
		 $('#edit_race_form').submit();
	});
		var laps =$('#number_of_laps').val();
		var members=$('#number_of_members').val();
		var string_of_edited_numbers=$('#result_sequance').val();
		var array_of_edited_numbers= string_of_edited_numbers.split(' ');
		//get the valid numbers
		var arr = $('#validNumbers').data('validnumbers');
		arr=arr+'';
		var mass = arr.split(',');
		//divide to table
		var temp = divide(laps,members,array_of_edited_numbers);
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

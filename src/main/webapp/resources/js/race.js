$(document).ready(function(){
	
	$('#race_add_car_class').change(function(){
		var carNumbers = $(this).find('option:selected').data('carnumbers');
		var message = carNumbers ? 'Available car numbers - ' + carNumbers : '';
		$('#car_numbers_list').html(message);
	});
	$('#result_sequance').keypress(function(e){
		
		// event on keypress space or enter
		if(e.which == 32 || e.which == 13){
			var values = $(this).val();
			values = values.replace(/\n\r?/g, ' ');
			var vals = values.split(' ');
			var arr = $('#race_add_car_class').find('option:selected').data('carnumbers');
			console.log(arr);
			arr=arr+'';
			console.log(arr);
			var mass = arr.split(',');
			if($.inArray(vals[vals.length-1], mass) != -1){
				$('.error').html('<span style="color:red"></span>');
			}else{
				$('.error').html('<span style="color:red">' + vals[vals.length-1] + ' is not valid!  Write the correct number!</span>');
				vals.splice(vals.length-1,1);
				$(this).val($.trim((vals.join(' '))));
			}
			
		}
	});
	
	//$('.btn-primary').click(function(){
	$('#add_race').click(function(){
		if($('#result_sequance').val()==''){
			return false;
		}
	});
});
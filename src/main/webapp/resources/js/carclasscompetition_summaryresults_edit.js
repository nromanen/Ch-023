
$(document).ready(function(){
	$("#edit_results_accept").click(function(){
		
		jsonObj = [];
	    $(".editres").each(function() {

	        var id = $(this).attr("id");
	        var resultPoint = $(this).val();

	        item = {};
	        item ["id"] = id;
	        item ["resultPoint"] = resultPoint;
	        console.log(item);
	        jsonObj.push(item);
	    });
	    
	    var url=$('#edit_res_url').val();
	    console.log(url);
	    console.log($('#back_url').val());
		$.ajax({
	        url: url,
	        data: JSON.stringify({'jsonObject':jsonObj}),
	        contentType: 'application/json',
	        type: "POST",
	        success: function(response) {
	        location.href=$('#back_url').val();
	        }
	    });
		
		return false;
	});
	
	$("#edit_results_cancel").click(function(){
		location.href=$('#back_url').val();
        return false;
	});
	
	$(".plus_btn").click(function(){
		
		var absoluteResult_id_edit = $(this).attr("id").replace("plus", "");
		var driver = $('#driver' + absoluteResult_id_edit).html();
		console.log($('#placeholder_comment').val());
		
		$('#comment_edit').attr("placeholder", $('#placeholder_comment').val());
		$('#fine_value_edit').attr("placeholder", $('#placeholder_value_plus').val());
		$('#driver_edit').html(driver);
		$('#absoluteResult_id_edit').val(absoluteResult_id_edit);
		
		
		$('#changeConcreteResult').modal();
		return false;
	});	
$(".minus_btn").click(function(){
		
		var absoluteResult_id_edit = $(this).attr("id").replace("minus", "");
		var driver = $('#driver' + absoluteResult_id_edit).html();
		$('#comment_edit').attr("placeholder", $('#placeholder_comment').val());
		$('#fine_value_edit').attr("placeholder", $('#placeholder_value_minus').val());
		
		$('#driver_edit').html(driver);
		$('#absoluteResult_id_edit').val(absoluteResult_id_edit);
		$('#action_def').val("minus");
		$('#changeConcreteResult').modal();
		return false;
	});	


$('#points_form_edit').submit(function(){
	$("#ajax_loader_edit_carclass").css("display", "block");

	var fine_value=$('#fine_value_edit').val();
	if ($('#action_def').val()=="minus"){
		fine_value=(-1)*fine_value;
	}else fine_value='+'+fine_value;
	var url = $('#points_form_edit').attr("action");
    var json = { "id" : $('#absoluteResult_id_edit').val(),
    		     "fineValue" : fine_value,
    		     "comment" : fine_value +' '+ $('#comment_edit').val(),
    		   };
	$.ajax({
        url: url,
        data: JSON.stringify(json),
        contentType: 'application/json',
        type: "POST",
        success: function(response) {
        	$('#changeConcreteResult').modal('hide');
        	location.reload();
        }
    });
	return false;
});

	
});
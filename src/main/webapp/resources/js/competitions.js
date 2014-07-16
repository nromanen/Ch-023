$(document).ready(function(){
	
	$('#show_by_year').click(function(){
		var url = $("#competition_list_url").val() + "/" + $("#years").val();
		$(location).attr('href', url);
	});
	
});
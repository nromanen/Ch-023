$(document).ready(function(){
	
	$('#years').change(function(){
		var url = $("#competition_list_url").val() + "/" + $("#years").val() + "/1";
		$(location).attr('href', url);
	});
	
	if (document.URL.indexOf("all") >= 0) {
		$('#results_per_page').css("display", "inline-block");
		$('#results_per_page_btn').css("display", "inline-block");
		var competitionsPerPage = $('#competitionsPerPage').val();
		var countOfCompetitions = $('#countOfCompetitions').val();
		var page = $('#page').val();
		var element = "";
		for (var i = 1; i <= Math.ceil(countOfCompetitions/competitionsPerPage); i++) {
			var classes = "pagination-link btn ";
			if (i == +page) {
				classes += "btn-primary";
			}
			else {
				classes += "btn-default";
			}
			element+="<a href='" + $("#competition_list_url").val() + "/" + $("#years").val() + "/" + i + "?competitionsPerPage="+competitionsPerPage + "'class='" + classes + "'>" + i + "</a>";
		}
		console.log(competitionsPerPage);
		$('#pagination_links').after(element);
	}
	else {
		$('#results_per_page').css("display", "none");
		$('#results_per_page_btn').css("display", "none");
	}
	$('#results_per_page_btn').click(function() {
		var url = $("#competition_list_url").val() + "/all/1/?competitionsPerPage=" + $('#results_per_page').val();
		$(location).attr('href', url);
	});
	
});
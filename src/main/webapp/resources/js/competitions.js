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
		var url = $("#competition_list_url").val() + "/all/";
		var competitionPerPageUrl = "?competitionsPerPage="+competitionsPerPage;
		var countOfPages = Math.ceil(countOfCompetitions/competitionsPerPage);
		if (countOfPages > 1) {
		if (page == 1 ) {
			element += "<a href='" + url + page + competitionPerPageUrl + "' class='" + page + "'>" + page + "</a>";
			element += "<a href='" + url + (+page+1) + competitionPerPageUrl + "' class='" + (+page+1) + "'>" + (+page+1) + "</a>";
		} else if (page > 1 && page < countOfPages) {
			element += "<a href='" + url + (page-1) + competitionPerPageUrl + "' class='" + (page-1) + "'>" + (page-1) + "</a>";
			element += "<a href='" + url + page + competitionPerPageUrl + "' class='" + page + "'>" + page + "</a>";
			element += "<a href='" + url + (+page+1) + competitionPerPageUrl + "' class='" + (+page+1) + "'>" + (+page+1) + "</a>";
		} else if (page == countOfPages) {
			element += "<a href='" + url + (page-1) + competitionPerPageUrl + "' class='" + (page-1) + "'>" + (page-1) + "</a>";
			element += "<a href='" + url + page + competitionPerPageUrl + "' class='" + page + "'>" + page + "</a>";
		}
		} else {
			element += "<a href='" + url + page + competitionPerPageUrl + "' class='" + page + "'>" + page + "</a>";
		}
		if (page > 3) {
			element = "..." + element;
		}
		if (countOfPages - page > 2) {
			element += "...";
		}
		if (page > 2) {
			element = "<a href='" + url + "1" + competitionPerPageUrl + "' class='1'>1</a>" + element;
		}
		if (countOfPages - page > 1) {
			element += "<a href='" + url + countOfPages + competitionPerPageUrl + "' class='" + countOfPages + "'>" + countOfPages + "</a>";
		}
		
		$('#pagination_links').after(element);
		for (var i = 1; i <= countOfPages; i++) {
			
			if (i == +page) {
				$('.' + i).addClass("pagination-link btn btn-primary");
			}
			else {
				$('.' + i).addClass("pagination-link btn btn-default");
			}
		}
		
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
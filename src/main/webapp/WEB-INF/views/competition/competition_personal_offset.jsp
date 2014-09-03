<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="custom" tagdir="/WEB-INF/tags" %>
<style>
	.vertical {
		-moz-transform: rotate(90deg);
    	-webkit-transform: rotate(90deg);
    	-o-transform: rotate(90deg);
    	writing-mode: tb-rl;
	}
	th {
		height: 50px;
		text-align: center;
		vertical-align: middle !important;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
    $(".pdf").click(function() {
    	var id = this.id.replace("pdf", "");
    	var url = $('#personal_url').val();
    	var table = $('#table_personal_offset' + id).html();
    	table = "<style>table{ font-size: 14;} .teamName {width: 130px;}</style>" + table;
    	$.ajax({
            url: url,
            type: "POST",
            data: {
                table: table,
                carClassCompetitionId: id
            },
            success: function(response) {
                if (response !== '0') {
                	$('#table_personal_offset' + id).css("font-size","14 !important");
                	window.open("../../document/showFile/" + response ,'_blank');
                }
            }
        });
    });
});
</script>
<div>
    <input type="hidden" id="personal_url" value="<c:url value="/SHKP/personal" />">
	<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${carClassCompetitions.get(0).competition.name}</label>			
	<c:forEach items="${carClassCompetitions }" var="carClassCompetition" varStatus="loop">
	<c:if test="${!empty carClassCompetition.racerCarClassCompetitionNumbers }">
	<button id="pdf${ carClassCompetition.id}" class="btn btn-sml btn-success pdf"><spring:message code="label.document_download_pdf" /></button>
	<div id="table_personal_offset${ carClassCompetition.id}">
	<meta charset="utf-8">
	<style>
       table {
           font-family: "Arial", Times, monospace;
       }
    </style>
	<table class="table table-hover table-bordered" style="text-align: center;" border="1">
		<caption class="text-left">${carClassCompetition.carClass.name }</caption>
		<thead class="well" style="font-weight: 100;">
			<tr>
				<th rowspan="2">№</th>
				<th rowspan="2"><spring:message code="label.lastname_firstname" /></th>
				<th rowspan="2"><spring:message code="label.command_city" /></th>
				<th rowspan="2" class="teamName"><spring:message code="sportcategory.sport_category" /></th>
				<th rowspan="2"><spring:message code="label.start_number" /></th>
				<th colspan="2"><spring:message code="label.control_race" /></th>
				<th colspan="3" class="teamName"><spring:message code="label.first_final_race" /></th>
				<th colspan="3" class="teamName"><spring:message code="label.second_final_race" /></th>
				<th rowspan="2"><spring:message code="label.points_sum" /></th>
				<th rowspan="2"><spring:message code="label.competition.place_in_race" /></th>
			</tr>
			<tr>
				<th ><spring:message code="label.time" /></th>
				<th ><spring:message code="label.competition.place_in_race" /></th>
				<th ><spring:message code="label.laps" /></th>
				<th ><spring:message code="label.competition.place_in_race" /></th>
				<th ><spring:message code="label.points" /></th>
				<th ><spring:message code="label.laps" /></th>
				<th ><spring:message code="label.competition.place_in_race" /></th>
				<th ><spring:message code="label.points" /></th>
			</tr>
		</thead>
		<% int number=1; %>
		<tbody>
			<c:forEach items="${carClassCompetition.racerCarClassCompetitionNumbers }" var="racerCarClassCompetitionNumber">
				<tr>
					<td><%=number %></td>
					<td><a href="<c:url value="/racer/${racerCarClassCompetitionNumber.racer.id}" />">${racerCarClassCompetitionNumber.racer.firstName } ${racerCarClassCompetitionNumber.racer.lastName }</a></td>
					<td class="teamName">${racerCarClassCompetitionNumber.racer.team.name }</td>
					<custom:sportCategory value='${racerCarClassCompetitionNumber.racer.sportsCategory}' />
					<td>${racerCarClassCompetitionNumber.numberInCompetition }</td>
					<c:set  var="qualifyingList" value="${qualifyingLists[loop.index]}" />
							<c:choose>
								<c:when test="${!empty qualifyingList }">
									<c:forEach items="${qualifyingList}" var="qualifying">
										<c:if test="${qualifying.racerNumber==racerCarClassCompetitionNumber.numberInCompetition }">
											<td>${qualifying.racerTime}</td>
											<td>${qualifying.racerPlace}</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td></td>
									<td></td>
								</c:otherwise>
							</c:choose>
					<c:set var="countOfResults"	 value="2" />
					<c:forEach items="${raceResultsLists}" var="raceResultsList">
						<c:forEach items="${raceResultsList}" var="raceResults">
							<c:forEach items="${raceResults}" var="raceResult">
							<c:if test="${(racerCarClassCompetitionNumber.racer.id == raceResult.racer.id) && (carClassCompetition == raceResult.race.carClassCompetition) }">
								<td>${raceResult.fullLaps}</td>
								<td>${raceResult.place}</td>	
								<td>${raceResult.points}</td>
								<c:set var="countOfResults"	 value="${countOfResults-1 }" />
							</c:if>
							</c:forEach>
						</c:forEach>
					</c:forEach>
					<c:forEach begin="1" end="${countOfResults*3 }">
						<td></td>
					</c:forEach>
					<c:set var="existAbsolute" value="false" />
					<c:forEach items="${absoluteResultsList }" var="absoluteResults" >
						<c:forEach items="${absoluteResults }" var="absoluteResult" >
						<c:if test="${(racerCarClassCompetitionNumber.racer.id == absoluteResult.racerCarClassCompetitionNumber.racer.id) && (carClassCompetition == absoluteResult.racerCarClassCompetitionNumber.carClassCompetition) }">
							<td>${absoluteResult.absolutePoints}</td>
							<td>${absoluteResult.absolutePlace}</td>
							<c:set var="existAbsolute" value="true" />
						</c:if>
						</c:forEach>
					</c:forEach>
					<c:if test="${!existAbsolute}">
						<td></td>
						<td></td>
					</c:if>
				</tr>
				<% number++; %>
			</c:forEach>
			
			
		</tbody>
	</table>
	</div>
	</c:if>
	</c:forEach>
			
</div>

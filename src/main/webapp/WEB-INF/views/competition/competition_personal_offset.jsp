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
<div>

	<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${carClassCompetitions.get(0).competition.name}</label>			
	<c:forEach items="${carClassCompetitions }" var="carClassCompetition" varStatus="loop">
	<c:if test="${!empty carClassCompetition.racerCarClassCompetitionNumbers }">
	<table class="table table-hover table-bordered" style="text-align: center;">
		<caption class="text-left">${carClassCompetition.carClass.name }</caption>
		<thead class="well" style="font-weight: 100;">
			<tr>
				<th rowspan="2">№</th>
				<th rowspan="2"><spring:message code="label.lastname_firstname" /></th>
				<th rowspan="2"><spring:message code="label.command_city" /></th>
				<th rowspan="2"><spring:message code="sportcategory.sport_category" /></th>
				<th rowspan="2"><spring:message code="label.start_number" /></th>
				<th colspan="2"><spring:message code="label.control_race" /></th>
				<th colspan="3"><spring:message code="label.first_final_race" /></th>
				<th colspan="3"><spring:message code="label.second_final_race" /></th>
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
					<td>${racerCarClassCompetitionNumber.racer.team.name }</td>
					<custom:sportCategory value='${racerCarClassCompetitionNumber.racer.sportsCategory}' />
					<td>${racerCarClassCompetitionNumber.numberInCompetition }</td>
					<c:forEach items="${qualifyingLists}" var="qualifyingList" varStatus="qLoop">
						<c:if test="${qLoop.index==loop.index}">
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
						</c:if>
					</c:forEach>
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
	</c:if>
	</c:forEach>
			
</div>

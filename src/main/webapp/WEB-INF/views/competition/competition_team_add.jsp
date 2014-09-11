<%@ page import="java.io.*,java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type='text/javascript'
	src="<c:url value="/resources/js/filter.js" />"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/competition_add_team.js" />'></script>
<h2 class="user-info-name text-center" id="${team.id}">
	<spring:message code="label.registration_for_competition" />
</h2>
<!-- Checks whether competition was chosen-->
<input type="text" style="visibility: hidden" id="competitionId"
	value="${ competitionId}">
<input type="text" style="visibility: hidden" id="teamId"
	value="${team.id}">
<c:choose>
	<c:when test="${isTeamInCompetition==false && competitionEnabled}">
		<form name="new_team_in_competition" id="new_team_in_competition"
			style="width: 100%">
			<label class="text-info"
				style="font-size: 20px; width: 100%; text-align: center;">
				${competitionName}</label> <a
				href='<c:url value="/competition/chooseCompetition" />'
				class="btn btn-primary"><spring:message
					code="label.choose_competition_button" /></a> <a href="#"
				id="uncheck_all" class="btn btn-danger"
				style="margin-bottom: 3px; float: right;"><spring:message
					code="label.uncheck_all" /></a>

			<table id="team-table" class="table table-bordered">
				<thead style="font-weight: 100;">
					<tr class="well">
						<th class="text-center">№</th>
						<th><spring:message code="label.racer" /></th>
						<c:if test="${!empty carClassesByCompetition}">
							<c:forEach var="i" begin="0"
								end="${carClassesByCompetition.size()-1}">
								<th class="text-center" colspan="2"><c:out
										value="${carClassesByCompetition.get(i).carClass.name}" /></th>
							</c:forEach>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${team.racers}" var="racer" varStatus="number">
						<tr>
							<td class="text-center">${number.count }</td>
							<td class="text-left"><a
								href='<c:url value="/racer/${racer.id}" />'>
									${racer.firstName} ${racer.lastName} </a></td>
							<c:if test="${!empty carClassesByCompetition}">
								<c:forEach var="i" begin="0"
									end="${carClassesByCompetition.size()-1}">

									<%
										boolean isClass = false;
									%>
									<c:if test="${!empty racer.carClassNumbers}">
										<c:forEach items="${racer.carClassNumbers}"
											var="racerCarClassNumber">
											<c:if
												test="${carClassesInCompetitionlist.contains(racerCarClassNumber.carClass) && racerCarClassNumber.carClass.equals(carClassesByCompetition.get(i).carClass) && racer.isRacerSuitableToCarClass(racerCarClassNumber.carClass) && racer.isEnabled()}">
												<%
													isClass = true;
												%>
												<td class="text-center"><span class="text-success">
														${racerCarClassNumber.number} </span></td>
												<td class="text-center"><input type="checkbox"
													class="racer_car_class_competition_number"
													checked="checked"
													id="${racer.id},${carClassesByCompetition.get(i).id},${racerCarClassNumber.number}"></td>
											</c:if>
										</c:forEach>
									</c:if>
									<%
										if (isClass == false) {
									%>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<%
										}
									%>
								</c:forEach>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br>
			<div style="width: 100%;">
				<input type="submit" class="btn btn-primary btn-lg"
					value="<spring:message code="label.accept" />"
					id="add_team_for_competition"> <img
					src='<c:url value="/resources/img/ajax-loader.gif" />'
					style="display: none;" id="ajax_loader">
			</div>
		</form>
	</c:when>
	<c:when test="${isTeamInCompetition}">
		<br>
		<br>
		<div class="alert alert-warning">
			<strong><spring:message code="label.warning" /></strong>
			<spring:message code="message.already_registered_for_competition" />
		</div>
	</c:when>
	<c:when test="${competitionEnabled==false}">
		<br>
		<br>
		<div class="alert alert-warning">
			<strong><spring:message code="label.warning" /></strong>
			<spring:message code="message.competition_closed_for_registration" />
		</div>
	</c:when>
</c:choose>
<!-- If none racer isn't chosen, this dialog will shown-->
<div class="modal fade" id="not_registered_modal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="margin-top: 10%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="label.warning" />
				</h4>
			</div>
			<div class="modal-body">
				<spring:message code="message.competition_registration_fail" />
			</div>
			<div class="modal-footer">
				<button type="button" id="not_registered_back"
					class="btn btn-default" data-dismiss="modal">
					<spring:message code="label.back" />
				</button>
				<a
					href='<c:url value="/competition/${ competitionId}" />'
					class="btn btn-primary"><spring:message code="label.accept" /></a>
			</div>
		</div>
	</div>
</div>
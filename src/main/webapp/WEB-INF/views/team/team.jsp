<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="<c:url value="/resources/js/lib/bootbox.js" />"></script>
<script type='text/javascript' src='<c:url value="/resources/js/team.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 40px 20px 40px;">

	<table class="width-100">
		<tr>
			<td><h2 class="user-info-name">${needTeam.name}</h2></td>
			<td style="padding: 15px 0px 0px 20px;">
				<div class="btn-group fl-right">
					<c:if test="${authority.equals('ROLE_TEAM_LEADER')}">
						<c:if test="${needTeam.id==team.id}">
							<a href='<c:url value="/team/edit/${needTeam.id}" />' class="btn btn-info"><spring:message code="label.edit" /></a>
							<a href="#" class="btn btn-danger" id="delete_team_btn"><spring:message code="label.delete" /></a>

						</c:if>
					</c:if>
				</div>
			</td>
		</tr>
	</table>
	<br>
	<div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<label class="text-info" style="color: #fff; font-size: 16px;"><spring:message code="label.team_info" /></label>
			</div>
			<div class="panel-body">
				<div>
					<label class="text-info"><spring:message code="label.address" />:&nbsp;</label>${needTeam.address}</div>
				<div>
					<label class="text-info"><spring:message
				code="label.license_number" />:&nbsp;</label>${needTeam.license}</div>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">
				<label class="text-info" style="color: #fff; font-size: 16px;"><spring:message code="label.leader_info" /></label>
			</div>
			<div class="panel-body">
				<div>
					<label class="text-info"><spring:message
				code="label.lastname_firstname" />:&nbsp;</label>
				<a href="<c:url value="/leader/${needTeam.leader.id}" />">
					${needTeam.leader.firstName} ${needTeam.leader.lastName}
					</a>
				</div>
				<div>
					<label class="text-info"><spring:message
				code="label.date_of_birth" />:&nbsp;</label>
					<fmt:formatDate value="${needTeam.leader.birthday}"
						pattern="dd-MM-yyyy" />
				</div>
				<div>
					<label class="text-info"><spring:message
				code="label.identification" />:&nbsp;</label>${needTeam.leader.document}</div>
				<div>
					<label class="text-info"><spring:message
				code="label.address" />:&nbsp;</label>${needTeam.leader.address}</div>
				<div>
					<label class="text-info"><spring:message
				code="label.license_number" />:&nbsp;</label>${needTeam.leader.license}</div>
			</div>
		</div>
	</div>
	<div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<label class="text-info" style="color: #fff; font-size: 16px;"><spring:message
				code="label.racers" /></label>
			</div>
			<div class="panel-body" style="padding: 0px;">
				<input type="hidden" id="enable_url"
					value="<c:url value="/racer/setEnabled"/>">
				<table class="table table-hover table-bordered"
					style="text-align: center;">
					<tr class="well">
						<td>№</td>
						<td><spring:message code="label.racer" /></td>
						<td><spring:message code="label.enable" /></td>
						<td><spring:message code="label.car_classes" /></td>
						<td><spring:message code="label.age" /></td>
					</tr>
					<c:forEach items="${needTeam.racers}" var="racer" varStatus="racerNumber">
						<tr>
							<td style="width: 4%;">${racerNumber.count }</td>
							<td style="text-align: left;"><a
								href='<c:url value="/racer/${racer.id}"/>'>
									${racer.firstName} ${racer.lastName} </a></td>
							<td style="width: 10%;"><input type="checkbox"
								id="enabled${racer.id}" class="enabled"
								<c:if test="${racer.enabled == true}"> checked</c:if>
								<c:if test="${(authority != 'ROLE_TEAM_LEADER') || (needTeam.id != team.id)}">
										disabled
									</c:if> />
							</td>
							<td><c:forEach items="${racer.carClassNumbers}"
									var="carClassNumber">
									<b>${carClassNumber.carClass.name}</b>(№${carClassNumber.number})
								</c:forEach></td>
							<td>${racer.getAge()}</td>
						</tr>
					</c:forEach>
				</table>
				<c:if
					test="${(authority == 'ROLE_TEAM_LEADER') && (needTeam.id == team.id)}">
					<div style="width: 100%; text-align: center; margin-bottom: 15px;">
						<a href='<c:url value="/racer/add" />' class="btn btn-primary"><spring:message code="label.add_racer" /></a>
					</div>
				</c:if>
			</div>
		</div>
	</div>


	<div style="margin-top: 15px;">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<label class="text-info" style="color: #fff; font-size: 16px;">
					<spring:message code="label.registrated_competitions" />: </label>
			</div>
			<div class="panel-body" style="padding: 0px;">
				<table class="table table-hover table-bordered"
					style="text-align: center;">
					<tr class="well">
						<td style="width: 4%;">№</td>
						<td><spring:message code="label.competition" /></td>
						<td><spring:message code="label.problems" /></td>
						<td><spring:message code="label.start_date" /></td>
						<td><spring:message code="label.end_date" /></td>
						<c:if test="${(authority == 'ROLE_TEAM_LEADER') && (needTeam.id == team.id) }">
						    <td></td> 
						</c:if>
					</tr>
					<c:if test="${!empty isValidTeamInCompetitionMap}">
						<c:forEach items="${isValidTeamInCompetitionMap}"
							var="isValidTeamInCompetition" varStatus="competitionNumber">
							<tr>
								<td>${competitionNumber.count }</td>
								<td style="text-align: left;"><a
									href='<c:url value="/competition/${isValidTeamInCompetition.key.competition.id}"/>'>
										${isValidTeamInCompetition.key.competition.name} </a></td>
								<td><c:choose>
										<c:when test="${isValidTeamInCompetition.value}">
											<img class="team_valid_icon" style="cursor: pointer;"
												title="OK" src="<c:url value="/resources/img/ok.png" />">
										</c:when>
										<c:otherwise>
											<a
												href="<c:url value="/competition/${isValidTeamInCompetition.key.competition.id}/mandat?team=${isValidTeamInCompetition.key.team.id}" />">
												<img class="team_valid_icon" title="Warning"
												src="<c:url value="/resources/img/warning.png" />">
											</a>
										</c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate
										value="${isValidTeamInCompetition.key.competition.dateStart}"
										pattern="dd-MM-yyyy" /></td>
								<td><fmt:formatDate
										value="${isValidTeamInCompetition.key.competition.dateEnd}"
										pattern="dd-MM-yyyy" /></td>
							    <c:if test="${(authority == 'ROLE_TEAM_LEADER') && (needTeam.id == team.id) }">
                                    <td>
                                        <button class="btn btn-danger btn-xs unregister_team" 
                                            id="unregister_team_btn${isValidTeamInCompetition.key.competition.id }"><spring:message code="label.unregister" /></button>
                                    </td>
                                </c:if>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<c:if
					test="${(authority == 'ROLE_TEAM_LEADER') && (needTeam.id == team.id)}">
					<div style="width: 100%; text-align: center; margin-bottom: 15px;">
						<a href='<c:url value="/competition/chooseCompetition" />'
							class="btn btn-primary"><spring:message code="label.registration_for_competition" /></a>
					</div>
				</c:if>
			</div>
		</div>
	</div>


</div>

<div class="modal fade" id="delete_team_modal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.delete_team" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info">
					<spring:message code="message.question_delete_team" />?
				</label>
				<input type="hidden" id="team_delete_url" value="<c:url value="/team/delete" />">
				<input type="hidden" id="team_delete_id" value="${needTeam.id}">
				<br><br>
				<div class="alert alert-danger" id="delete_error"
					style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
					<spring:message code="message.question_delete_team_warning" />
				</div>
				<input type="hidden" id="delete_redirec_url" value="<c:url value="/leader/${needTeam.leader.id}" />">
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete">
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
				<button class="btn btn-primary" type="button" id="delete_team"><spring:message code="label.accept" /></button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="unregister_team_modal" tabindex="-1"
    role="dialog">
    <div class="modal-dialog" style="margin-top: 10%;">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal">x</button>
                <h4 class="modal-title"><spring:message code="label.unregister_team_from_competition" /></h4>
            </div>
            <div class="modal-body">
                <label class="text-info">
                    <spring:message code="label.unregister_team_from_competition_confirm" />
                </label>
                <input type="hidden" id="team_unregister_url" value="<c:url value="/competition/unregisterTeam" />">
                <input type="hidden" id="team_unregister_id" value="${needTeam.id}">
                <br><br>
                <div class="alert alert-danger" id="unregister_error"
                    style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
                    <spring:message code="message.unregister_team_from_competition_wrong" />
                </div>
                <img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete">
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
                <button class="btn btn-primary" type="button" id="unregister_team"><spring:message code="label.accept" /></button>
            </div>
        </div>
    </div>
</div>

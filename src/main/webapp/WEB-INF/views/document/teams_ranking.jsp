<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type='text/javascript' src='<c:url value="/resources/js/teams_ranking.js" />'></script>

<span align="right"><a class="btn btn-success btn-sm" id="pdf" ><spring:message code="label.document_download_pdf" /></a></span>
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="competitionId" value="${competition.id}">
<div align="center" id="absRanking">
<meta charset="utf-8">
<style>
    table {
        font-family: 'Arial', Arial, monospace;
    }
    span {
        font-family: 'Arial', Arial, monospace;
    }
</style>
    <table width="100%" align="center" cellspacing='0' cellpadding='2'>
            <tr>
                <td align='center'>
                   <span style="font-weight:bold;font-size:18pt"><spring:message code="label.ministry_of_education" /></span><p>
                   <span style="font-weight:bold;font-size:18pt"><spring:message code="label.state_center" /></span><p>
                   <span style="font-weight:bold;font-size:18pt;"><c:out value="${competition.name}"/></span>
                </td>
            </tr>
    </table>
    <table width="100%">
            <tr>
                <td align='left'><span><c:out value="${competition.place}"/></span></td>
                <td align='right'><span><c:out value="${competitionDate}"/></span></td>
            </tr>
    </table>
    <table width="100%" align="center">
        <thead>
        <tr>
            <td align='center'>
                <span style="font-weight:bold;font-size:18pt"><spring:message code="label.maneuver_protocol" /></span><p>
            </td>
        </tr>
        </thead>
    </table>
<table width="100%" align="center" >
	<c:if test="${!empty teamList}">
		<tr>
			<td>
				<table class="table table-hover table-bordered" id="racers_table" border="1"
					style="text-align: center;">
					<thead class="well">
						<tr>
							<th style="text-align: center;" rowspan="2">№</th>
							<th style="text-align: center;" rowspan="2">Team name</th>
							<th style="text-align: center;" colspan="2">ShKP</th>
							<th style="text-align: center;" colspan="2">Maneuver</th>
							<th style="text-align: center;" colspan="2">Total</th>
						</tr>
						<tr>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" var="absTeamRes" varStatus="index">
							<tr>
								<td class="pos">${index.count}</td>
								<td style="text-align: left; padding-left: 20px;">
									<a href="<c:url value="/team/${absTeamRes.teamId}" />">
										<c:forEach items="${teamList}" var="team">
											<c:if test="${team.id==absTeamRes.teamId}">
												${team.name}
											</c:if>
										</c:forEach>
									</a> 
								</td>
								<td class = "points">
									<c:if test="${absTeamRes.shkpPointPlace.points!=0}">
										${absTeamRes.shkpPointPlace.points}
									</c:if>
								</td>
								<td class="place">
									<c:if test="${absTeamRes.shkpPointPlace.place!=0}">
										${absTeamRes.shkpPointPlace.place}
									</c:if>
								</td>
								<td class = "points">
									<c:if test="${absTeamRes.maneuverPointPlace.points!=0}">
										${absTeamRes.maneuverPointPlace.points}
									</c:if>
								</td>
								<td class="place">
									<c:if test="${absTeamRes.maneuverPointPlace.place!=0}">
										${absTeamRes.maneuverPointPlace.place}
									</c:if>
								</td>
								<td class = "points">
									<c:if test="${absTeamRes.absolutePointPlace.points!=0}">
										${absTeamRes.absolutePointPlace.points}
									</c:if>
								</td>
								<td class="place">
									<c:if test="${absTeamRes.absolutePointPlace.place!=0}">
										${absTeamRes.absolutePointPlace.place}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<label class="text-info"><spring:message code="label.competition.secretary_name" />:&nbsp;</label>
				${competition.secretaryName}
			</td>
		</tr>
		<tr>
			<td>
				<label class="text-info"><spring:message code="label.competition.director_name" />:&nbsp;</label>
				${competition.directorName}
			</td>
		</tr>
	</c:if>
</table>
</div>


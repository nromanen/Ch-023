<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type='text/javascript' src='<c:url value="/resources/js/teams_ranking.js" />'></script>
<script type='text/javascript' src="<c:url value="/resources/js//lib/jquery.tablesorter.min.js" />"></script>

<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${competition.name}</label>
<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;"><spring:message code="label.teams_ranking_protocol" /></label>
<c:if test="${authority=='ROLE_ADMIN'}">
    <span align="right"><a class="btn btn-success btn-sm" id="pdf" ><spring:message code="label.document_download_pdf" /></a></span>
</c:if>
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="competitionId" value="${competition.id}">
<div align="center" id="absRanking">
<meta charset="utf-8">
<style>
    table {
        border-collapse:collapse;
        font-family: 'Arial', Arial, monospace;
    }
       .table thead tr th {
         background-repeat: no-repeat;
         background-position: 100% 50%;
       }
       .table thead tr th.headerSortUp {
          background-image: url(<c:url value="/resources/img/sort_asc.png" />);
        }
        .table thead tr th.headerSortDown {
            background-image: url(<c:url value="/resources/img/sort_desc.png" />);
        }
    span {
        font-family: 'Arial', Arial, monospace;
    }
</style>
   <table class="table table-hover table-bordered main_table" id="racers_table" border="1" style="text-align: center;">
                    <thead class="well" style="font-weight: 100;">
            <tr style="display: none;">
                <th align='center' colspan="8">
                   <span style="font-weight:bold;font-size:16pt"><spring:message code="label.ministry_of_education" /></span>
                   </th>
            </tr>
            <tr style="display: none;">
             <th align='center' colspan="8">
                   <span style="font-weight:bold;font-size:16pt"><spring:message code="label.state_center" /></span>
                </th>
                </tr>
            <tr style="display: none;">
                <th align='left' colspan="2"><span><c:out value="${competition.place}"/></span></td>
                <th align='right' colspan="6"><span><c:out value="${competitionDate}"/></span></td>
            </tr>
        <tr style="display: none;">
            <th align='center' colspan="8">
                <span style="font-weight:bold;font-size:18pt"><spring:message code="label.teams_ranking_protocol" /></span><p>
            </th>
        </tr>
        <tr style="display: none;" >
            <th colspan = "8">
                <span style="font-weight:bold;font-size:18pt;"><c:out value="${competition.name}"/></span>
            </th>
        </tr>
            
	   <c:if test="${!empty teamList}">
						<tr>
							<th  class="column-sm" style="text-align: center;" rowspan="2">№</th>
							<th style="text-align: center;" rowspan="2"><spring:message code="label.team_name"/></th>
							<th style="text-align: center;" colspan="2"><spring:message code="label.race_results"/></th>
							<th style="text-align: center;" colspan="2"><spring:message code="label.maneuver_results"/></th>
							<th style="text-align: center;" colspan="2"><spring:message code="label.total_results"/></th>
						</tr>
						<tr>
							<th style="text-align: center;"><spring:message code="label.points"/></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race"/></th>
							<th style="text-align: center;"><spring:message code="label.points"/></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race"/></th>
							<th style="text-align: center;"><spring:message code="label.points"/></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race"/></th>
						</tr>
						</thead>
					   <tbody>
						<c:forEach items="${resultList}" var="absTeamRes" varStatus="index">
							<tr>
								<td class="pos">${index.count}</td>
								<td class="team_name" style="text-align: left; padding-left: 20px;">
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
					
		<tr style="display: none;">
			<td colspan="2">
				<label class="text-info"><spring:message code="label.competition.secretary_name" />:&nbsp;</label>
			</td>
			<td colspan="6">
			     ${competition.secretaryName}
			</td>
		</tr>
		<tr style="display: none;">
			<td colspan="2">
				<label class="text-info"><spring:message code="label.competition.director_name" />:&nbsp;</label>
			</td>
            <td colspan="6">
				${competition.directorName}
			</td>
		</tr>
		</tbody>
	</c:if>
</table>
</div>


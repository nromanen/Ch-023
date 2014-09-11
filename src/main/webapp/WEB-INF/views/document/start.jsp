<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type='text/javascript'
	src='<c:url value="/resources/js/start.js" />'></script>
<c:choose>
<c:when test="${authority.equals('ROLE_ADMIN') && !empty racerCarClassCompetitionNumberList}">
	<div class="panel panel-primary">
		<div class="panel-heading" style="height: 50px;">
			<div class="text-info"
				style="color: #fff; font-size: 20px; float: left;">
				<spring:message code="label.registered_racers" />
			</div>
		</div>
		<div class="panel-body" style="padding: 0px;">
			<c:choose>
				<c:when test="${!empty racerCarClassCompetitionNumberList}">
					<table class="table table-hover table-bordered" id="racers_table"
						style="text-align: center;">
						<thead class="well">
							<th style="text-align: center;">№</th>
							<th style="text-align: center;"><spring:message
									code="label.racer" /></th>
							<th style="text-align: center;"><spring:message
									code="label.number" /></th>
							<th style="text-align: center;"><spring:message
									code="label.document_start_pos" /></th>
						</thead>
						<tbody>
							<c:forEach items="${racerCarClassCompetitionNumberList}"
								var="racerCarClassCompetitionNumber" varStatus="index">
								<tr
									class="team${racerCarClassCompetitionNumber.racer.team.id}
									<c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">bg-danger</c:if>">
									<td>${index.count}</td>
									<td style="text-align: left; padding-left: 20px;"><a
										href="<c:url value="/racer/${racerCarClassCompetitionNumber.racer.id}" />"
										id="racer${racerCarClassCompetitionNumber.racer.id}">
											${racerCarClassCompetitionNumber.racer.firstName}
											${racerCarClassCompetitionNumber.racer.lastName} </a> <c:if
											test="${!racerCarClassCompetitionNumber.racer.enabled}">
											<span class="glyphicon glyphicon-remove"
												style="color: red; cursor: pointer; float: right;"
												title="Disabled"></span>
										</c:if></td>
									<td>${racerCarClassCompetitionNumber.numberInCompetition}
									</td>
									<td>
										<c:choose>
											<c:when test="${!empty qualifyingList}">
												${qualifyingList.get(index.index).racerPlace}
											</c:when>
											<c:otherwise>
												<input type="text" class="carPos"
												racer="${racerCarClassCompetitionNumber.numberInCompetition}"
												pattern="[0-9]{2}">
											</c:otherwise>
										</c:choose>	
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div style="text-align: center;">
						<c:if test="${empty qualifyingList}">
							<a class="btn btn-sml btn-primary" id="save">
								<spring:message code="label.accept_changes" /></a>
						</c:if>
						<a class="btn btn-sml btn-success" id="pdf" <c:if test="${empty qualifyingList}">disabled</c:if>>
						<spring:message code="label.document_download_pdf" /></a>
						<c:if test="${oldDoc > 0}">
							<a id="prevVersion" class="btn btn-sml btn-warning"
								href="../../../document/showFile/${oldDoc}" target="_blank"><spring:message
									code="label.previous_version_pdf" /></a>
						</c:if>
						<p>
					</div>
					<div class="alert alert-danger"
						style="display: none; margin-top: 5px;" id="no_racers">
						<spring:message code="label.there_are_no_racers_from_your_team" />
					</div>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger"
						style="margin-top: 10px; margin-left: 5px;">
						<spring:message code="label.racers_list_for_this_class_is_empty" />
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
<div class="alert alert-danger" id="incorrectPositions"
	style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
	<spring:message code="dataerror.document_start_incorrect_postions" />
</div>
<div class="alert alert-success" id="correctPositions"
	style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
	<spring:message code="label.data_save_success" />
</div>
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="raceId" value="${raceId}">
<input type="hidden" id="startId" value="${startId}">
<input type="hidden" id="maxPos" value="${maxPositions}">
<div id='table'>
	<meta charset="utf-8">
	<style>
table {
	font-family: "Arial", Arial, monospace;
}

.place {
	font-size: 200%;
	font-family: monospace;
	position: relative;
	left: 20px;
	text-decoration: underline;
}
</style>
	<table style="width: 100%" border='1' cellspacing='0' cellpadding='2'>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'> <c:out value="${competitionName}" /> </td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'><c:out value="${competitionName}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'><c:out value="${competitionLoc}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'><c:out value="${competitionLoc}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'><c:out
								value="${competitionDate}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'><c:out value="${competitionDate}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'>
							<spring:message code="label.car_class" />: <b><c:out value="${carClassName}" /></b>
						</td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'>
							<spring:message code="label.car_class" />:<b><c:out value="${carClassName}" /></b>
						</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'>
							<spring:message code="label.date" />: <c:out value="${carClassDate}" /> 
							<spring:message code="label.time" />: <c:out value="${carClassTime}" />
						</td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'>
							<spring:message code="label.date" />: <c:out value="${carClassDate}" /> 
							<spring:message code="label.time" />: <c:out value="${carClassTime}" />
						</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td align='center' colspan='2'><spring:message
								code="label.run" /> <c:out value="${carClassRace}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" align='center' colspan='2'><spring:message
								code="label.run" /> <c:out value="${carClassRace}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td colspan='2' align='center'><b><spring:message
									code="label.start_statement" /></b></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" colspan='2' align='center'><b><spring:message
									code="label.start_statement" /></b></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<c:forEach var="i" begin="1" end="${maxPositions}" step="2">
			<c:set var="j" value="${maxPositions-i+1}" />
			<c:set var="k" value="${maxPositions-i}" />
			<tr>
				<c:forEach var="i" begin="1" end="${tableRows}">
					<c:choose>
						<c:when test="${i == 1}">
							<td width='25%'>
							<c:out value="${j}" />)<span class="place p${j}">
								<c:forEach items="${qualifyingList}" var="qualifying">
									<c:if test="${qualifying.racerPlace==j}">${qualifying.racerNumber}</c:if>
								</c:forEach>
							</span></td>
							<td width='25%'><c:out value="${k}" />)<span class="place p${k}">
								<c:forEach items="${qualifyingList}" var="qualifying">
									<c:if test="${qualifying.racerPlace==k}">${qualifying.racerNumber}</c:if>
								</c:forEach>
							</span></td>
						</c:when>
						<c:otherwise>
							<td style="display: none;" width='25%'><c:out value="${j}" />)<span
								class="place p${j}"></span></td>
							<td style="display: none;" width='25%'><c:out value="${k}" />)<span
								class="place p${k}"></span></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td colspan='2'><spring:message code="label.allowed" /> <c:out
								value="${allowedNumber}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" colspan='2'><spring:message
								code="label.allowed" /> <c:out value="${allowedNumber}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td colspan='2'><spring:message code="label.started" /> <c:out
								value="${startedNumber}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" colspan='2'><spring:message
								code="label.started" /> <c:out value="${startedNumber}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${tableRows}">
				<c:choose>
					<c:when test="${i == 1}">
						<td colspan='2'><spring:message code="label.main_secretary" />
							<c:out value="${secretaryName}" /></td>
					</c:when>
					<c:otherwise>
						<td style="display: none;" colspan='2'><spring:message
								code="label.main_secretary" /> <c:out value="${secretaryName}" /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
	</table>
</div>
</c:when>
<c:otherwise>
	<div class="alert alert-danger" style="margin-top: 10px; margin-left: 5px;">
		<spring:message code="label.racers_list_for_this_class_is_empty" />
	</div>
</c:otherwise>
</c:choose>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="col-xs-6 col-sm-3 sidebar-offcanvas sidebar-nav-fixed" id="left" role="navigation" style="padding-left: 0px;">
	<div class="list-group">
		<label class="list-group-item list-group-item-info text-info text-center" 
		      style="font-size: 20px;"><spring:message code="label.competitions" /> ${currentYear}</label>
		<c:choose>
			<c:when test="${!empty competitionListByCurrentYear}">
				<c:forEach items="${competitionListByCurrentYear}" var="competition">
					<a href="<c:url value="/competition/${competition.id}" />" class="list-group-item">
						<!-- <span class="badge">14</span> -->
						<b><fmt:formatDate value="${competition.dateStart}" pattern="dd-MM-yyyy" /></b>
						&nbsp;${competition.name}
					</a>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<a href="#" class="list-group-item">
					<spring:message code="label.competition_empty_list" />
				</a>
			</c:otherwise>
		</c:choose>
	</div>
	<c:if test="${authority.equals('ROLE_ADMIN')}">
		<a href="<c:url value="/competition/add" />" class="btn btn-primary" style="width: 100%; margin-bottom: 5px;"><spring:message code="label.add_competition" /></a>
	</c:if>
	<br>	
	<c:if test="${authority.equals('ROLE_ADMIN')}">
	<c:choose>
			<c:when test="${!empty racers}"><br>
<label class="text-info" style="font-size: 20px; width: 100%; text-align: center;">
			<spring:message code="label.birthdays" />
		</label>
<table class="table table-hover table-bordered"
					style="text-align: center;">
					<tr class="well">
						<td><spring:message code="label.racer" /></td>
						<td><spring:message code="label.date_of_birth" /></td>
						<td><spring:message code="label.age" /></td>
					</tr>
					<%
						int racerNumber = 1;
					%>
					<c:forEach items="${racers}" var="racer">
					<fmt:formatDate value="${racer.birthday}" var="dateString" pattern="dd/MM/yyyy" />
						<tr>
							<td style="text-align: left;"><a
								href='<c:url value="/racer/${racer.id}"/>'>
									${racer.firstName} ${racer.lastName} </a></td>
							<td>${dateString}</td>
							<td>${racer.getAge()}</td>
						</tr>
						<%
							racerNumber++;
						%>
					</c:forEach>
				</table>
			</c:when>
		</c:choose>
</c:if>
	</div>
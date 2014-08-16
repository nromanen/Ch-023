<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


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

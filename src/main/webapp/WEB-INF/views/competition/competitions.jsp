<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type='text/javascript' src='<c:url value="/resources/js/competitions.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 20px;"> 
	<h2 class="user-info-name text-center">
		<spring:message code="label.competitions" />&nbsp;${year}&nbsp;
		<spring:message code="label.of_year" />
	</h2> 	
	<br><input type="hidden" id="competition_list_url" value="<c:url value="/competition/list" />">	
	<div class="row">
	  	<div class="col-lg-6 fl-right" style="width: 250px;">
	    	<div class="input-group">
		      	<select class="form-control" id="years">
					<c:if test="${!empty yearsList}">
						<c:forEach items="${yearsList}" var="yearItem">
							<option value="${yearItem}" 
								<c:if test="${yearItem == year}">
									selected
								</c:if>
							>${yearItem}</option>
						</c:forEach>
					</c:if>
				</select>
		      	<span class="input-group-btn">
		        	<button class="btn btn-success" type="button" id="show_by_year">
		        		<spring:message code="label.select_year" />
		        	</button>
		      	</span>
	    	</div>
	  	</div>
	</div>
	<br>
	<c:if test="${!empty competitionListByYear}">
		<c:forEach items="${competitionListByYear}" var="competition">
			<div class="panel panel-info">
				<div class="panel-heading">
					<a href='<c:url value="/competition/${competition.id}" />'>${competition.name}</a>
				</div>
				<div class="panel-body">
					<b><spring:message code="label.competition.place" />:</b>
					&nbsp;${competition.place}<br>
					<b><spring:message code="label.competition.start_date" />:</b>
					&nbsp;<fmt:formatDate value="${competition.dateStart}" pattern="yyyy-MM-dd" /><br>
					<b><spring:message code="label.competition.end_date" />:</b>
					&nbsp;<fmt:formatDate value="${competition.dateEnd}" pattern="yyyy-MM-dd" /><br>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
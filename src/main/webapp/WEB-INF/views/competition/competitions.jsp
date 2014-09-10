<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type='text/javascript' src='<c:url value="/resources/js/competitions.js" />'></script>
<style>
    .pagination-link {
        margin: 5px;
    }
</style>
<div style="border: 1px solid #e3e3e3; padding: 0px 20px;"> 
	<h2 class="user-info-name text-center" style="margin-bottom: 20px;">
	<c:choose>
        <c:when test="${empty all }">
          <spring:message code="label.competitions" />&nbsp;${year}&nbsp;
          <spring:message code="label.of_year" />
        </c:when>
        <c:otherwise>
          <spring:message code="label.all_competitions" />
        </c:otherwise>
    </c:choose>	
    <c:if test="${!empty countOfCompetitions }">
        <input type="hidden" id="countOfCompetitions" value="${countOfCompetitions }">
        <input type="hidden" id="competitionsPerPage" value="${competitionsPerPage }">
        <input type="hidden" id="page" value="${page }">
    </c:if>
    </h2>
	<br><input type="hidden" id="competition_list_url" value="<c:url value="/competition/list" />">	
	<div class="row">
        <div class="col-md-2 fl-left" id="pagination_settings" style="width: 100px;">
            <input type="text" 
                       title="<spring:message code="placeholder.results_per_page"/>"
                       id="results_per_page" class="form-control" value="${competitionsPerPage }" >
        </div>
        <div class="col-md-2 fl-left" >
            <button class="btn btn-success " id="results_per_page_btn" style="margin-left: -30px"><spring:message code="label.show" /></button>
        </div>
	  	<div class="col-md-2 fl-right" >
	    	<div class="input-group">
		      	<select class="form-control" id="years">
					<c:if test="${!empty yearsList}">
					    <option value="all"><spring:message code="label.show_all_competitions" /></option>
						<c:forEach items="${yearsList}" var="yearItem">
						    
							<option value="${yearItem}"
								<c:if test="${(empty all) and (yearItem == year)}">
									selected
								</c:if>
							>${yearItem}</option>
						</c:forEach>
					</c:if>
				</select>
		      	<!-- <span class="input-group-btn">
		        	  <button class="btn btn-success" type="button" id="show_by_year">
		        		<spring:message code="label.select_year" />
		        	</button>
		      	</span> -->
	    	</div>
	  	</div>
	</div>
	<br>
	<c:if test="${!empty competitionList}">
		<c:forEach items="${competitionList}" var="competition">
			<div class="panel panel-info <fmt:formatDate value="${competition.dateStart}" pattern="yyyy" />">
				<div class="panel-heading">
					<c:choose>
						<c:when test="${competition.isEnabled()}">
							<span class="glyphicon glyphicon-ok-circle" style="color: green" alt="<spring:message code="label.competition.registration_continues" />" title="<spring:message code="label.competition.registration_continues" />"></span>
						</c:when>
						<c:otherwise>
							<span class="glyphicon glyphicon-remove-circle" style="color: red" alt="<spring:message code="label.competition.registration_completed" />" title="<spring:message code="label.competition.registration_completed" />"></span>
						</c:otherwise>
					</c:choose>
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
	<div class="row">
	   <div id="pagination_links" class="">
	   </div>
	</div>
</div>
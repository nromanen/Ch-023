<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div style="border: 1px solid #e3e3e3; padding: 0px 40px;"> 
	<h2 class="user-info-name text-center"><spring:message code="label.list_of_teams" /></h2><br>
	<c:if test="${!empty teamList}">
		<c:forEach items="${teamList}" var="team">
			<div class="list-group" >
				<div class="list-group-item list-group-item-info row">
					<a href='<c:url value="/team/${team.id}" />'>${team.name}</a>
					(Leader: <a href="<c:url value="/leader/${team.leader.id}" />">
						${team.leader.firstName} ${team.leader.lastName}</a>)
				</div>
	
				<c:forEach items="${team.racers}" var="racer">
	
					<a href='<c:url value="/racer/${racer.id}" />' class="list-group-item row"> 
						<span class="col-md-4">
							${racer.firstName} ${racer.lastName}					
						</span>
						<span class="col-md-8">
							 <c:if test="${!empty racer.carClassNumbers}">
								<c:forEach items="${racer.carClassNumbers}" var="racerCarClassNumber">
									<span>
										<b>${racerCarClassNumber.carClass.name}</b>
									</span>(№${racerCarClassNumber.number})&nbsp;
								</c:forEach>
							</c:if>
						</span>
					</a>
						
				</c:forEach>
			</div>
		</c:forEach>
	</c:if>
</div>
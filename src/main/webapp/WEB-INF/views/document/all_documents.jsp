<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script> 
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script> 

		<div>
			<c:if test="${!empty teams}">
				<c:forEach items="${teams}" var="team" varStatus="status">
					
					<div class="panel-group" id="accordition"> 
						<div class="panel panel-primary">
							<div class="panel-heading" style="height: 50px;"> 	
								<div class="text-info" style="color: #fff; font-size: 20px; float: left;">
									<a data-toogle="collapse" style="color: #fff;" data-parent="#accordition" href="#race${status.index+1}">
										<spring:message code="label.team" /> #${status.index+1}: ${team.name}
									</a>
								</div>
								<c:if test="${authority.equals('ROLE_ADMIN')}">
									<div class="btn-group" style="float: right;">
										<a href='<c:url value="/index" />' class="btn btn-info " id="home"><spring:message code="label.title" /></a>
									</div>
								</c:if>
							</div>
							<div id="race${status.index+1}" class=" testcollapsing panel-collapse collapse" >
								<div class="panel-body" >
									<table id="res-table" class="table table-hover table-bordered" style="text-align: center;">
									

										<thead class="well" style="font-weight: 100;">
											<div class="text-info" style="color: #fff; font-size: 20px; float: left;">
													<spring:message code="label.team" /> #${status.index+1}: ${team.name}
											</div>
										</thead>
										<tbody>
												<c:forEach items="${teams[status.index].racers}" var="racer">
													<tr>
														<td>${racer.firstName}</td>
														<td>${racer.lastName}</td>
														<td style="text-align: left;"><a
															href='<c:url value="/racer/${raceResult.racer.id}" />'>
																${raceResult.racer.firstName} ${raceResult.racer.lastName}</a></td>
														<td>${racer.getDocuments()}</td>
													</tr>
												</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
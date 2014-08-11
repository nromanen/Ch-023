<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script> 
		<div>
			<c:if test="${!empty teams}">
				<c:forEach items="${teams}" var="team" varStatus="status">
					
					<div class="panel-group" id="accordition"> 
						<div class="panel panel-primary">
							<div class="panel-heading" style="height: 50px;"> 	
								<div class="text-info" style="color: #fff; font-size: 20px; float: left;">
									<a data-toogle="collapse" style="color: #fff;" data-parent="#accordition" href="#raceteam${status.index+1}">
										<spring:message code="label.team" /> #${status.index+1}: ${team.name}
									</a>
								</div>
							</div>
							<div id="raceteam${status.index+1}" class="testcollapsing panel-collapse collapse" >
								<div class="panel-body" >
									<table id="res-table" class="table table-hover table-bordered table-condensed table-responsive" >
										<%-- <thead class="well" style="font-weight: 100;">
										</thead> --%>
										<tbody>
											<c:forEach items="${teams[status.index].racers}" var="racer">
												<tr>
												<c:choose>
													<c:when test="${racer.getDocuments().size()==0}">
													<td class="warning" align="left">
													</c:when>
													<c:otherwise>
													<td class="active" align="left">
													</c:otherwise>
													</c:choose>
														<h4>${racer.firstName}&nbsp;
														${racer.lastName} &nbsp;
														</h4>
													<%-- <spring:message code="label.sport_category_${racer.sportsCategory}"/> --%>
													</td>
												</tr>
												<c:if test="${!empty racer.getDocuments()}">
													<tr>
														<td align="left">
															
																<c:forEach items="${racer.getDocuments()}" var="doc">
																<h4>
																	<c:choose>
																		<c:when test="${doc.checked==false}">
																			<span title='<spring:message code="label.document_unchecked"/>' class="label label-danger">
																		</c:when>
																		<c:otherwise>
																			<span title='<spring:message code="label.document_checked"/>' class="label label-success">
																		</c:otherwise>
																	</c:choose>		
																	<spring:message code="label.document_type_${doc.type}"/>
																	</span>
																	<c:forEach items="${doc.files}" var="file">
																		<a href="<c:url value="/resources/documents/${file.path}" />"
																			class="glyphicon glyphicon-paperclip file-link">
																		</a>
																	</c:forEach>
																	</h4>
																</c:forEach>
															</h4>
														</td>
													</tr>
												</c:if>
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
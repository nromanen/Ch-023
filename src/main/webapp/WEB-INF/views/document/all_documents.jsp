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
							<div id="raceteam${status.index+1}" class=" testcollapsing panel-collapse collapse" >
								<div class="panel-body" >
									<table id="res-table" class="table table-hover table-responsive" >
									

										<%-- <thead class="well" style="font-weight: 100;">
											<div class="text-info" style="color: #fff; font-size: 20px; float: left;">
													<spring:message code="label.team" /> #${status.index+1}: ${team.name}
											</div>
										</thead> --%>
										<tbody>
												<c:forEach items="${teams[status.index].racers}" var="racer">
													<tr>
														<td align="left" class="col-md-8 " colspan="2">
															${racer.firstName}&nbsp;
															${racer.lastName} &nbsp;
														<%-- <spring:message code="label.sport_category_${racer.sportsCategory}"/> --%>
														</td>
													</tr>
													<c:if test="${!empty racer.getDocuments()}">
														<c:forEach items="${racer.getDocuments()}" var="doc">
															<tr>
																<td align="left">
																<spring:message code="label.document_type_${doc.type}"/>
																<c:forEach items="${doc.files}" var="file">
																	<div>
																		<a href="<c:url value="/resources/documents/${file.path}" />"
																			class="glyphicon glyphicon-paperclip file-link">${file.path}
																		</a>
																	</div>
																</c:forEach>
																</td>
																<td align="right">
																	<c:choose>
																		<c:when test="${doc.checked==false}">
																			<label class="btn btn-warning"><spring:message code="label.document_unchecked"/></label>
																		</c:when>
																		<c:otherwise>
																			<label class="btn btn-success"><spring:message code="label.document_checked"/></label>
																		</c:otherwise>
																	</c:choose>
																</td>
															</tr>
														</c:forEach>
													</c:if>
												</c:forEach>
										</tbody>
									</table>
									<c:if test="${authority.equals('ROLE_ADMIN')}">
										<div class="btn-group" style="float: right;">
											<a href='<c:url value="/document/checkingDocuments/0" />' class="btn btn-info " id="home"><spring:message code="label.checking_documents" /></a>
										</div>
									</c:if>	
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

     <script type='text/javascript' src='<c:url value="/resources/js/document.js" />'></script> 
     
     <div class="btn-group" style="float: right; margin-bottom: 10px;">		
		<a href="#" id="show_not_valid" class="btn btn-danger">Not checked</a>
		<a href="#" id="show_valid" class="btn btn-success">Checked</a>
		<a href="#" id="show_all" class="btn btn-primary">All</a>
	</div>
	<br><br><br>
		<div>
			<c:if test="${!empty teams}">
				<c:forEach items="${teams}" var="team" varStatus="status">
					
					<div class="panel-group" id="accordition"> 
						<div class="panel panel-primary">
							<div class="panel-heading" style="height: 50px;"> 	
								<div class="text-info" style="color: #fff; font-size: 20px; float: left;">
									<a data-toogle="collapse" style="color: #fff;" data-parent="#accordition" href="#team${status.index+1}">
										<spring:message code="label.team" /> #${status.index+1}: ${team.name}
									</a>
									<c:set var="has" value="0"/>
									<c:set var="check" value="0" />
									<c:forEach items="${teams[status.index].racers}" var="racer">
										<c:if test="${!empty racer.getDocuments()}">
											<c:set var="has" value="1"/>
										</c:if>
											<c:forEach items="${racer.getDocuments()}" var="doc">
												<c:if test="${doc.checked==false}">
													<c:set var="check" value="1" />
												</c:if>
											</c:forEach>
									</c:forEach>
									<c:if test="${has==1}">
										<span class="glyphicon glyphicon-paperclip file-link"></span>
									</c:if>
									<c:if test="${check==1}">
										<span style="color:red" class="glyphicon glyphicon-exclamation-sign"></span>
									</c:if>
								</div>
							</div>
							<div id="team${status.index+1}" class="testcollapsing panel-collapse collapse" >
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
																				<c:forEach items="${unchecked_docs}" var="unDoc" varStatus="index">
																					<c:if test="${unDoc.id==doc.id}">
																						<c:set var="unchecked_id" value="${index.index}"/>
																					</c:if>
																				</c:forEach>
																				<a style="color: white" href="checkingDocuments/${unchecked_id}"><spring:message code="label.document_type_${doc.type}"/></a>
																			</span>
																		</c:when>
																		<c:when test="${doc.approved==false}">
																			<span title='<spring:message code="label.document_checked"/>' class="label label-success">
																				<spring:message code="label.document_type_${doc.type}"/>
																			<span style="color:red" title='<spring:message code="label.document_unapproved"/>'class="glyphicon glyphicon-exclamation-sign"></span>
																			</span>
																		</c:when>
																		<c:otherwise>
																			<span  title='<spring:message code="label.document_checked_and_approved"/>' class="label label-success">
																				<spring:message code="label.document_type_${doc.type}"/>
																			</span>
																		</c:otherwise>
																	</c:choose>		
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
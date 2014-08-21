<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

   <script type='text/javascript' src='<c:url value="/resources/js/document.js" />'></script> 
   
   <table id="show-buttons" class="width-100">
    <tr>
    	<td>
    	<c:if test='${type=="modern"}'>
	    	<div class="btn-group" style="float: left; margin-bottom: 10px;">		
				<a href="/Carting/document/allDocuments/classic" id="show_classic" class="btn btn-primary">Classic view</a>
			</div>
    	</c:if>
    	<c:if test='${type=="classic"}'>
	    	<div class="btn-group" style="float: left; margin-bottom: 10px;">		
				<a href="/Carting/document/allDocuments" id="show_modern" class="btn btn-primary">Modern view</a>
			</div>
    	</c:if>
     	
    	</td>
     <td>
        <div class="btn-group" style="float: right; margin-bottom: 10px;">	
        	<a href="#" class="btn btn-default" disabled="disabled"><spring:message code="label.show"/></a>
			<a href="#" id="show_unchecked" class="btn btn-danger"><spring:message code="label.documents_unchecked"/></a>
			<a href="#" id="show_checked" class="btn btn-success"><spring:message code="label.documents_checked"/></a>
			<a href="#" id="show_all" class="btn btn-primary"><spring:message code="label.all_documents"/></a>
		</div>
     </td>
    </tr>
   </table>

<c:if test='${type=="modern"}'>
<div class="well well-sm">
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
								&nbsp;<span title="There are files" class="glyphicon glyphicon-paperclip file-link"></span>
							</c:if>
							<c:if test="${check==1}">
								&nbsp;<span title="There are unchecked files" style="color:white" class="glyphicon glyphicon-exclamation-sign"></span>
							</c:if>
						</div>
					</div>
					<div id="team${status.index+1}" class="testcollapsing panel-collapse collapse" >
						<div class="panel-body" >
							<table id="doc_table" class="table table-hover table-condensed table-responsive" >
								<tbody>
									<c:forEach items="${teams[status.index].racers}" var="racer">
										<tr>
											<c:choose>
												<c:when test="${racer.getDocuments().size()==0}">
													<td class="warning" title='<spring:message code="label.no_documents"/>'align="left">
												</c:when>
												<c:otherwise>
													<td class="active" align="left">
												</c:otherwise>
											</c:choose>
											<h4>
												${racer.firstName}&nbsp;
												${racer.lastName} &nbsp;
											</h4>
											</td>
										</tr>
										<c:if test="${!empty racer.getDocuments()}">
											<c:forEach items="${racer.getDocuments()}" var="doc">
												<tr class="sortable">
													<td class="sortable" align="left">
														<c:choose>
															<c:when test="${doc.checked==false}">
																<span title='<spring:message code="label.document_unchecked"/>' class="label label-danger minus">
																	<c:forEach items="${unchecked_docs}" var="unDoc" varStatus="index">
																		<c:if test="${unDoc.id==doc.id}">
																			<c:set var="unchecked_id" value="${index.index}"/>
																		</c:if>
																	</c:forEach>
																	<a style="color: white" href="checkingDocuments/${unchecked_id}"><spring:message code="label.document_type_${doc.type}"/></a>
																</span>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${doc.approved==false}">
																			<span title='<spring:message code="label.document_checked"/>' class="label label-success plus">
																				<spring:message code="label.document_type_${doc.type}"/>
																			<span style="color:white;" title='<spring:message code="label.document_unapproved"/>'class="glyphicon glyphicon-exclamation-sign"></span>
																			</span>
																	</c:when>
																	<c:otherwise>
																		<span  title='<spring:message code="label.document_checked_and_approved"/>' class="label label-success plus">
																			<spring:message code="label.document_type_${doc.type}"/>
																		</span>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>		
														<c:forEach items="${doc.files}" var="file">
															&nbsp;
															<a href="data:image/jpg;base64,<c:out value="${file.file}" />"
																class="glyphicon glyphicon-paperclip file-link">
															</a>
														</c:forEach>
													</td>
												</tr>
											</c:forEach>
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
</c:if>
<c:if test='${type=="classic"}'>
<table id="doc_table" class="table table-bordered table-hover table-condensed table-responsive">
	<thead>
		<th style="text-align: center;">Type of document</th>
		<th style="text-align: center;">Checked</th>
		<th style="text-align: center;">Approved</th>
		<th style="text-align: center;">Files</th>
		<th style="text-align: center;">Racers</th>
		<th style="text-align: center;">Team</th>
	</thead>
	<tbody>
		<c:forEach items="${all_docs}" var="doc" varStatus="status">
			<tr class="sortable">
				<td class="sortable">
					<c:choose>
						<c:when test="${doc.checked==false}">
							<span title='<spring:message code="label.document_unchecked"/>' class="minus">
								<c:forEach items="${unchecked_docs}" var="unDoc" varStatus="index">
									<c:if test="${unDoc.id==doc.id}">
										<c:set var="unchecked_id" value="${index.index}"/>
									</c:if>
								</c:forEach>
								<a style="color: red" href="checkingDocuments/${unchecked_id}"><spring:message code="label.document_type_${doc.type}"/></a>
							</span>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${doc.approved==false}">
										<span title='<spring:message code="label.document_checked"/>' class=" plus">
											<spring:message code="label.document_type_${doc.type}"/>
										<span style="color:white;" title='<spring:message code="label.document_unapproved"/>'class="glyphicon glyphicon-exclamation-sign"></span>
										</span>
								</c:when>
								<c:otherwise>
									<span  title='<spring:message code="label.document_checked_and_approved"/>' class="plus">
										<spring:message code="label.document_type_${doc.type}"/>
									</span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<c:choose>
					<c:when test="${doc.checked == false}">
						<td>
							<span style="color:silver;"class="glyphicon glyphicon-minus minus"></span>
						</td>
					</c:when>
					<c:otherwise>
						<td>
							<span style="color:silver;"class="glyphicon glyphicon-plus plus"></span>
						</td>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${doc.approved == false}">
						<td>
							<span style="color:silver;"class="glyphicon glyphicon-minus"></span>
						</td>
					</c:when>
					<c:otherwise>
						<td>
							<span style="color:silver;"class="glyphicon glyphicon-plus"></span>
						</td>
					</c:otherwise>
				</c:choose>
				<td>
					<c:forEach items="${doc.files}" var="file">
						&nbsp;
						<a href="data:image/jpg;base64,<c:out value="${file.file}" />"
							class="glyphicon glyphicon-paperclip file-link">
						</a>
					</c:forEach>
				</td>
				<td>
					<table >
						<c:forEach items="${doc.racers}" var="racer">
							<tr>
								<td>
									<a href='<c:url value="/racer/${racer.id}" />'>
									${racer.firstName} ${racer.lastName}</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</td>
				<td>
					<c:forEach items="${doc.racers}" var="racer" varStatus="loop">
						<c:if test="${loop.index==0}">
							${racer.team.name }
						</c:if>
					</c:forEach>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<%@page import="net.carting.domain.Document"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type='text/javascript'
	src='<c:url value="/resources/js/document.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<h2 class="user-info-name">
	<spring:message code="label.checking_documents" />
</h2>
<c:choose>
	<c:when test="${isEmpty}">
		<div class="alert alert-warning">
			<spring:message code="message.all_documents_checked" />
		</div>
	</c:when>
	<c:otherwise>

		<div class="panel panel-primary">
			<div class="panel-heading">
				<table class="width-100">
					<tr>
						<td><span class="glyphicon glyphicon-list-alt"></span> <label
							class="text-info" style="color: #fff; font-size: 16px;">
								<c:choose>
									<c:when test="${documents.get(index).getType()==1}">
										<spring:message code="label.document_racer_license" />
									</c:when>
									<c:when test="${documents.get(index).getType()==2}">
										<spring:message code="label.document_racer_insurance" />
									</c:when>
									<c:when test="${documents.get(index).getType()==3}">
										<spring:message code="label.document_racer_medical_cerificate" />
									</c:when>
									<c:when test="${documents.get(index).getType()==4}">
										<spring:message
											code="label.document_racer_parental_permission" />
									</c:when>
								</c:choose>
						</label></td>
					</tr>
				</table>
			</div>
			<div class="panel-body">
				<table style="float: right">
					<tr>
						<td><div class="btn-group" data-toggle="buttons">

								<input type="hidden" id="document_id"
									value="${ documents.get(index).id }"> <input
									type="hidden" id="approved_url"
									value="<c:url value="/document/setApproved"/>"> <label
									class="btn btn-success"> <input type="radio"
									name="options" id="approved_radio" checked> <spring:message
										code="label.approved" />
								</label> <label class="btn btn-danger"> <input type="radio"
									name="options" id="unapproved_radio"> <spring:message
										code="label.unapproved" />
								</label>
							</div></td>
					</tr>
					<tr>
						<td><c:if test="${documents.get(index).approved}">
								<img src='<c:url value="/resources/img/approved.bmp" />'
									style="float: right; width: 150px;">
							</c:if> <c:if
								test="${documents.get(index).approved==false && documents.get(index).checked}">
								<img src='<c:url value="/resources/img/unapproved.bmp" />'
									style="float: right; width: 150px; margin: 10px 20px 0 0;">
							</c:if></td>
					</tr>
				</table>
				<c:if test="${documents.get(index).type == 0}">
					<div>
						<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>${documents.get(index).team.name}</div>
				</c:if>

				<c:if test="${documents.get(index).name != null}">
					<div>
						<label class="text-info"><spring:message
								code="label.document_number" />:&nbsp;</label>${documents.get(index).name}</div>
				</c:if>
				<c:if test="${documents.get(index).startDate != null}">
					<div>
						<label class="text-info"><spring:message
								code="label.document_date_start" />:&nbsp;</label>
						<fmt:formatDate value="${documents.get(index).startDate}"
							pattern="dd-MM-yyyy" />
					</div>
				</c:if>
				<c:if test="${documents.get(index).finishDate != null}">
					<div>
						<label class="text-info"><spring:message
								code="label.document_valid_until" />:&nbsp;</label>
						<fmt:formatDate value="${documents.get(index).finishDate}"
							pattern="dd-MM-yyyy" />
					</div>
				</c:if>
				<c:if
					test="${documents.get(index).type==1 || documents.get(index).type == 3 || documents.get(index).type==4 || documents.get(index).type==5 }">
					<div>
						<label class="text-info"><spring:message
								code="label.racer" />:&nbsp;</label>
						<c:forEach items="${documents.get(index).racers}" var="racer">
							<a href="<c:url value="/racer/${racer.id}"/>">${racer.firstName}&nbsp;${racer.lastName}</a>
						</c:forEach>
					</div>
				</c:if>
				<c:forEach items="${documents.get(index).files}" var="file">
					<div>
						<a href="<c:url value="/resources/documents/${file.path}" />"
							class="glyphicon glyphicon-paperclip file-link">${file.path}
						</a>
					</div>
				</c:forEach>

				<c:if
					test="${documents.get(index).reason != null && !documents.get(index).reason.equals('')}">
					<div>
						<label class="text-info" style="margin-top: 10px;"><spring:message
								code="label.document_reason" />:&nbsp;</label>
						<textarea style="width: 50%" rows=3 class="form-control"
							placeholder="Enter reason" id="result_sequance" disabled>${documents.get(index).reason}</textarea>
					</div>
				</c:if>
				<c:if test="${documents.get(index).type == 2}">
					<br>
					<table id="team-table" class="table table-bordered">
						<thead style="font-weight: 100;">
							<tr>
								<th class="text-center success">№</th>
								<th class="success text-center" id="racerLabel"><spring:message
										code="label.racer" /></th>
							</tr>
						</thead>
						<tbody>
							<%
								int number = 0;
							%>
							<c:forEach items="${documents.get(index).racers}" var="racer">
								<tr>
									<%
										number++;
									%>
									<td class="text-center"><%=number%></td>
									<td class="text-left"><a
										href='<c:url value="/racer/${racer.id}" />'>
											${racer.firstName} ${racer.lastName} </a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
		<div>
			<c:choose>
				<c:when test="${index==0 }">
					<a
						href="<c:url value="/document/checkingDocuments/${documents.size()-1}"/>"
						class="btn btn-primary"><spring:message code="labrl.previous" /></a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value="/document/checkingDocuments/${index-1}"/>"
						class="btn btn-primary"><spring:message code="labrl.previous" /></a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${index==documents.size()-1}">
					<a href="<c:url value="/document/checkingDocuments/0"/>"
						class="btn btn-primary"><spring:message code="label.next" /></a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value="/document/checkingDocuments/${index+1}"/>"
						class="btn btn-primary"><spring:message code="label.next" /></a>
				</c:otherwise>
			</c:choose>
			<div class="fl-right">
				<label class="text-info" style="font-size: 20px;"><spring:message
						code="label.total_unchecked" />: ${documents.size() }</label>
			</div>
		</div>
		<div class="modal fade" id="unapproved_modal" tabindex="-1"
			role="dialog">
			<div class="modal-dialog" style="margin-top: 10%;">
				<div class="modal-content">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal">x</button>
						<!-- 						<h4 class="modal-title">Unapproved document</h4> -->
					</div>

					<div class="modal-body">
						<div class="form-group">
							<form data-toggle="validator">
								<input type="hidden" id="unapproved_url"
									value="<c:url value="/document/setUnapproved"/>">
								<textarea rows=5 id="reason" class="form-control"
									placeholder="Enter reason" id="result_sequance"
									pattern=".{1,255}" required
									data-error="This field is required. Please enter reason. Max length 255 symbols">${document.reason}</textarea>
								<div class="help-block with-errors"></div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<img src='<c:url value="/resources/img/ajax-loader.gif" />'
							style="display: none; float: left;" id="ajax_loader_delete">
						<button class="btn btn-default" type="button" data-dismiss="modal">
							<spring:message code="label.cancel" />
						</button>
						<button class="btn btn-danger" type="button" id="unapproved">
							<spring:message code="label.accept" />
						</button>
					</div>


				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>


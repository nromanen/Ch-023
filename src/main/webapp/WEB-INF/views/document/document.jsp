<%@page import="net.carting.domain.Document"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type='text/javascript' src='<c:url value="/resources/js/document.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>

<div class="panel panel-primary">
	<div class="panel-heading">
		<table class="width-100">
			<tr>
				<td><span class="glyphicon glyphicon-list-alt"></span> 
					<label class="text-info" style="color: #fff; font-size: 16px;"> 
					<c:choose>
						<c:when test="${document.getType()==1}">
							<spring:message code="label.document_racer_license" />
						</c:when>
						<c:when test="${document.getType()==2}">
							<spring:message code="label.document_racer_insurance" />
						</c:when>
						<c:when test="${document.getType()==3}">
							<spring:message code="label.document_racer_medical_cerificate" />
						</c:when>
						<c:when test="${document.getType()==4}">
							<spring:message code="label.document_racer_parental_permission" />
						</c:when>
					</c:choose>
					</label>
				</td>
				<td>
					<c:if test="${document.teamOwner==team}">
						<a href="#" class="btn btn-danger" id="delete_document_btn" style="float: right"><spring:message code="label.delete" /></a>
						<a href="<c:url value="/document/edit/${document.id}" />" class="btn btn-info" id="edit_document_btn" style="float: right"><spring:message code="label.edit" /></a>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<div class="panel-body">
		<table style="float: right">
			<tr>
				<c:if test="${authority=='ROLE_ADMIN'}">
					<td><div class="btn-group" data-toggle="buttons">
							<input type="hidden" id="document_id" value="${ document.id }">
							<input type="hidden" id="approved_url" value="<c:url value="/document/setApproved"/>"> 
							<label class="btn btn-success">
								<input type="radio" name="options" id="approved_radio" checked> <spring:message code="label.approved" />
							</label>
							<label class="btn btn-danger">
								<input type="radio" name="options" id="unapproved_radio"> <spring:message code="label.unapproved" />
							</label>
						</div></td>
				</c:if>
			</tr>
			<tr>
				<td><c:if test="${document.approved}">
						<img src='<c:url value="/resources/img/approved.bmp" />' style="float: right; width: 150px;">
					</c:if>
					<c:if test="${document.approved==false && document.checked}">
						<img src='<c:url value="/resources/img/unapproved.bmp" />' style="float: right; width: 150px; margin: 10px 20px 0 0;">
					</c:if>
				</td>
			</tr>
		</table>
		<c:if test="${document.type == 0}">
			<div>
				<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>${document.team.name}</div>
		</c:if>
		<c:if test="${document.name != null}">
			<div><label class="text-info"><spring:message code="label.document_number" />:&nbsp;</label>${document.name}</div>
		</c:if>
		<c:if test="${document.startDate != null}">
			<div>
				<label class="text-info"><spring:message code="label.document_date_start" />:&nbsp;</label>
				<fmt:formatDate value="${document.startDate}" pattern="dd-MM-yyyy" />
			</div>
		</c:if>
		<c:if test="${document.finishDate != null}">
			<div>
				<label class="text-info"><spring:message code="label.document_valid_until" />:&nbsp;</label>
				<fmt:formatDate value="${document.finishDate}" pattern="dd-MM-yyyy" />
			</div>
		</c:if>
		<c:if test="${document.type==1 || document.type == 3 || document.type==4 || document.type==5 }">
			<div>
				<label class="text-info"><spring:message code="label.racer" />:&nbsp;</label>
				<c:forEach items="${document.racers}" var="racer">
					<a href="<c:url value="/racer/${racer.id}"/>">${racer.firstName}&nbsp;${racer.lastName}</a>
				</c:forEach>
			</div>
		</c:if>
		<c:forEach items="${document.files}" var="file">
			<div>
				<a target="_blank" href="showDocument/<c:out value='${file.id}'/>"
					class="glyphicon glyphicon-paperclip file-link"><c:out value='${file.name}'/>
				</a>
				</div>
		</c:forEach>

		<c:if test="${document.reason != null && !document.reason.equals('')}">
			<div>
				<label class="text-info" style="margin-top: 10px;"><spring:message code="label.document_reason" />:&nbsp;</label>
				<textarea style="width: 50%" rows=3 class="form-control" id="result_sequance" disabled>${document.reason}</textarea>
			</div>
		</c:if>
		<c:if test="${document.type == 2}">
			<br>
			<table id="team-table" class="table table-bordered">
				<thead style="font-weight: 100;">
					<tr>
						<th class="text-center success">№</th>
						<th class="success text-center" id="racerLabel"><spring:message code="label.racer" /></th>
					</tr>
				</thead>
				<tbody>
					<%
						int number = 0;
					%>
					<c:forEach items="${document.racers}" var="racer">
						<tr>
							<%
								number++;
							%>
							<td class="text-center"><%=number%></td>
							<td class="text-left"><a href='<c:url value="/racer/${racer.id}" />'>${racer.firstName} ${racer.lastName} </a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</div>

<c:if test="${request.getParameter('competition_id') != null}">
	<a href="/Carting/competition/${request.getParameter('competition_id')}/mandat" class="btn btn-primary"><spring:message code="label.document_return_to_mandat_statement" /></a>
</c:if>

<!-- Modal window for deleting document   -->
<div class="modal fade" id="delete_document_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title">
					<spring:message code="label.document_delete" />
				</h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message code="message.question_delete_document" /></label>
				<c:forEach items="${document.racers}" var="racer">
					<input type="hidden" class="racer_id" value="${racer.id}">
				</c:forEach>
				<input type="hidden" id="document_delete_url" value="<c:url value="/document/delete" />"> 
				<input type="hidden" id="document_type" value="${document.type}">
				<input type="hidden" id="document_delete_id" value="${document.id}">
				<input type="hidden" id="team_id" value="${document.getTeamOwner().id}"> <br> <br>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete">
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-primary" type="button" id="delete_document">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal window for deleting unapproved document   -->
<div class="modal fade" id="unapproved_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<!-- 	<h4 class="modal-title">Unapproved document</h4> -->
			</div>

			<div class="modal-body">
				<div class="form-group">
					<form data-toggle="validator">
						<input type="hidden" id="unapproved_url" value="<c:url value="/document/setUnapproved"/>">
						<textarea rows=5 id="reason" class="form-control" placeholder="<spring:message code="placeholder.reason" />" id="result_sequance" required pattern=".{1,255}"
							data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;255.">${document.reason}</textarea>
						<div class="help-block with-errors"></div>
					</form>
				</div>
			</div>
			
			<div class="modal-footer">
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none; float: left;" id="ajax_loader_delete">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-danger" type="button" id="unapproved">
					<spring:message code="label.document_unapproved" />
				</button>
			</div>

		</div>
	</div>
</div>
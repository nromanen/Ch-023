<%@page import="net.carting.domain.Document"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>

<link href='<c:url value="/resources/style/datepicker.css" />'
	rel="stylesheet">
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />'
	charset="UTF-8"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/document.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/file-validation.js" />'></script>

<!-- <h2 class="user-info-name">Add document</h2> -->
<h2 class="text-left user-info-name">
	<spring:message code="label.editing_document" />
	&nbsp;"
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
	"
</h2>
<form method="POST" class="well "
	action="<c:url value="/document/confirmEdit" />"
	data-toggle="validator" role="form" enctype="multipart/form-data">

	<input type="hidden" id="type" name="document_id"
		value="${document.id}"> <input type="hidden"
		id="file_delete_url" value="<c:url value="/document/deleteFile"/>">
	<c:if test="${document.type == 4}">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_date_start" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control datepicker" name="start_date"
				placeholder="<spring:message code="placeholder.date" />" required
				value="${startDate}"
				pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
				data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<c:if test="${document.type == 2 || document.type == 3}">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_valid_until" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control datepicker"
				name="finish_date"
				placeholder="<spring:message code="placeholder.date" />" required
				value="${finishDate}"
				pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
				data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<c:if test="${document.type == 1 || document.type == 2}">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_number" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control" value="${document.name}"
				placeholder="<spring:message code="placeholder.document_number" />"
				id="number" pattern=".{1,100}" name="number" required
				data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.enter_document_namber" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<div class="alert alert-warning text-center">
		<strong><spring:message code="message.attention" /></strong>
		<spring:message code="message.file_warning" />
	</div>
	<input type="hidden" value=${ document.files.size()} id="fileCount">
	<div style="width: 60%" class="fl-right">
		<table style="width: 100%">
			<c:forEach items="${document.files}" var="file">
				<tr>
					<td><a
						href="<c:url value="/resources/documents/${file.path}" />"
						class="glyphicon glyphicon-paperclip file-link fl-right">${file.path}
					</a></td>
					<td><button type="button" id="${file.id}"
							class="btn btn-danger btn-sm delete_file" style="float: right">
							<spring:message code="label.delete" />
						</button>
				</tr>
			</c:forEach>
		</table>
	</div>

	<label for="filePicker" class="text-info"><spring:message
			code="label.choose_file" />:</label>
	<table id="fileTable">
		<tr>
			<td>
				<div class="form-group">
					<input type="file" name="file" class="file"
						onchange="return ValidateFileUpload(this)" />
				</div>
			</td>
		</tr>
	</table>
	<div class="form-group" style="height: 50px;">
		<input id="addFile" type="button" class="btn btn-primary btn-sm"
			value="<spring:message code="label.another_file" />" />
		<div class="alert alert-danger" id="max_count_achieved"
			style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
			<spring:message code="dataerror.max_count_achieved" />
		</div>
	</div>
	<input type="submit" class="btn btn-success"
		value="<spring:message code="label.accept" />" id="edit_document">
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader">
</form>
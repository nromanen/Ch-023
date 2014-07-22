<%@page import="net.carting.domain.Document"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<div class="text-right">
	<a href='<c:url value="/document/chooseType" />'
		class="btn btn-primary right "><spring:message
			code="label.document_choose_type" /></a>
</div>
<h2 class="text-left user-info-name">
	<spring:message code="label.add_document_type" />&nbsp;"
	<c:choose>
		<c:when test="${documentType==1}">
			<spring:message code="label.document_racer_license" />
		</c:when>
		<c:when test="${documentType==2}">
			<spring:message code="label.document_racer_insurance" />
		</c:when>
		<c:when test="${documentType==3}">
			<spring:message code="label.document_racer_medical_cerificate" />
		</c:when>
		<c:when test="${documentType==4}">
			<spring:message code="label.document_racer_parental_permission" />
		</c:when>
	</c:choose>"
</h2>
<form method="POST" class="well "
	action="<c:url value="/document/addDocument" />"
	data-toggle="validator" role="form" enctype="multipart/form-data"
	id="addDocument">

	<input type="hidden" id="type" name="document_type"
		value=${ documentType }> <br>
	<c:if test="${documentType==4 }">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_date_start" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control datepicker" name="start_date"
				placeholder="<spring:message code="placeholder.date" />" required
				pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
				data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<c:if test="${documentType==2 || documentType==3 }">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_valid_until" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control datepicker"
				name="finish_date"
				placeholder="<spring:message code="placeholder.date" />" required
				pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
				data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<c:if test="${documentType==1 || documentType==2 }">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_number" /><span class="text-danger">*</span>:&nbsp;
			</label> <input type="text" class="form-control"
				placeholder="<spring:message code="placeholder.document_number" />"
				id="number" pattern=".{1,100}" name="number" required
				data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.enter_document_namber" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>

	<div class="alert alert-warning text-center">
		<strong><spring:message code="message.attention" /></strong>
		<spring:message code="message.file_warning" />
	</div>
	<label class="text-info"><spring:message
			code="label.choose_file" /><span class="text-danger">*</span>: </label>
	<table id="fileTable">
		<tr>
			<td>
				<div class="form-group success">
					<input type="file" name="file" id="fileChooser" required
						onchange="return ValidateFileUpload(this)" class="file"
						data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.upload_file" />" />
				</div>
			</td>
		</tr>
	</table>
	<div class="form-group" style="height: 50px;">
		<input id="addFile" type="button"
			class="btn btn-primary btn-sm fl-left"
			value="<spring:message
							code="label.another_file" />" />
		<div class="alert alert-danger" id="max_count_achieved"
			style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
			<spring:message code="dataerror.max_count_achieved" />
		</div>
		<input type="hidden" value=0 id="fileCount">
	</div>
	<%
		int number = 0;
	%>
	<div class="form-group">
		<table id="team-table" class="table table-bordered">
			<thead style="font-weight: 100;">
				<tr>
					<th class="text-center success">#</th>
					<th class="success" id="racerLabel" colspan="2"><spring:message
							code="label.racer" /></th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${racers}" var="racer">
					<tr>
						<%
							number++;
						%>
						<td class="text-center"><%=number%></td>
						<td class="text-left"><a
							href='<c:url value="/racer/${racer.id}" />'>
								${racer.firstName} ${racer.lastName} </a></td>
						<c:choose>
							<c:when test="${documentType==2 }">

								<td class="text-center racer_checked"><input
									type="checkbox" name="racer_id" value="${ racer.id }" required></td>


							</c:when>
							<c:when
								test="${documentType==1|| documentType==3 || documentType==4 }">
								<td class="text-center racer_checked"><input type="radio"
									name="racer_id" value="${ racer.id }" required></td>
							</c:when>
						</c:choose>
					</tr>

				</c:forEach>
			</tbody>
		</table>
	</div>
	<input type="hidden" name="racer_id" value=-1> <br> <input
		type="submit" class="btn btn-success"
		value="<spring:message
							code="label.accept" />"
		id="add_document"> <img
		src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br> <br>
</form>
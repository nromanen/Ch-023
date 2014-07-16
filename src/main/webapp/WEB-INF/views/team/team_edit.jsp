<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/team.js" />'></script>

<h2 class="user-info-name">
	<spring:message code="label.editing_team" />
</h2>
<form class="well" method="POST" action="/Carting/team/editTeam"
	data-toggle="validator" role="form" name="edit_team" id="edit_team">

	<!-- 	<div class="label label-danger" style="font-size: 12px;">
		All fields are required
	</div> -->
	<p style="margin-top: 15px;">
	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.team_name" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control" placeholder="<spring:message
				code="placeholder.enter_team_name" />"
			id="team_name" required pattern=".{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." value="${team.name}" /> <input
			type="hidden" name="team_id" id="team_id" value="${team.id}" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span
			class="text-danger">*</span>:&nbsp; </label> <input type="text"
			class="form-control" value="${team.address}" 
			placeholder="<spring:message code="placeholder.address" />"
			id="address" required pattern=".{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.license_number" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.license_number" />"
			value="${team.license}" id="license" required pattern=".{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100."
			id="document" />
		<div class="help-block with-errors"></div>
	</div>

	<br> <input type="submit" class="btn btn-success"
		value="<spring:message code="label.accept" />" id="edit_team"> <img
		src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br> <br>
	<div class="alert alert-danger" id="team_exists"
		style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
		<spring:message code="message.team_exists" />
	</div>

</form>
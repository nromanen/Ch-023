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
	src='<c:url value="/resources/js/team.js" />'></script>

<h2 class="user-info-name"><spring:message code="label.adding_team" /></h2>
<form class="well" method="POST" action="/Carting/team/addTeam"
	data-toggle="validator" role="form" name="new_team" id="new_team">

	<p style="margin-top: 15px;">
	<div class="form-group">
		<label class="text-info"><spring:message code="label.team_name" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control" placeholder="<spring:message
				code="placeholder.enter_team_name" />"
			id="team_name" required pattern="[A-ZА-ЯІЇЄ][A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code="dataerror.team_name_example" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control" placeholder="<spring:message code="placeholder.address" />"
			id="address" required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.license_number" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control" placeholder="<spring:message code="placeholder.license_number" />"
			id="license" required pattern="[^<>\&\^\$]{1,30}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;30." />
		<div class="help-block with-errors"></div>
	</div>

	<br> <input type="submit" class="btn btn-primary" value="<spring:message code="label.accept" />"
		id="add_team"> <img
		src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br> <br>
	<div class="alert alert-danger" id="team_exists"
		style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
		<spring:message code="message.team_exists" />
	</div>

</form>
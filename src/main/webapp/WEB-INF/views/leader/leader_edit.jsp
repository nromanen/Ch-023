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
	src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />'
	charset="UTF-8"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/leader.js" />'></script>

<input type="hidden" id="locale" value="${locale }">
<h2 class="user-info-name">${leader.firstName}&nbsp;${leader.lastName}</h2>
<form class="well" method="POST" action="/Carting/leader/editLeader"
	role="form" name="edit_leader" id="edit_leader" data-toggle="validator">

	<input type="hidden" id="id" value="${leader.id}">
	<p style="margin-top: 15px;">
	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.firstname" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control" placeholder="<spring:message code="placeholder.firstname" />"
			value="${leader.firstName}" id="first_name" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,50}"
			data-error="<spring:message code="dataerror.firstname" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.lastname" /><span
			class="text-danger">*</span>:&nbsp; </label> <input type="text"
			class="form-control" placeholder="<spring:message code="placeholder.lastname" />"
			value="${leader.lastName}" id="last_name" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,50}"
			data-error="<spring:message code="dataerror.lastname" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message code="placeholder.date_of_birth" />"
			value="${leaderBirthday}" required id="birthday"
			data-error="<spring:message code="dataerror.field_required" />"/>
		<div class="help-block with-errors"></div>
	</div>
	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.identification" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message
				code="placeholder.identification" />"
			required pattern="[0-9A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,50}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;50."
			value=${leader.document } id="document" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span
			class="text-danger">*</span>:&nbsp; </label> <input type="text"
			class="form-control"
			placeholder="<spring:message code="placeholder.address" />"
			value="${leader.address}" id="address" required pattern="[0-9A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.license_number" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.license_number" />"
			value="${leader.license}" id="license" required pattern="[0-9A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,30}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;30."
			id="document" />
		<div class="help-block with-errors"></div>
	</div>
	<br> <input type="submit" class="btn btn-primary"
		value="<spring:message code="label.accept" />" id="edit_leader_button">
	<a href="/Carting/leader/${leader.id}"> <input type="button"
		class="btn btn-default" value="<spring:message code="label.cancel" />" />
	</a> <img src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader">
</form>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href='<c:url value="/resources/libs/bootstrapValidator/css/bootstrapValidator.min.css" />' rel="stylesheet">
<!--  link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet" -->
<!--  script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script -->
<script type='text/javascript' src='<c:url value="/resources/js/leader.js" />'></script>
<script type='text/javascript' src="<c:url value="/resources/js/lib/bootbox.js" />"></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>
<h2 class="user-info-name">
	<spring:message code="label.registration" />
</h2>
<input type="hidden" id="locale" value="${locale }">
<form class="well" method="POST" action="/Carting/leader/addLeader"
	data-toggle="validator" role="form" name="new_leader" id="new_leader">
	<p style="margin-top: 15px;">
	<div>
		<h3>
			<spring:message code="label.leader_info" />
		</h3>
	</div>
	<div class="row">
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.firstname" /><span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control" name="firstName"
				placeholder="<spring:message code="placeholder.firstname" />"
				id="first_name"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,30}"
				data-bv-regexp-message="<spring:message code="dataerror.firstname" />" />
			<div class="help-block with-errors"></div>
		</div>
	
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.lastname" /><span
				class="text-danger">*</span>:&nbsp;</label> <input type="text"
				class="form-control" name="lastName"
				placeholder="<spring:message code="placeholder.lastname" />"
				id="last_name"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,30}"
				data-bv-regexp-message="<spring:message code="dataerror.lastname" />" />
			<div class="help-block with-errors"></div>
		</div>
	</div>

	<div class="row">
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message
					code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;</label>
			<input 
				type="text" 
				class="form-control" 
				name="birthday"
				placeholder="<spring:message code="placeholder.date_of_birth" />"
				data-bv-date-format="YYYY-MM-DD"
				data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message
					code="label.identification" /><span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control" name="document"
				placeholder="<spring:message code="placeholder.identification" />"
				id="document"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[^<>\&\^\$]{1,50}"
				data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;50." />
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="row">
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.address" /><span
				class="text-danger">*</span>:&nbsp;</label> <input type="text"
				class="form-control" name="address"
				placeholder="<spring:message code="placeholder.address" />"				
				id="address"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />" 
				pattern="[^<>\&\^\$]{1,100}"
				data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
			<div class="help-block with-errors"></div>
		</div>
	
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message
					code="label.license_number" /><span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control" name="license"
				placeholder="<spring:message code="placeholder.license_number" />"
				id="license"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[^<>\&\^\$]{1,30}"
				data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;30." />
			<div class="help-block with-errors"></div>
		</div>
	</div>

	<div class="row">
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.login" /><span
				class="text-danger">*</span>:&nbsp;</label> <input type="text"
				class="form-control" name="user.username"
				placeholder="<spring:message code="placeholder.login" />"
				id="username"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[^<>\&\^\$]{1,30}"
				data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;30." />
			<div class="help-block with-errors"></div>
		</div>
		
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.email" /><span
				class="text-danger">*</span>:&nbsp;</label> <input type="text"
				class="form-control" name="user.email"
				placeholder="<spring:message code="placeholder.email" />"
				id="email"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
				pattern="[A-Za-z0-9_\.-]{1,30}@[A-Za-z0-9_\.-]{1,30}"
				data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.email_example" />" />
			<div class="help-block with-errors"></div>
		</div>
		
		<div class="alert alert-danger" id="email_exists"
			style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
			<spring:message code="message.email_exist" />
		</div>
	</div>	

	<div class="row">
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message code="label.password" /><span
				class="text-danger">*</span>:&nbsp;</label> <input type="password"
				class="form-control" name="user.password"
				placeholder="<spring:message code="placeholder.password" />"
				id="password" 
				data-minlength="5" 
				required
				data-error="<spring:message code="dataerror.mimimum_5_characters" />" />
			<div class="help-block with-errors"></div>
		</div>
	
		<div class="form-group col-sm-6">
			<label class="text-info"><spring:message
					code="label.confirm_password" /><span class="text-danger">*</span>:&nbsp;</label>
			<input type="password" class="form-control"
				placeholder="<spring:message code="placeholder.confirm_password" />"
				id="password2" data-match="#password" required
				data-match-error="<spring:message code="dataerror.passwords_don't_match" />"
				data-error="<spring:message code="dataerror.field_required" />" />
			<div class="help-block with-errors"></div>
			<div id="error_password" style="display: none"></div>
			<div class="alert alert-danger" id="password_error"
				style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
				<spring:message code="dataerror.passwords_do_not_match" />
			</div>
		</div>
	</div>
	
	<br> <input type="submit" class="btn btn-success"
		value=<spring:message
				code="label.register" /> id="register">
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br> <br>
	<div class="alert alert-danger" id="user_exists"
		style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
		<spring:message code="message.user_exist" />
	</div>
	<input type="hidden" id="error_encoding_passwords"
		value="<spring:message code="dataerror.error_encoding_passwords" />">
	<input type="hidden" id="message_after_registration"
		value="<spring:message code="message.after_leader_registration" />">

</form>
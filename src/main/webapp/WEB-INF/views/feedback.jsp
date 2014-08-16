<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/feedback.js" />'></script>


<h2 class="user-info-name"><spring:message code="label.email_title" /></h2>

<form class="well" method="post" action="<c:url value="/feedback/sendMail" />"
	data-toggle="validator" role="form" name="feedback_form" id="feedback_form">

	<div class="form-group">
		<label class="text-info"><spring:message code="label.email_sender" /><span class="text-danger">*</span>:&nbsp;</label>
		<input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.email" />" id="from" name="from" required
			pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
			data-error="<spring:message code="dataerror.email_not_valid" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.email_subject" /><span class="text-danger">*</span>:&nbsp;</label>
		<input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.email_subject" />" id="subject" name="subject" required
			pattern="[^<>\&\^\$]{1,100}" data-error="<spring:message code="dataerror.100_symbols_limit" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.email_message" /><span class="text-danger">*</span>:&nbsp;</label>
		<textarea type="text" class="form-control" cols="20"
			placeholder="<spring:message code="placeholder.email_message" />" id="message" name="message" required
			pattern="[^<>\&\^]{1,1000}" data-error="<spring:message code="dataerror.field_required" />"></textarea>
		<div class="help-block with-errors"></div>
	</div>
	
	<button type="submit" class="btn btn-success" id="send_mail"><spring:message code="label.email_button" /></button>
	<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader">
	
	<br><br>
	<div class="alert alert-success" id="feedback_success"
		 style="display: none; padding: 0px 10px 0px 10px; height: 25px;">
		<spring:message code="message.email_sent_success" />
	</div>
	<div class="alert alert-danger" id="feedback_error"
		 style="display: none; padding: 0px 10px 0px 10px; height: 25px;">
		<spring:message code="message.email_sent_failed" />
	</div>
</form>
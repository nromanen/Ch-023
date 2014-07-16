<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/feedback.js" />'></script>

<div style="margin-left: 18%;">	
	<h2 class="user-info-name">Feedback</h2>
	
	<form class="well" method="post" action="<c:url value="/feedback/sendMail" />"
		data-toggle="validator" role="form" name="feedback_form" id="feedback_form" style="width: 800px;">
	
		<div class="form-group">
			<label class="text-info">Sender<span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control"
				placeholder="Enter email" id="from" name="from" required
				pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
				data-error="Email format is not valid" />
			<div class="help-block with-errors"></div>
		</div>
		
		<div class="form-group">
			<label class="text-info">Subject<span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control"
				placeholder="Enter mail subject" id="subject" name="subject" required
				pattern=".{1,100}" data-error="Limit: 100 symbols" />
			<div class="help-block with-errors"></div>
		</div>
		
		<div class="form-group">
			<label class="text-info">Message<span class="text-danger">*</span>:&nbsp;</label>
			<textarea type="text" class="form-control" cols="20"
				placeholder="Enter message" id="message" name="message" required
				data-error="Limit: 100 symbols"></textarea>
			<div class="help-block with-errors"></div>
		</div>
		
		<button type="submit" class="btn btn-success" id="send_mail">Send</button>
		<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader">
		
		<br><br>
		<div class="alert alert-success" id="feedback_success"
			 style="display: none; padding: 0px 10px 0px 10px; height: 25px;">
			Letter has been sent successfully!
		</div>
		<div class="alert alert-danger" id="feedback_error"
			 style="display: none; padding: 0px 10px 0px 10px; height: 25px;">
			Letter was not sent. An error has occurred!
		</div>
	</form>
</div>
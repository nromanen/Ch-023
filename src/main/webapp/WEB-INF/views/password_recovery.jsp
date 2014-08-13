<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript'
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/password_recovery.js" />'></script>

<div class="container">
	<div class="col-md-4 col-md-offset-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					<strong>Password recovery</strong>
				</h3>
			</div>
			<div class="panel-body">
				<div>
					<input type="text" id="email">
					<button id="send_secure_code_btn">
						Send secure code
					</button>
					<input type="hidden" id="send_secure_code_url" value="<c:url value="/leader/sendSecureCode" />" >
				</div>
				<div>
					<input type="text" id="secure_code">
					<button id="secure_code_btn">
						Check secure code
					</button>
					<input type="hidden" id="check_secure_code_url" value="<c:url value="/leader/checkSecureCode" />" >
				</div>
				<div>
					<input type="text" id="password">
					<input type="text" id="password2">
					<button id="change_password">
						Change password
					</button>
					<input type="hidden" id="change_password_url" value="<c:url value="/leader/changePassword" />" >
				</div>
			</div>
		</div>
	</div>
</div>
<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@ page
	import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@ page
	import="org.springframework.security.core.AuthenticationException"%>


<script>
	$(document).ready(function(){
		$('#popover').popover({
			placement: "bottom"
		});
	});
</script>

<div class="container">
	<div class="col-md-4 col-md-offset-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					<strong><spring:message code="label.authorization" /></strong>
				</h3>
			</div>
			<div class="panel-body">
				<form role="form" method="POST"
					action="<c:url value="/j_spring_security_check" />">
					<c:if test="${error.equals('BadCredentialsException')}">
						<div class="alert alert-warning">
							<strong><spring:message code="label.warning" /></strong>
							<spring:message code="label.bad_redentials_exception" />
						</div>
					</c:if>
					<c:if test="${error.equals('userDisabled')}">
						<div class="alert alert-warning">
							<strong><spring:message code="label.warning" /></strong>
							<spring:message code="label.user_disabled" />
						</div>
					</c:if>
					<div class="form-group">
						<label for="username" class="text-info"><spring:message
								code="label.login" /></label> <input type="text" name="j_username"
							class="form-control" style="border-radius: 0px" id="username"
							placeholder="<spring:message
								code="placeholder.login" />">
					</div>
					<div class="form-group">
						<label for="password" class="text-info"><spring:message
								code="label.password" /> </label> <input type="password"
							name="j_password" class="form-control" style="border-radius: 0px"
							id="password" placeholder="<spring:message
								code="placeholder.password" />">
					</div>
					<button type="submit" class="btn btn-sm btn-success">
						<spring:message code="label.sign_in" />
					</button>					
					<a href='<c:url value="/leader" />' class="btn btn-sm btn-primary">
						<spring:message code="label.registration" />
					</a>
					<a href='#' class="btn btn-sm btn-default fl-right" id="popover" data-container="body" 
						data-toggle="popover" data-content="E-mail: ${email}">
						<spring:message code="label.contacts" />
					</a>
				</form>
			</div>
		</div>
	</div>
</div>
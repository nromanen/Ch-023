<!-- <div class="container">
	<div class="jumbotron">
		<p>HTTP Status 404 - Page not found
	</div>
</div>-->

<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title><spring:message code="label.title" /></title>

<link
	href='<c:url value="/resources/style/bootstrap/css/bootstrap.min.css" />'
	rel="stylesheet">
<link href='<c:url value="/resources/style/main.css" />'
	rel="stylesheet">
</head>

<body>
	<!-- Main frame -->
	<div class="container">
		<!-- Main component for a primary marketing message or call to action -->
		<div class="jumbotron">
			<p>HTTP Status 404 - Page not found
		</div>
	</div>


	<nav class="navbar-fixed-bottom">
	<div class="container">
		<p class="text-center">SoftServe ITA Java team &copy; 2014</p>
	</div>
	</nav>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script
		src="<c:url value="/resources/style/bootstrap/js/bootstrap.min.js" />"></script>
</body>
</html>
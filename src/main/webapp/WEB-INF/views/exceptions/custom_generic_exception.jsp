<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
	<p>
	<div class="alert alert-warning">
		<strong><spring:message code="label.warning" /></strong> ${message}
	</div>
	<!--If you want to see exception details when you go to page code, you must put to map this exception like map.put("exception",exception)-->
	<!--
		Exception:  ${exception.message}
		<c:forEach items="${exception.stackTrace}" var="ste">    ${ste} 
		</c:forEach>
    -->
</div>



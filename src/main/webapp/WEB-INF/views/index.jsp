<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<div style="padding: 0px;">	
	<div class="jumbotron" style="background-color: #D9EDF7; border-radius: 5px;">
		<h1><spring:message code="label.title_pro" /></h1>
		<p><spring:message code="label.text_welcome" /><br/><spring:message code="label.text_push_the_button" /></p>
		<p>
			<a class="btn btn-lg btn-primary" href='<c:url value="/team/list"/>'
				role="button"><spring:message code="label.list_of_participants" /> &raquo;</a>
		</p>
	</div>					
</div>
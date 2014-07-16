<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
	<div class="jumbotron">
		<p>
			Oops, something wrong...

			<!--
				    Failed URL: ${url}
				    Exception:  ${exception.message}
				        <c:forEach items="${exception.stackTrace}" var="ste">    ${ste} 
				    </c:forEach>
    			-->
	</div>
</div>



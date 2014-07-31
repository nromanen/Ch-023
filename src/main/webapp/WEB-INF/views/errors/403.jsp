<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container">
	<!-- Main component for a primary marketing message or call to action -->
	<div class="jumbotron">
		<p><spring:message code="label.access_is_denied" />
		<p><spring:message code="label.invalid_authorized" />
	</div>
</div>
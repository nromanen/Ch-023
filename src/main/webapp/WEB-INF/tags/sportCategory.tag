<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ attribute name="value" required="true" rtexprvalue="true" %>
<c:choose>
	<c:when test="${value == '1'}">
		<td><spring:message code="sportcategory.1" /></td>
	</c:when>
	<c:when test="${value=='2'}">
		<td><spring:message code="sportcategory.2" /></td>
	</c:when>
	<c:when test="${value=='3'}">
		<td><spring:message code="sportcategory.3" /></td>
	</c:when>
	<c:when test="${value=='4'}">
		<td><spring:message	code="sportcategory.candidate_master_of_sports" /></td>
	</c:when>
	<c:when test="${value=='5'}">
		<td><spring:message code="sportcategory.master_of_sports" /></td>
	</c:when>
	<c:when test="${value=='0'}">
		<td><spring:message code="sportcategory.without" /></td>
	</c:when>
</c:choose>
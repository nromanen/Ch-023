<%@page import="net.carting.domain.Logs"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript' src="<c:url value="/resources/js//lib/jquery.dataTables.js" />"></script>
<link href="<c:url value="/resources/style/jquery.dataTables.css" />" rel="stylesheet" type="text/css">
<script>
$(document).ready( function () {
    $('#logsTable').DataTable();
} );
</script>
<table id="logsTable" style="width:100%" class="table table-hover table-bordered" border='1' cellspacing='0' cellpadding='2'>
	<thead class="well" style="font-weight: 100;">
		<tr>
			<th>Logger</th>
			<th>Level</th>
			<th>Message</th>
			<th>Date</th>
		</tr>
	</thead>
	<c:forEach items="${logs}" var="log">
		<tr>
			<td><c:out value="${log.level}"/></td>
			<td><c:out value="${log.logger}"/></td>
			<td><c:out value="${log.message}"/></td>
			<td><c:out value="${log.date}"/></td>
		</tr>
	</c:forEach>
</table>
<%@page import="net.carting.domain.Logs"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>
<script type='text/javascript' src="<c:url value="/resources/js/lib/jquery.dataTables.js" />"></script>
<script type='text/javascript' src="<c:url value="/resources/js/logs.js" />"></script>
<link href="<c:url value="/resources/style/jquery.dataTables.css" />" rel="stylesheet" type="text/css">
<form action="search" data-toggle="validator" role="form" id="form">
	<div class="panel panel-primary well">
		<div align="center" class="panel-heading">
			<h4><spring:message code="label.search" /></h4>
		</div>
		<div align="center" class="panel-body">
			<table>
				<td align="center"><label class="text-info"><spring:message code="label.competition.start_date" /></label><br/>
					<label class="text-info"><spring:message code="label.year" /></label>
					<input name="year" id="starty" type="text" value='<fmt:formatDate value="${dateStart}"
						pattern="yyyy" />' size="1"/>
					<label class="text-info"><spring:message code="label.month" /></label>
					<input name="date" id="startm" type="text" value='<fmt:formatDate value="${dateStart}"
						pattern="MM" />' size="1"/>
					<label class="text-info"><spring:message code="label.day" /></label>
					<input name="date" id="startd" type="text" value='<fmt:formatDate value="${dateStart}"
						pattern="dd" />' size="1"/>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td align="center"><label class="text-info"><spring:message code="label.competition.end_date" /></label><br/>
					<label class="text-info"><spring:message code="label.year" /></label>
					<input name="year" id="endy" type="text" value='<fmt:formatDate value="${dateEnd}"
						pattern="yyyy" />' size="1"/>
					<label class="text-info"><spring:message code="label.month" /></label>
					<input name="date" id="endm" type="text" value='<fmt:formatDate value="${dateEnd}"
						pattern="MM" />' size="1"/>
					<label class="text-info"><spring:message code="label.day" /></label>
					<input name="date" id="endd" type="text" value='<fmt:formatDate value="${dateEnd}"
						pattern="dd" />' size="1"/>
				</td>
			</table>
			<br/>
			<div class="input-group">
				<div class="btn-group">
					<a href="all" class="btn btn-sm btn-success"><spring:message code="label.show_all_logs" /></a>
					<input type="submit" id="submit" class="btn btn-sm btn-primary" value='<spring:message code="label.search" />'>
				</div>
			</div>
		</div>
	</div>
</form>
<br/>
<table id="logsTable" class="display" cellspacing="0" width="100%">
<%--<table id="logsTable" style="width:100%" class="display table table-hover table-bordered" border='1' cellspacing='0' cellpadding='2'>--%>
	<thead class="well" style="font-weight: 100;">
		<tr>
			<th>Logger</th>
			<th>Level</th>
			<th>Message</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${logs}" var="log">
			<tr>
				<td><c:out value="${log.level}"/></td>
				<td><c:out value="${log.logger}"/></td>
				<td><c:out value="${log.message}"/></td>
				<td><c:out value="${log.date}"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
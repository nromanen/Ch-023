<%@page import="net.carting.domain.Logs"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>
<script type='text/javascript' src="<c:url value="/resources/js/lib/jquery.dataTables.js" />"></script>
<link href="<c:url value="/resources/style/jquery.dataTables.css" />" rel="stylesheet" type="text/css">
<script>
$(document).ready( function () {
	$('#logsTable').DataTable();

		$('form').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				start: {
					message: 'The username is not valid',
					validators: {
						notEmpty: {
							message: 'The date is required and cannot be empty'
						},
						regexp: {
							regexp: /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{1,}$/,
							message: 'Date must match pattern yyyy-MM-dd hh:mm:ss.000'
						}
					}
				},
				end: {
					message: 'Date must match pattern yyyy-MM-dd hh:mm:ss.000',
					validators: {
						notEmpty: {
							message: 'The date is required and cannot be empty'
						},
						regexp: {
							regexp: /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{1,}$/,
							message: 'Date must match pattern yyyy-MM-dd hh:mm:ss.000'
						}
					}
				}
			}
		});
	});
</script>
<form action="search" data-toggle="validator" role="form" id="form">
	<div class="panel panel-primary well">
		<div align="center" class="panel-heading">
			<h4><spring:message code="label.search" /></h4>
		</div>
		<div align="center" class="panel-body">
			<table>
				<td align="center"><label class="text-info"><spring:message code="label.competition.start_date" /></label><br/>
					<input name="start" type="text" value='<fmt:formatDate value="${dateStart}"
						pattern="yyyy-MM-dd hh:mm:ss.0" />'/>
				</td>
				<td>&nbsp;</td>
				<td align="center"><label class="text-info"><spring:message code="label.competition.end_date" /></label><br/>
					<input name="end" type="text" value='<fmt:formatDate value="${dateEnd}"
						pattern="yyyy-MM-dd hh:mm:ss.0" />'/>
				</td>
			</table>
			<br/>
			<div class="input-group">
				<div class="btn-group">
					<a href="all" class="btn btn-sm btn-success"><spring:message code="label.show_all_logs" /></a>
					<input type="submit" class="btn btn-sm btn-primary" value='<spring:message code="label.search" />'>
				</div>
			</div>
		</div>
	</div>
</form>
<br/>
<table id="logsTable" style="width:100%" class="table table-hover table-bordered well" border='1' cellspacing='0' cellpadding='2'>
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
<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
<h2 class="user-info-name">Add test race</h2>
<div style="max-width: 250px" class="well">
<c:if test="${membersCount > 0 }">

<form role="form" id="addTestRace" action="/Carting" method="post">
<div class="form-group">
<table width="200" class="table">
<thead>
<tr>
<th>Number</th>
<th>Time</th>
</tr>
</thead>
<tbody>
<c:forEach items="${validNumbers}" var="number">
<tr >
<td style="width: 100px; text-align: center"><h4>${number}</h4></td>
<td style="width: 100px;" class="time"><input type="hidden" value="${number}">

<input style="width: 100px;" required type="text" class="form-control" placeholder="mm:ss" name="time"
pattern="^\d\d:[0-5]\d$"
data-bv-regexp-message="The full name can consist of alphabetical characters and spaces only"
data-bv-notempty
data-bv-notempty-message='<spring:message code="dataerror.field_required"/>'
>
</td>
</tr>
</c:forEach>
</tbody>
</table>
<button type="submit" class="btn btn-success" id="addTestRacesubmit" value="Add">Add</button>
</div>
</form>

</c:if>
</div>

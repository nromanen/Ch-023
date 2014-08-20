<%@page import="net.carting.domain.Logs"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<table style="width:100%" border='1' cellspacing='0' cellpadding='2'>
<th>Logger</th>
<th>Level</th>
<th>Message</th>
<th>Date</th>
    <c:forEach items="${logs}" var="log">
        <tr>
            <td><c:out value="${log.level}"/></td>
            <td><c:out value="${log.logger}"/></td>
            <td><c:out value="${log.message}"/></td>
            <td><c:out value="${log.date}"/></td>
        </tr>
    </c:forEach>
</table>
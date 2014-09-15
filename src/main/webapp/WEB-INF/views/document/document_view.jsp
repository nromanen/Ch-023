<%--
  Created by IntelliJ IDEA.
  User: manson
  Date: 11.09.14
  Time: 4:58
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<script src="<c:url value="/resources/js/lib/pdf.js" />"></script>
<script src="<c:url value="/resources/js/view_pdf.js" />"></script>
<c:choose>
    <c:when test="${!exception}">
        <c:choose>
            <c:when test="${pdf}">
                <input type="hidden" id="pdf" value="${file.file}">
                <div style="text-align: center;">
                    <a href="" class="btn btn-primary" id="link"><spring:message code="label.document_download_pdf" /></a>
                </div>
                <div style="text-align: center;" id="pdfContainer" class = "pdf-content"></div>
            </c:when>
            <c:otherwise>
                <div style="text-align: center;">
                    <a href="data:application/jpg;base64,${file.file}">${file.name}</a>
                </div>
                <img src="data:image/jpg;base64,${file.file}" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <div class="alert alert-danger" id="change_feedback_email_error">
            <spring:message code="label.document_not_found" />!
        </div>
    </c:otherwise>
</c:choose>
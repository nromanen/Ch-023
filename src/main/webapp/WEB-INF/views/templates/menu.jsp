<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type='text/javascript' src='<c:url value="/resources/js/localization.js" />'></script>
<div class="navbar navbar-inverse" role="navigation">

    <div id="header" style="background-image: url('<c:url value="/resources/img/karting-header.jpg" />');">
        <img class="flag_icon language_toggle" onclick="test('ua')" src='<c:url value="/resources/img/ua.png" />'> 
        <img class="flag_icon language_toggle" onclick="test('en')" src='<c:url value="/resources/img/en.png" />'> 
        <img class="flag_icon language_toggle" onclick="test('ru')" src='<c:url value="/resources/img/ru.png" />'> 
    </div>

    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href='<c:url value="/"/>'> <span class="glyphicon glyphicon-fire"></span> <spring:message code="label.title" /></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href='<c:url value="/team/list"/>'><spring:message code="label.list_of_teams" /></a></li>
                <li><a href='<c:url value="/competition/list/${currentYear}/1"/>'> <spring:message code="label.competitions" /> </a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
                        <span class="glyphicon glyphicon-user" style="margin-right: 5px;"></span> 
                        <c:choose>
                            <c:when test="${username=='guest'}">
                            <spring:message code="label.guest" />
                            <b class="caret"></b>
                            </c:when>
                            <c:otherwise> ${username}<b class="caret"></b></c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu">
                        <c:if test="${username=='guest'}">
                            <li><a href="<c:url value="/leader" />"><spring:message code="label.registration" /></a></li>
                            <li><a href="<c:url value="/loginPage" />"><spring:message code="label.sign_in" /></a></li>
                        </c:if>
                        
                        <c:if test="${authority.equals('ROLE_TEAM_LEADER')}">
                            <li><a href="<c:url value="/leader/${leader.id}"/>"><spring:message code="label.personal_cabinet" /></a></li>
                        <c:choose>
                        <c:when test="${isTeamByLeader==false}">
                            <li><a href='<c:url value="/team/add" />'><spring:message code="label.add_team" /></a></li>
                        </c:when>
                        <c:when test="${isTeamByLeader==true}">
                            <li><a href="<c:url value="/team/${team.id}"/>"><spring:message code="label.my_team" /></a></li>
                            <c:if test="${teamSize>0}">
	                            <li class="dropdown-submenu"><a href="<c:url value="#" />"><spring:message code="label.add_document" /></a>
	                            <ul class="dropdown-menu">
	                                <li><a tabindex="-1" href="<c:url value="/document/add/1" />"><spring:message code="label.document_racer_license" /></a></li>
	                                <li><a href="<c:url value="/document/add/2" />"><spring:message code="label.document_racer_insurance" /></a></li>
	                                <li><a href="<c:url value="/document/add/3" />"><spring:message code="label.document_racer_medical_cerificate" /></a></li>
	                                <li><a href="<c:url value="/document/add/4" />"><spring:message code="label.document_racer_parental_permission" /></a></li>
	                            </ul>
	                            </li>
                            </c:if>
                        </c:when>
                        </c:choose>
                            <li><a href="<c:url value="/logout" />"><spring:message code="label.logout" /></a></li>
                        </c:if>

                        <c:if test="${authority.equals('ROLE_ADMIN')}">
                            <li><a href="<c:url value="/admin/cabinet"/>"><spring:message code="label.admin_area" /></a></li>
                            <li><a href="<c:url value="/document/checkingDocuments/0"/>"><spring:message code="label.checking_documents" />
                                <c:if test="${uncheckedDocsCount > 0}">&nbsp;<span class="badge">${uncheckedDocsCount}</span></c:if></a></li>
                            <li><a href="<c:url value="/document/allDocuments"/>"><spring:message code="label.all_documents" /></a></li>
                            <li><a href="<c:url value="/logout" />"><spring:message code="label.logout" /></a></li>
                        </c:if>
                    </ul>
                </li>
            <c:if test="${authority.equals('ROLE_TEAM_LEADER')}">
                <li><a href="<c:url value="/feedback" />"><spring:message code="label.feedback" /></a></li>
            </c:if>
            </ul>
        </div>
    </div> <!-- .container  -->
</div> <!-- .navbar -->
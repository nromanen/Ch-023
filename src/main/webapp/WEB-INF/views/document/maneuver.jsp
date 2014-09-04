<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript' src='<c:url value="/resources/js/maneuver.js" />'></script>
  <style type="text/css">
    td{
        text-align: center;
    }
    th{
        text-align: center;
    }
    tr{
        text-align: center;
    }
    thead{
        text-align: center;
    }
    tbody{
        text-align: center;
    }
  </style>
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="raceId" value="<c:out value="${raceId}"/>">
<input type="hidden" id="racersCount" value="<c:out value="${racers.size()}"/>">
<input type="hidden" id="tableB" value="${tableB}">
<input type="hidden" id="maneuverCount" value="${maneuvers.size()}">
<c:if test="${authority.equals('ROLE_ADMIN')}">
    <div class="panel panel-primary">
         <div class="panel-heading" style="height: 50px;">
            <div class="text-info" style="color: #fff; font-size: 20px; float: left;"><spring:message code="label.penalty_points" /></div>
         </div>
         <div class="panel-body" style="padding: 0px;">
            <c:choose>
                <c:when test="${!empty racers}">
                    <table class="table table-hover table-bordered" id="racers_table" style="text-align: center;">
                        <thead class="well">
                            <th style="text-align: center;">№</th>
                            <th style="text-align: center;"><spring:message code="label.racer" /></th>
                            <th style="text-align: center;"><spring:message code="label.number" /></th>
                            <th class="stopLine"><spring:message code="label.stopLine" /></th>
                            <c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
                                <th class="maneuver${index.count}"><c:out value="${maneuver.getName()}"/></th>
                            </c:forEach>
                            <th><spring:message code="label.time" /></th>
                        </thead>
                        <tbody>
                            <c:forEach items="${racers}" var="racer" varStatus="index">
                                <input type="hidden" id='<c:out value="id${index.count}"/>' value="<c:out value='${racer.getNumberInCompetition()}'/>">
                                <tr class="team${racer.racer.team.id}
                                    <c:if test='${!racer.racer.enabled}'>bg-danger</c:if>">
                                    <td>${index.count}</td>
                                    <td style="text-align: left; padding-left: 20px;">
                                        <a href="<c:url value="/racer/${racer.racer.id}" />"
                                            id="racer${racer.racer.id}">
                                            ${racer.racer.firstName} ${racer.racer.lastName}
                                        </a>
                                        <c:if test="${!racer.racer.enabled}">
                                            <span class="glyphicon glyphicon-remove" style="color: red; cursor: pointer; float: right;" title="Disabled"></span>
                                        </c:if>
                                    </td>
                                    <td>${racer.numberInCompetition}</td>
                                    <td class="stopLine"><input type="checkbox" class="stopLine" racer="${racer.numberInCompetition}"size="1"></td>
                                    <c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
                                        <td class="maneuver${index.count}"><input type="text" class="test maneuver${index.count}" racer="${racer.numberInCompetition}"size="1" value="0"></td>
                                    </c:forEach>
                                    <td><input type="text" class="time" racer="${racer.numberInCompetition}"size="1" value="0"></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

    <table width="100%" align="center">
        <theader>
            <tr>
                <td>
                    <span align="left">
                        <select id="del">
                            <c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
                                <option class="maneuver${index.count}">${maneuver.getName()}</option>
                            </c:forEach>
                            <option><spring:message code="label.empty" /></option>
                        </select>
                        <input class="btn btn-lg btn-warning btn-sm" type="button" id="remove" value='<spring:message code="label.delete" />'>
                    </span>
                </td>
                <td><span align="right"><a class="btn btn-primary btn-sm" id="save" ><spring:message code="label.accept_changes" /></a></span>
                <span align="right"><a class="btn btn-success btn-sm" id="pdf" disabled><spring:message code="label.document_download_pdf" /></a></span>
                <c:if test="${oldDoc > 0}">
                    <span align="right"><a id="prevVersion" class="btn btn-sm btn-warning" href="../../document/showFile/${oldDoc}" target="_blank"><spring:message code="label.previous_version_pdf" /></a></span>
                </c:if>
                </td>
            </tr>
        </theader>
    </table><p><p>
                    <div style="text-align: center;">
                        <spring:message code="label.skittle_fine" />: <input type="text" id="penalty" value="5" size="1">&emsp;
                        <spring:message code="label.max_allowed_broken_skittles" />: <input type="text" id="max_skittles" value="6" size="1">
                    </div><p>
                    <div class="alert alert-danger" style="display: none; margin-top: 5px;" id="no_racers">
                        <spring:message code="label.there_are_no_racers_from_your_team" />
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-danger" style="margin-top: 10px; margin-left: 5px;">
                        <spring:message code="label.racers_list_for_this_class_is_empty" />
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:if>
     <div class="alert alert-danger" id="incorrectPositions"
        style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
        <spring:message code="dataerror.document_start_incorrect_postions" />
    </div>
    <div class="alert alert-success" id="correctPositions"
        style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
        <spring:message code="label.data_save_success" />
    </div>     
<div align="center" id="maneuver">
<meta charset="utf-8">
<style>
    table {
        font-family: 'Arial', Arial, monospace;
    }
    span {
        font-family: 'Arial', Arial, monospace;
    }
</style>
    <table width="100%" align="center" cellspacing='0' cellpadding='2'>
            <tr>
                <td align='center'>
                   <span style="font-weight:bold;font-size:18pt"><spring:message code="label.ministry_of_education" /></span><p>
                   <span style="font-weight:bold;font-size:18pt"><spring:message code="label.state_center" /></span><p>
                   <span style="font-weight:bold;font-size:18pt;"><c:out value="${competitionName}"/></span>
                </td>
            </tr>
    </table>
    <table width="100%">
            <tr>
                <td align='left'><span><c:out value="${competitionPlace}"/></span></td>
                <td align='center'><span><spring:message code="label.car_classes" />: <c:out value="${carClassName}"/></span></td>
                <td align='right'><span><c:out value="${competitionDate}"/></span></td>
            </tr>
    </table>
    <table width="100%" align="center">
        <thead>
        <tr>
            <td align='center'>
                <span style="font-weight:bold;font-size:18pt"><spring:message code="label.maneuver_protocol" /></span><p>
            </td>
        </tr>
        </thead>
    </table>
        <table border="1" id="maneuverTable">
                <tr class="well" id="head">
                        <td align='center'>№ п/п</td>
                        <td align='center'><spring:message code="label.lastname_firstname" /></td>
                        <td align='center'><spring:message code="label.team_name" /></td>
                        <td align='center'><spring:message code="sportcategory.sport_category" /></td>
                        <td align='center'><spring:message code="label.start_number" /></td>
                        <c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
                            <td align='center' class="maneuver${index.count}">${maneuver.getName()}</td>
                        </c:forEach>
                        <td align='center' class="stopLine"><spring:message code="label.stopLine" /></td>
                        <td align='center'><spring:message code="label.time" /></td>
                        <td align='center'><spring:message code="label.points_sum" /></td>
                        <td align='center'><spring:message code="label.points_by_table_b" /></td>
                        <td align='center'><spring:message code="label.place" /></td>
                </tr>
            <c:forEach items="${racers}" var="racer" varStatus="index">
                <tr class="cols">
                    <td align="center" class="pos"><c:out value="${index.count}"/></td>
                    <td align="center" class="racername"><c:out value="${racer.getRacer().getLastName()}"/> <c:out value="${racer.getRacer().getFirstName()}"/></td>
                    <td align="center" class="teamname"><c:out value="${racer.getRacer().getTeam().getName()}"/></td>
                    <td align="center" class="sportcategory"><c:out value="${racer.getRacer().getStringSportsCategory()}"/></td>
                    <td align="center" class="pos"><c:out value="${racer.getNumberInCompetition()}"/></td>
                    <c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
                        <td align="center" class="maneuver${index.count} maneuvers"><span id="maneuver${index.count}${racer.getNumberInCompetition()}">0</span></td>
                    </c:forEach>
                    <td align="center" class="stopLine maneuvers"><span id="stopLine${racer.getNumberInCompetition()}">0</span></td>
                    <td align="center" class="time"><span class="timetext" id="time${racer.getNumberInCompetition()}">0</span></td>
                    <td align="center" class="maneuvers"><span id="sum${racer.getNumberInCompetition()}">0</span></td>
                    <td align="center" class="maneuvers"><span id="tableB${racer.getNumberInCompetition()}"></span></td>
                    <td align="center" class="place"><span id="place${racer.getNumberInCompetition()}"></span></td>
                </tr>
            </c:forEach> 
        </table>
    
    <table width="100%" align="center">
            <tr>
                <td align='left'><spring:message code="label.main_secretary" /></td>
                <td align='right'>(<spring:message code="label.judge" />: <c:out value="${judgeSecretary}"/>) <c:out value="${secretaryName}"/></td>
            </tr>
            <tr>
                <td align="left"><spring:message code="label.competition.director_name" />:</td>
                <td align="right">(<spring:message code="label.judge" />: <c:out value="${judgeDirector}"/>) <c:out value="${directorName}"/></td>
            </tr>
    </table>
</div>
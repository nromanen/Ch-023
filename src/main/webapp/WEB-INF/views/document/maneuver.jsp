<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript' src='<c:url value="/resources/js/maneuver.js" />'></script>
  <style type="text/css">
    .two {
        float:left;
        width:100%;
    }
    td{
        text-align: center;
    }
    th{
        text-align: center;
    }
    tr{
        text-align: center;
    }      
  </style>
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="raceId" value="${raceId}">
<input id="racersCount" type="hidden" value="<c:out value="${racers.size()}"/>">
<input type="hidden" id="add" value="Add">
<input type="hidden" id="tableB" value="${tableB}">
<c:if test="${authority.equals('ROLE_ADMIN')}">
    <div class="panel panel-primary">
         <div class="panel-heading" style="height: 50px;">
            <div class="text-info" style="color: #fff; font-size: 20px; float: left;">Штрафні очки</div>
         </div>
         <div class="panel-body" style="padding: 0px;">
            <c:choose>
                <c:when test="${!empty racers}">
                    <table class="table table-hover table-bordered" id="racers_table" style="text-align: center;">
                        <thead class="well">
                            <th style="text-align: center;">№</th>
                            <th style="text-align: center;"><spring:message code="label.racer" /></th>
                            <th style="text-align: center;"><spring:message code="label.number" /></th>
                            <th class="snake">Змійка</th>
                            <th class="leftCircle">Коло ліве</th>
                            <th class="rightCircle">Коло праве</th>
                            <th class="flower">Квітка</th>
                            <th class="hall">Коридор</th>
                            <th class="rightCol">Колія права</th>
                            <th class="leftCol">Колія ліва</th>
                            <th class="stopLine">Лінія "стоп"</th>
                            <th>Час</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${racers}" var="racerCarClassCompetitionNumber" varStatus="index">
                                <input type="hidden" id='<c:out value="id${index.count}"/>' value="<c:out value='${racerCarClassCompetitionNumber.getNumberInCompetition()}'/>">
                                <tr class="team${racerCarClassCompetitionNumber.racer.team.id}
                                    <c:if test='${!racerCarClassCompetitionNumber.racer.enabled}'>bg-danger</c:if>">
                                    <td>${index.count}</td>
                                    <td style="text-align: left; padding-left: 20px;">
                                        <a href="<c:url value="/racer/${racerCarClassCompetitionNumber.racer.id}" />"
                                            id="racer${racerCarClassCompetitionNumber.racer.id}">
                                            ${racerCarClassCompetitionNumber.racer.firstName} ${racerCarClassCompetitionNumber.racer.lastName}
                                        </a>
                                        <c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">
                                            <span class="glyphicon glyphicon-remove" style="color: red; cursor: pointer; float: right;" title="Disabled"></span>
                                        </c:if>
                                    </td>
                                    <td>${racerCarClassCompetitionNumber.numberInCompetition}</td>
                                    <td class="snake"><input type="text" class="snake" racer="${racerCarClassCompetitionNumber.numberInCompetition}" size="1" value="0"></td>
                                    <td class="leftCircle"><input type="text" class="leftCircle" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="rightCircle"><input type="text" class="rightCircle" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="flower"><input type="text" class="flower" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="hall"><input type="text" class="hall" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="rightCol"><input type="text" class="rightCol" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="leftCol"><input type="text" class="leftCol" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td class="stopLine"><input type="text" class="stopLine" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                    <td><input type="text" class="time" racer="${racerCarClassCompetitionNumber.numberInCompetition}"size="1" value="0"></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <tr>
                            <td><span align="left"><a class="btn btn-primary btn-sm" id="save" ><spring:message code="label.accept_changes" /></a></span></td>
                            <td><span align="left"><a class="btn btn-success btn-sm" id="pdf" disabled><spring:message code="label.document_download_pdf" /></a></span></td>
                            <td><c:if test="${oldDoc > 0}">
                                <span align="left"><a id="prevVersion" class="btn btn-sm btn-warning" href="../../document/showFile/${oldDoc}" target="_blank"><spring:message code="label.previous_version_pdf" /></a></span>
                            </c:if></d>
 </tr><tr>
                            <td><span align="right"><select id="del">
                                <option class="snake">Змійка</option>
                                <option class="leftCircle">Коло ліве</option>
                                <option class="rightCircle">Коло праве</option>
                                <option class="flower">Квітка</option>
                                <option class="hall">Коридор</option>
                                <option class="rightCol">Колія права</option>
                                <option class="leftCol">Колія ліва</option>
                                <option class="stopLine">Лінія "стоп"</option>     
                                <option>Пусто</option>
                            </select>
                            <input class="btn btn-lg btn-warning btn-sm" type="button" id="remove" value="Remove">
                            <input class="btn btn-lg btn-default btn-sm" type="button" id="add" value="Add"></span></td>
                            <tr><td><span align="right">Штраф за збиту кеглю: <input type="text" id="penalty" value="5" size="1"></span></td></tr>
                            
                        </tr>
                    </table><p>
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
<div id="maneuver">
<style>
    table {
        font-family: "Arial", Times, monospace;
    }
    span {
        font-family: "Arial", Times, monospace;
    }
</style>
    <center><span align="center" style="font-weight:bold;font-size:20pt"><c:out value="${competitionName}"/></span></center>
    <table width="100%" align="center">
        <theader>
            <tr>
                <td><span align="left"><c:out value="${competitionPlace}"/></span></td>
                <td><span align="center"><center><spring:message code="label.car_class" />: <c:out value="${carClassName}"/></center></span></td>
                <td><span align="right"><c:out value="${competitionDate}"/></span></td>
            </tr>
        </theader>
    </table>
    <center><span align="center" style="font-weight:bold;font-size:20pt">Протокол особистого заліку з Швидкісного маневрування</span></center>
        <table class="two" border="1" id="maneuverTable">
                <tr class="well" id="head">
                    <theader>
                        <td>№ п/п</td>
                        <td>Прізвище, ім'я</td>
                        <td>Назва команди</td>
                        <td>Спортивний розряд</td>
                        <td>Ст. №</td>
                        <td class="snake">Змійка</td>
                        <td class="leftCircle">Коло ліве</td>
                        <td class="rightCircle">Коло праве</td>
                        <td class="flower">Квітка</td>
                        <td class="hall">Коридор</td>
                        <td class="rightCol">Колія права</td>
                        <td class="leftCol">Колія ліва</td>
                        <td class="stopLine">Лінія "стоп"</td>   
                        <td>Час</td>
                        <td>Сума очок</td>
                        <td>Зайняте місце</td>
                        <td>Сума очок по табл. Б</td>   
                    </theader>
                </tr>
            <c:forEach items="${racers}" var="racer" varStatus="index">
                <tr class="cols">
                    <td><c:out value="${index.count}"/></td>
                    <td><c:out value="${racer.getRacer().getLastName()}"/> <c:out value="${racer.getRacer().getFirstName()}"/></td>
                    <td><c:out value="${racer.getRacer().getTeam().getName()}"/></td>
                    <td><c:out value="${racer.getRacer().getStringSportsCategory()}"/></td>
                    <td><c:out value="${racer.getNumberInCompetition()}"/></td>
                    <td class="snake"><span id="snake${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="leftCircle"><span id="leftCircle${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="rightCircle"><span id="rightCircle${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="flower"><span id="flower${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="hall"><span id="hall${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="rightCol"><span id="rightCol${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="leftCol"><span id="leftCol${racer.getNumberInCompetition()}">0<span/></td>
                    <td class="stopLine"><span id="stopLine${racer.getNumberInCompetition()}">0<span/></td>  
                    <td><span id="time${racer.getNumberInCompetition()}">0<span/></td>
                    <td><span id="sum${racer.getNumberInCompetition()}">0<span/></td>
                    <td><span id="place${racer.getNumberInCompetition()}"><span/></td>
                    <td><span id="tableB${racer.getNumberInCompetition()}"><span/></td>                    
                </tr>
            </c:forEach> 
        </table>
    
    <table width="100%" align="center">
        <theader>
            <tr>
                <td><div align="left">Головний секретар змагань:</div></td>
                <td><div align="right"><c:out value="${secretaryName}"/></div></td>
            </tr>
            <tr>
                <td><div align="left">Директор перегонів:</div></td>
                <td><div align="right"><c:out value="${directorName}"/></div></td>
            </tr>
        </theader>
    </table>
<div>
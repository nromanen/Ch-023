<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript'>
$(document).ready(function(){
    $("#pdf").click(function() {
        $.ajax({
            url: "/Carting/SHKP/start",
            type: "POST",
            data: {
                table: $('#table').html()
            }
        });
    });
});
</script>

<c:if test="${authority.equals('ROLE_ADMIN')}">
<center><a class="btn btn-lg btn-primary" id="pdf" href="${pdfLink}" ><spring:message code="label.document_start" /></a><p></center>

    <div class="panel panel-primary">
         <div class="panel-heading" style="height: 50px;">
            <div class="text-info" style="color: #fff; font-size: 20px; float: left;"><spring:message code="label.registered_racers" /></div>
         </div>
         <div class="panel-body" style="padding: 0px;">
            <c:choose>
                <c:when test="${!empty racerCarClassCompetitionNumberList}">
                    <table class="table table-hover table-bordered" id="racers_table" style="text-align: center;">
                        <thead class="well">
                            <th style="text-align: center;">№</th>
                            <th style="text-align: center;"><spring:message code="label.racer" /></th>
                            <th style="text-align: center;"><spring:message code="label.number" /></th>
                            <th style="text-align: center;">&nbsp;</th>
                        </thead>
                        <tbody>
                            <% int number = 1; %>
                            <c:forEach items="${racerCarClassCompetitionNumberList}" var="racerCarClassCompetitionNumber">
                                <tr class="team${racerCarClassCompetitionNumber.racer.team.id}
                                    <c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">bg-danger</c:if>">
                                    <td><%= number %></td>
                                    <td style="text-align: left; padding-left: 20px;">
                                        <a href="<c:url value="/racer/${racerCarClassCompetitionNumber.racer.id}" />"
                                            id="racer${racerCarClassCompetitionNumber.racer.id}">
                                            ${racerCarClassCompetitionNumber.racer.firstName} ${racerCarClassCompetitionNumber.racer.lastName}
                                        </a>
                                        <c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">
                                            <span class="glyphicon glyphicon-remove" style="color: red; cursor: pointer; float: right;" title="Disabled"></span>
                                        </c:if>
                                    </td>
                                    <td>
                                        ${racerCarClassCompetitionNumber.numberInCompetition}
                                    </td>
                                    <td>
                                        <input type="text">
                                    </td>
                                </tr>
                                <% number++; %>
                            </c:forEach>
                        </tbody>
                    </table>
                    <right><a class="btn btn-lg btn-primary" id="pdf" href="${pdfLink}" ><spring:message code="label.accept_changes" /></a><p></right>
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


<div id='table'>
<meta charset="utf-8">
<style>
  table {
    font-family: 'Times New Roman', Times, serif;
  }
    .place {
     font-size: 250%;
     font-family: serif;
     position: relative;
     left: 20px;
     text-decoration: underline;
    }
</style>
  <table style="width:100%" border='1' cellspacing='0' cellpadding='2'>
        <tr>
            <td align='center' colspan='2'><c:out value="${competitionName}"/></td>
            <td align='center' colspan='2'><c:out value="${competitionName}"/></td>
        </tr>
        <tr>
            <td align='center' colspan='2'><c:out value="${carClassName}"/></td>
            <td align='center' colspan='2'><c:out value="${carClassName}"/></td>
        </tr>
        <tr>
            <td colspan='2' align='center'><b>Протокол старту</b></td>
            <td colspan='2' align='center'><b>Протокол старту</b></td>
        </tr>
        <c:forEach var="i" begin="1" end="35" step="2">
            <c:set var="j" value="${36-i}"/>
            <c:set var="k" value="${36-i+1}"/>
            <tr>
                <td width='25%'><c:out value="${k}"/>)<span class='place' id="p{k}"></span></td>
                <td width='25%'><c:out value="${j}"/>)<span class='place' id="p{j}"></span></td>
                <td width='25%'><c:out value="${k}"/>)<span class='place' id="p{k}"></span></td>
                <td width='25%'><c:out value="${j}"/>)<span class='place' id="p{j}"></span></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan='2'>Допущено: <c:out value="${allowedNumber}"/></td>
            <td colspan='2'>Допущено: <c:out value="${allowedNumber}"/></td>
        </tr>
        <tr>
            <td colspan='2'>З них стартувало: <c:out value="${startedNumber}"/></td>
            <td colspan='2'>З них стартувало: <c:out value="${startedNumber}"/></td>
        </tr>
        <tr>
            <td colspan='2'>Головний секретар: <c:out value="${secretaryName}"/></td>
            <td colspan='2'>Головний секретар: <c:out value="${secretaryName}"/></td>
        </tr>
  </table>
</div>
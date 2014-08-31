<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type='text/javascript'>
$(document).ready(function(){

    function updatePDF() {
        $.ajax({
            url: "/Carting/SHKP/start",
            type: "POST",
            data: {
                table: $('#table').html(),
                startId: $('#startId').val(),
                raceId: $('#raceId').val()
            },
            success: function(response) {
                if (response !== '0') {
                    $("#fileId").val(response);
                    $("#pdf").removeAttr("disabled");
                    $("#prevVersion").remove();
                }
            }
        });
    }

    function clearTable() {
        $(".place").each(function() {
            $(this).text("");
        });
    }

    $("#pdf").click(function() {
        window.open("../../../document/showFile/" + $("#fileId").val() ,'_blank');
    });

    $("#save").click(function() {    
        clearTable();
        var arr = [];
        var max = Number($("#maxPos").val());
        var valid = true;
        $(".carPos").each(function() {
            var racerNum = $(this).attr('racer');
            var pos = $(this).val();
            var startPos = ".p" + $(this).val();
            if (pos >=1 && pos <= max) {
                $(startPos).each(function() {
                    $(this).text(racerNum);
                });
            } else {
                valid = false;
            }
            arr.push(pos);
        });
        var sorted_arr = arr.sort();
        for (var i = 0; i < arr.length - 1; i++) {
            if (sorted_arr[i + 1] == sorted_arr[i]) {
                valid = false;        
            }
        }        

        if (valid == true) {
            $('#correctPositions').css("display", "inline-block").hide().fadeIn();
            $('#correctPositions').delay(2000).fadeOut('slow');            
           updatePDF();
        } else {
            $('#incorrectPositions').css("display", "inline-block").hide().fadeIn();
            $('#incorrectPositions').delay(2000).fadeOut('slow');
        }
    });
    var s = $("#qual_count").val()
    if (s>0) {
    	$("#save").click()
    }
    
});
</script>

<c:if test="${authority.equals('ROLE_ADMIN')}">
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
                            <th style="text-align: center;"><spring:message code="label.document_start_pos" /></th>
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
                                            <input type="text" class="carPos" racer="${racerCarClassCompetitionNumber.numberInCompetition}"
                                            pattern="[0-9]{2}"
                                            <c:if test="${!empty qualifyingList}">
                                            	value="${qualifyingList.get(counter.index).racerPlace}"
                                            </c:if>
                                            >
                                            <input type="hidden" value="${qualifyingList.size()}" id="qual_count">
                                    </td>
                                </tr>
                                <% number++; %>
                            </c:forEach>
                        </tbody>
                    </table>
                    <center>
                        <a class="btn btn-sml btn-primary" id="save" ><spring:message code="label.accept_changes" /></a>
                        <a class="btn btn-sml btn-success" id="pdf" disabled><spring:message code="label.document_download_pdf" /></a>
                        <c:if test="${oldDoc > 0}">
                            <a id="prevVersion" class="btn btn-sml btn-warning" href="../../../document/showFile/${oldDoc}" target="_blank"><spring:message code="label.previous_version_pdf" /></a>
                        </c:if><p>
                    </center>
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
<input type="hidden" id="fileId" value="0">
<input type="hidden" id="raceId" value="${raceId}">
<input type="hidden" id="startId" value="${startId}">
<input type="hidden" id="maxPos" value="${maxPositions}">
<div id='table'>
<meta charset="utf-8">
 <style>
     table {
        font-family: "Arial", Times, monospace;
     }
     .place {
      font-size: 250%;
      font-family: monospace;
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
            <td align='center' colspan='2'><c:out value="${competitionLoc}"/></td>
            <td align='center' colspan='2'><c:out value="${competitionLoc}"/></td>
        </tr>
        <tr>
            <td align='center' colspan='2'><c:out value="${competitionDate}"/></td>
            <td align='center' colspan='2'><c:out value="${competitionDate}"/></td>
        </tr>
        <tr>
            <td align='center' colspan='2'><spring:message code="label.car_class" />: <b><c:out value="${carClassName}"/></b></td>
            <td align='center' colspan='2'><spring:message code="label.car_class" />: <b><c:out value="${carClassName}"/></b></td>
        </tr>
        <tr>
            <td align='center' colspan='2'><spring:message code="label.date" />: <c:out value="${carClassDate}"/> <spring:message code="label.time" />: <c:out value="${carClassTime}"/></td>
            <td align='center' colspan='2'><spring:message code="label.date" />: <c:out value="${carClassDate}"/> <spring:message code="label.time" />: <c:out value="${carClassTime}"/></td>
        </tr>
        <tr>
            <td align='center' colspan='2'><spring:message code="label.run" /> <c:out value="${carClassRace}"/></td>
            <td align='center' colspan='2'><spring:message code="label.run" /> <c:out value="${carClassRace}"/></td>
        </tr>
        <tr>
            <td colspan='2' align='center'><b><spring:message code="label.start_statement" /></b></td>
            <td colspan='2' align='center'><b><spring:message code="label.start_statement" /></b></td>
        </tr>
        <c:forEach var="i" begin="1" end="${maxPositions}" step="2">
            <c:set var="j" value="${maxPositions-i+1}"/>
            <c:set var="k" value="${maxPositions-i}"/>
            <tr>
                <td width='25%'><c:out value="${j}"/>)<span class="place p${j}"></span></td>
                <td width='25%'><c:out value="${k}"/>)<span class="place p${k}"></span></td>
                <td width='25%'><c:out value="${j}"/>)<span class="place p${j}"></span></td>
                <td width='25%'><c:out value="${k}"/>)<span class="place p${k}"></span></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan='2'><spring:message code="label.allowed" /> <c:out value="${allowedNumber}"/></td>
            <td colspan='2'><spring:message code="label.allowed" /> <c:out value="${allowedNumber}"/></td>
        </tr>
        <tr>
            <td colspan='2'><spring:message code="label.started" /> <c:out value="${startedNumber}"/></td>
            <td colspan='2'><spring:message code="label.started" /> <c:out value="${startedNumber}"/></td>
        </tr>
        <tr>
            <td colspan='2'><spring:message code="label.main_secretary" /> <c:out value="${secretaryName}"/></td>
            <td colspan='2'><spring:message code="label.main_secretary" /> <c:out value="${secretaryName}"/></td>
        </tr>
  </table>
</div>
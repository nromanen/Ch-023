<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 30px 60px 30px;">

<table class="width-100">
    <tr>
        <td>
            <h2 class="user-info-name"><spring:message code="label.car_class" /> "${carClassCompetition.carClass.name}"</h2>
        </td>
        <td style="padding: 15px 0px 0px 20px;">
            <c:if test="${authority.equals('ROLE_ADMIN')}">
                <div class="btn-group" style="float: right;">
                    <c:forEach var="i" begin="1" end="${maxRaces}">
                        <a href='<c:url value="/SHKP/start/${carClassCompetition.id}/${i}" />' class="btn btn-success"><spring:message code="label.document_start" /> <c:out value="${i}"/></a>
                    </c:forEach>
                    <a href='<c:url value="/SHKP/manevr/${carClassCompetition.id}" />' class="btn btn-success"><spring:message code="label.maneuvering" /></a>
                    <c:if test="${raceListSize<2 &&!empty racerCarClassCompetitionNumberList}">
                            <a href='<c:url value="/carclass/${carClassCompetition.id}/addResults" />' class="btn btn-primary"><spring:message code="label.add_results" /></a>
                    </c:if>
                </div>
            </c:if>
        </td>
    </tr>
</table>

<div><label class="text-info"><spring:message code="label.competition_name" />&nbsp;</label>${carClassCompetition.competition.name}</div>
<div><label class="text-info"><spring:message code="label.competition.first_race_date" />&nbsp;</label>
    <fmt:formatDate value="${carClassCompetition.firstRaceTime}" pattern="HH:mm" />&nbsp;
    <fmt:formatDate value="${carClassCompetition.competition.firstRaceDate}" pattern="dd-MM-yyyy" />
</div>
<div><label class="text-info"><spring:message code="label.competition.second_race_date" />&nbsp;</label>
    <fmt:formatDate value="${carClassCompetition.secondRaceTime}" pattern="HH:mm" />&nbsp;
    <fmt:formatDate value="${carClassCompetition.competition.secondRaceDate}" pattern="dd-MM-yyyy" />
</div>
<div><label class="text-info"><spring:message code="label.competition.lap_count" />&nbsp;</label>${carClassCompetition.circleCount}</div>
<div><label class="text-info"><spring:message code="label.competition.percentage_offset" />&nbsp;</label>${carClassCompetition.percentageOffset}%</div>
<div><label class="text-info"><spring:message code="label.age_limit" />&nbsp;</label>${carClassCompetition.carClass.lowerYearsLimit}-${carClassCompetition.carClass.upperYearsLimit}</div>

<div class="panel panel-primary">
     <div class="panel-heading" style="height: 50px;">
        <div class="text-info" style="color: #fff; font-size: 20px; float: left;"><spring:message code="label.registered_racers" /></div>
        <c:if test="${authority.equals('ROLE_TEAM_LEADER')}">
            <c:if test="${!empty racerCarClassCompetitionNumberList}">
                <div class="btn-group" style="float: right;">
                    <input type="hidden" value="team${teamByLeader.id}" id="team_id">
                    <a href="#" class="btn btn-default btn-sm" id="my_team"><spring:message code="label.my_team" /></a>
                    <a href="#" class="btn btn-default btn-sm active" id="all_teams"><spring:message code="label.all_teams" /></a>
                </div>
            </c:if>
        </c:if>
     </div>
     <div class="panel-body" style="padding: 0px;">
        <c:choose>
            <c:when test="${!empty racerCarClassCompetitionNumberList}">
                <table class="table table-hover table-bordered" id="racers_table" style="text-align: center;">
                    <thead class="well">
                        <th style="text-align: center;">№</th>
                        <th style="text-align: center;"><spring:message code="label.racer" /></th>
                        <th style="text-align: center;"><spring:message code="label.number" /></th>
                        <c:if test="${authority.equals('ROLE_TEAM_LEADER') && carClassCompetition.competition.enabled }">
                            <th style="text-align: center;">&nbsp;</th>
                        </c:if>
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
                                <c:if test="${authority.equals('ROLE_TEAM_LEADER') && carClassCompetition.competition.enabled }">
                                    <td>
                                        <c:if test="${racerCarClassCompetitionNumber.racer.team.id==teamByLeader.id}">
                                            <a href="#" class="btn btn-danger btn-xs unreg_racer_btn"
                                               id="unreg${racerCarClassCompetitionNumber.racer.id}">Unregister</a>
                                        </c:if>
                                    </td>
                                </c:if>
                            </tr>
                            <% number++; %>
                        </c:forEach>
                    </tbody>
                </table>
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
        <c:if test="${authority.equals('ROLE_TEAM_LEADER') && carClassCompetition.competition.enabled }">
            <div style="width: 100%; text-align: center;">
                <a href="#" class="btn btn-primary btn-sm" style="margin: 5px 10px 20px 0px; " id="reg_racer_btn"><spring:message code="label.register_racer" /></a>
            </div>
        </c:if>
    </div>
</div>

<!-- Unregister racer modal -->
<div class="modal fade" id="unreg_racer_modal" tabindex="-1" role="dialog">
<div class="modal-dialog" style="margin-top: 15%;">
    <div class="modal-content">
        <div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
            <h4 class="modal-title"><spring:message code="label.unregister_racer_from_car_class" /></h4>
        </div>
        <div class="modal-body">
            <label class="text-info"><spring:message code="label.unregister_confirm" /> <span id="racer_name"></span> <spring:message code="label.from_class" />&nbsp;</label>
            <input type="hidden" id="unreg_racer_url" value="<c:url value="/carclass/${carClassCompetition.id}/unregisterRacer" />">
            <input type="hidden" id="unreg_racer_id" value="<c:url value="" />">
            <br><br>
            <div class="alert alert-danger" id="unreg_error"
                style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
                <spring:message code="label.unregister_failed" />
            </div>
            <img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_unreg">
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
            <button class="btn btn-danger" type="button" id="unreg_racer"><spring:message code="label.unregister" /></button>
        </div>
    </div>
</div>
</div>

<!-- Register racer modal, only for team leaders -->
<c:if test="${authority.equals('ROLE_TEAM_LEADER')}">
<div class="modal fade" id="reg_racer_modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="margin-top: 15%;">
        <div class="modal-content">
                <div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
                    <h4 class="modal-title"><spring:message code="label.register_racer_on_car_class" /></h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="reg_racer_url" value="<c:url value="/carclass/${carClassCompetition.id}/registerRacer" />">
                    <input type="hidden" id="reg_racer_get_number_url" value="<c:url value="/carclass/getRacerNumber" />">
                    <input type="hidden" id="reg_racer_carclass_id" value="${carClassCompetition.carClass.id}">

                    <label class="text-info"><spring:message code="label.racer_from_your_team" />&nbsp;</label>
                    <select class="form-control span6" id="reg_racer_id">
                        <option value=""><spring:message code="label.choose_racer_from_your_team" /></option>
                        <c:if test="${(!empty teamByLeader.racers)}">
                            <c:forEach items="${teamByLeader.racers}" var="racer">
                                <c:choose>
                                    <c:when test="${!empty disableRacersToRegistration && disableRacersToRegistration.contains(racer)}">
                                        <option value="${racer.id}" disabled>${racer.firstName} ${racer.lastName}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${racer.id}">${racer.firstName} ${racer.lastName}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </select><br>

                    <label class="text-info"><spring:message code="label.racer_number_in_car_class" />&nbsp;</label>
                    <input type="text" class="form-control" id="reg_racer_number" disabled value="" />

                    <br>
                    <div class="alert alert-danger" id="reg_racer_empty"
                        style="display: none; padding: 0px 0px 0px 10px; height: 25px;"><spring:message code="label.select_racer" /></div>

                    <img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_reg">
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
                    <button class="btn btn-success" type="button" id="reg_racer"><spring:message code="label.register" /></button>
                </div>
        </div>
    </div>
</div>
</c:if>


<div>
<c:if test="${raceListSize==2}">
    <c:if test="${!empty absoluteResultsList}">
        <div class="panel panel-primary">
                <div class="panel-heading" style="height: 50px;">
        <div class="text-info" style="color: #fff; font-size: 20px; float: left;"><spring:message code="label.summary_results" /></div>
                <c:if test="${authority.equals('ROLE_ADMIN')}">
                    <div class="btn-group" style="float: right;">
                        <a href='<c:url value="/carclass/${carClassCompetition.id}/editSummaryResults" />' class="btn btn-info " id="edit_results_button"><spring:message code="label.edit" /></a>
                    </div>
                </c:if>
        </div>

            <div class="panel-body" style="padding: 0px;">
            <table id="abs-table" class="table table-hover table-bordered" style="text-align: center;">
                            <thead class="well" style="font-weight: 100;">
                                <th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
                                <th style="text-align: center;"><spring:message code="label.car_number" /></th>
                                <th style="text-align: center;"><spring:message code="label.racer" /></th>
                                <th style="text-align: center;"><spring:message code="label.summary_results_editing_summarypoints" /></th>
                                <th style="text-align: center;"><spring:message code="label.summary_results_editing_comment" /></th>
                            </thead>
                            <tbody>
                                <c:if test="${!empty absoluteResultsList}">
                                    <c:forEach items="${absoluteResultsList}" var="absoluteResult">
                                        <tr>
                                            <td>${absoluteResult.absolutePlace}</td>
                                            <td>${absoluteResult.racerCarClassCompetitionNumber.numberInCompetition}</td>
                                            <td style="text-align: left;">
                                                <a href='<c:url value="/racer/${absoluteResult.racerCarClassCompetitionNumber.racer.id}" />'>
                                                    ${absoluteResult.racerCarClassCompetitionNumber.racer.firstName} ${absoluteResult.racerCarClassCompetitionNumber.racer.lastName}
                                                </a>
                                            </td>
                                            <td>${absoluteResult.absolutePoints}</td>
                                            <td>${absoluteResult.comment}</td>

                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
            </div>
        </div>
    </c:if>
</c:if>
</div>

    <div>
        <c:if test="${!empty raceResultsLists}">
            <c:forEach items="${raceResultsLists}" var="raceResultsList" varStatus="status">
            <div class="panel-group" id="accordition">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="height: 50px;">
                        <div class="text-info" style="color: #fff; font-size: 20px; float: left;">
                            <a data-toogle="collapse" style="color: #fff;" data-parent="#accordition" href="#race${status.index+1}">
                            <spring:message code="label.race" /> #${ status.index+1} <spring:message code="label.results" />
                            </a>
                        </div>
                        <c:if test="${authority.equals('ROLE_ADMIN')}">
                            <div class="btn-group" style="float: right;">
                                <a href='<c:url value="/carclass/${carClassCompetition.id}/race/${status.index+1}/edit" />' class="btn btn-info " id="edit_raceresults_button"><spring:message code="label.edit" /></a>
                            </div>
                        </c:if>
                    </div>




                <div id="race${status.index+1}" class=" testcollapsing panel-collapse collapse" >
                    <div class="panel-body" >
                        <c:if test="${!empty chessRollsList[status.index]}">
                            <table id="chess-table" class="table table-hover table-bordered">
                                <tbody>
                                    <c:forEach items="${chessRollsList[status.index]}" var="circle" varStatus="loop">
                                        <tr>
                                            <td><strong><spring:message code="label.lap" /> ${loop.index+1}:</strong> ${circle}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                        <table id="res-table" class="table table-hover table-bordered" style="text-align: center;">
                            <thead class="well" style="font-weight: 100;">
                                <th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
                                <th style="text-align: center;"><spring:message code="label.car_number" /></th>
                                <th style="text-align: center;"><spring:message code="label.racer" /></th>
                                <th style="text-align: center;"><spring:message code="label.full_laps" /></th>
                                <th style="text-align: center;"><spring:message code="label.points" /></th>
                            </thead>
                            <tbody>
                                <c:if test="${!empty raceResultsList}">
                                    <c:forEach items="${raceResultsList}" var="raceResult">
                                        <tr>
                                            <td>${raceResult.place}</td>
                                            <td>${raceResult.carNumber}</td>
                                            <td style="text-align: left;"><a
                                                href='<c:url value="/racer/${raceResult.racer.id}" />'>
                                                    ${raceResult.racer.firstName} ${raceResult.racer.lastName}</a></td>
                                            <td>${raceResult.fullLaps}</td>
                                            <td>${raceResult.points}</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
            </c:forEach>
        </c:if>
    </div>
</div>

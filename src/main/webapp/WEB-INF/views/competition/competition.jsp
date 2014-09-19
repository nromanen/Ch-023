<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="<c:url value="/resources/libs/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css" />" rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrap-switch/js/bootstrap-switch.min.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/competition.js" />'></script>     
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>       
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>


<link href="<c:url value="/resources/libs/pickmeup/pickmeup.css" />" rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/libs/pickmeup/pickmeup.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 10px 20px 40px;"> 
		       		
	<table class="width-100">
		<tr>
			<td style="width: 65%;">
				<h2 class="user-info-name">${competition.name}</h2>
			</td>
		    <td style="width: 35%; padding: 15px 10px 0px 20px;">
		    	<c:if test="${authority.equals('ROLE_ADMIN')}">
			    	<div class="btn-group" style="float: right;">
			    		<c:if test="${competition.enabled}">
							<a href='<c:url value="/competition/edit/${competition.id}" />' class="btn btn-info">
								<spring:message code="label.edit" />
							</a>
						</c:if>
						
						<a href="#" class="btn btn-danger" id="delete_competition_btn">
							<spring:message code="label.delete" />
						</a>
						<c:if test="${competition.enabled && !competition.calculateByTableB }">
							<div style="margin-top: 40px;">
								<a href="#" class="btn btn-info" id="edit_points_btn">
									<spring:message code="label.edit_points" />
								</a>
							</div>
						</c:if>
					</div>
				</c:if>
			</td>
		</tr>
	</table>
    
    <input type="hidden" id="competition_id" value="${competition.id}">
    <input type="hidden" id="enable_url" value="<c:url value="/competition/setEnabled"/>">
    <input type="checkbox" id="enabled" 
    	<c:if test="${competition.enabled==true}">checked</c:if>
    	<c:if test="${!authority.equals('ROLE_ADMIN')}">
    		disabled
    	</c:if>
    />
    <c:if test="${!authority.equals('ROLE_ADMIN')}">
	    <c:if test="${competition.enabled==true}">
	    	<span style="margin-left: 5px; font-size: 13px; color: green;">
	    		<spring:message code="label.competition.registration_continues" />
	    	</span>
	    </c:if> 
	    <c:if test="${competition.enabled==false}">
	    	<span style="margin-left: 5px; font-size: 13px; color: red;">
	    		<spring:message code="label.competition.registration_completed" />
	    	</span>
	    </c:if> 
    </c:if>  
    <br><br>
    
    <table class="width-100" border=0>
		<tr>
			<td style="width: 60%; vertical-align: top;">
				<div>
					<label class="text-info">
						<spring:message code="label.competition.place" />:&nbsp;
					</label>
					${competition.place}
				</div>					
				<div>
					<label class="text-info"><spring:message code="label.competition.start_date" />:&nbsp;</label>
					<span id="start_date"><fmt:formatDate value="${competition.dateStart}" pattern="yyyy-MM-dd" /></span>
				</div>
				<div>
					<label class="text-info"><spring:message code="label.competition.end_date" />:&nbsp;</label>
					<span id="end_date"><fmt:formatDate value="${competition.dateEnd}" pattern="yyyy-MM-dd" /></span>
				</div>
				<div><label class="text-info"><spring:message code="label.competition.first_race_date" />:&nbsp;</label>
					<fmt:formatDate value="${competition.firstRaceDate}" pattern="yyyy-MM-dd" />
				</div>
				<div><label class="text-info"><spring:message code="label.competition.second_race_date" />:&nbsp;</label>
					<fmt:formatDate value="${competition.secondRaceDate}" pattern="yyyy-MM-dd" />
				</div>
				<div>
					<label class="text-info"><spring:message code="label.competition.secretary_name" />:&nbsp;</label>
					${competition.secretaryName}
				</div>	
				<div>
					<label class="text-info"><spring:message code="label.competition.secretary_category_judicial_license" />:&nbsp;</label>
					${competition.secretaryCategoryJudicialLicense}
				</div>	
				<div>
					<label class="text-info"><spring:message code="label.competition.director_name" />:&nbsp;</label>
					${competition.directorName}
				</div>	
				<div>
					<label class="text-info"><spring:message code="label.competition.director_category_judicial_license" />:&nbsp;</label>
					${competition.directorCategoryJudicialLicense}
				</div>	
				<div>
					<label class="text-info"><spring:message code="label.competition.calculation_type" />:&nbsp;</label>
					<c:choose>
						<c:when test="${competition.calculateByTableB }">
							<spring:message code="label.competition.calculate_by_table_b" />
						</c:when>
						<c:otherwise>
							<spring:message code="label.competition.calculate_by_table_a" />
						</c:otherwise>
					</c:choose>
				</div>	
			</td>
		    <td style="width: 40%; padding: 0px 10px 0px 20px; vertical-align: top; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">
				<div id="competition_calendar" class="single" style="float: right;"></div>
				<input type="hidden" id="competition_calendar_url" value="<c:url value="/competition/${competition.id}/calendar" />">
			</td>
		</tr>
	</table>	
		
	<br>
	<div class="btn-group">
	<a href="<c:url value="/competition/${competition.id}/mandat" />" class="btn btn-primary">
		<spring:message code="label.competition.mandat_statement" />
	</a>
	<c:if test="${!empty carClassCompetitionList}">
		<a href="<c:url value="/competition/${competition.id}/personal" />" class="btn btn-primary">
			<spring:message code="label.personal_offset" />
		</a>
	</c:if>
	<c:if test="${!empty carClassCompetitionList}">
		<a href="<c:url value="/competition/${competition.id}/teamsRanking" />" class="btn btn-primary">
			<spring:message code="ranking.teams_ranking" />
		</a>
		</c:if>
		</div>
		<br/>
	<input type="hidden" id="getRacersCountUrl" value="<c:url value="/carclass/getRacersCountById" />">
	<c:if test="${!empty carClassCompetitionList}">
	
		<label class="text-info" style="font-size: 20px; width: 100%; text-align: center;">
			<spring:message code="label.car_classes" />
		</label>		
		<table class="table table-hover text-center" style="cursor: pointer;">  	
		  	<thead>
		    	<tr class="warning">
		      		<th class="text-center">№</th>
		      		<th class="text-center"><spring:message code="label.car_class" /></th>
		      		<th class="text-center"><spring:message code="label.competition.first_race_time" /></th>
		      		<th class="text-center"><spring:message code="label.competition.second_race_time" /></th>
		      		<th class="text-center"><spring:message code="label.competition.lap_count" /></th>
		      		<th class="text-center"><spring:message code="label.competition.percentage_offset" /></th>
		      		<th class="text-center"><spring:message code="label.competition.racers_count" /></th>
		      		<c:if test="${authority.equals('ROLE_ADMIN')}">
		      			<th class="text-center" style="width: 190px;"></th>
		      		</c:if>
		    	</tr>
		  	</thead>
		  	<tbody>		    	    				      		
				<c:forEach items="${carClassCompetitionList}" var="carClassCompetition" varStatus="number">
					<tr data-href='<c:url value="/carclass/${carClassCompetition.id} " />'>
						<td>${number.count }</td>
						<td id="name${carClassCompetition.id}">
							<a href="<c:url value="/carclass/${carClassCompetition.id}" />">${carClassCompetition.carClass.name}</a>
					
						<td id="firstRaceTime${carClassCompetition.id}">
							<fmt:formatDate value="${carClassCompetition.firstRaceTime}" pattern="HH:mm" />
						</td>
						<td id="secondRaceTime${carClassCompetition.id}">
							<fmt:formatDate value="${carClassCompetition.secondRaceTime}" pattern="HH:mm" />
						</td>
						<td id="circleCount${carClassCompetition.id}">
							${carClassCompetition.circleCount}
						</td>
						<td id="percentageOffset${carClassCompetition.id}">
							${carClassCompetition.percentageOffset}%
						</td>
						<td id="count${carClassCompetition.id}" class="racersCount"></td>
						<c:if test="${authority.equals('ROLE_ADMIN')}">
							<td>
								<div class="btn-group btn-group-xs">
									<a href='#' class="btn btn-info edit_carclass_btn" id="edit${carClassCompetition.id}">
										<spring:message code="label.edit" />
									</a>
									<a href="#" class="btn btn-danger delete_carclass_btn" id="delete${carClassCompetition.id}">
										<spring:message code="label.delete" />
									</a>
								</div>
							</td>
						</c:if>
					</tr>
				</c:forEach>					
		 	</tbody>
		</table>
	</c:if>
	<c:if test="${authority.equals('ROLE_ADMIN')}">
		<br><input type="button" class="btn btn-primary" value="<spring:message code="label.add_car_class" />" id="add_carclass_competition_btn">
	</c:if>
	
</div>	

<!-- Delete competition modal -->	
<div class="modal fade" id="delete_competition_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.competition.delete" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message code="label.competition.delete_confirm_text" />?&nbsp;</label>
				<input type="hidden" id="competition_delete_url" value="<c:url value="/competition/delete" />">
				<input type="hidden" id="competition_delete_redirect_url" value="<c:url value="/index" />">
				<input type="hidden" id="competition_delete_id" value="${competition.id}">
				<br><br>
				<div class="alert alert-danger" id="delete_competition_error"
					style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
					<spring:message code="label.competition.delete_error" />.
				</div>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete">	
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-danger" type="button" id="delete_competition">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Add car class modal -->
<div class="modal fade" id="add_carclass_competition_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 5%;">
		<div class="modal-content">
			<form action="<c:url value="/competition/${competition.id}/addCarClass" />"
				  data-toggle="validator" role="form" name="add_car_class_form" id="add_car_class_form">
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title"><spring:message code="label.add_car_class" /></h4>
				</div>
				<div class="modal-body">		
					<label class="text-info"><spring:message code="label.car_class" />:&nbsp;</label>
					<select class="form-control span6" id="car_class">
						<c:if test="${!empty carClassList}">
							<c:forEach items="${carClassList}" var="carClass">
								<option value="${carClass.id}">${carClass.name}</option>
							</c:forEach>
						</c:if>
					</select><br>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.first_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.time_format" />" id="first_race_time"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="<spring:message code="dataerror.invalid_time" />" />
						<div class="help-block with-errors"></div>
					</div>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.second_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.time_format" />" id="second_race_time"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="<spring:message code="dataerror.invalid_time" />" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.lap_count" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_lap_count" />" id="lap_count"
							   required pattern="[1-9]{1}[0-9]{0,1}"
							   data-error="<spring:message code="dataerror.lap_count_invalid" />" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.percentage_offset" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_percentage" />" id="percentage_offset"
							   value="75" required pattern="([1-9]{1}[0-9]{0,1})|100"
							   data-error="<spring:message code="dataerror.percentage_offset_invalid" />" />
						<div class="help-block with-errors"></div>
					</div>	
									
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_add_carclass">	
				</div>
				<div class="modal-footer">					       		
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button class="btn btn-success" type="submit">
						<spring:message code="label.add" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Edit car class modal -->
<div class="modal fade" id="edit_carclass_competition_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 5%;">
		<div class="modal-content">
			<form action="<c:url value="/carclass/editAction" />"
				  data-toggle="validator" role="form" name="car_class_form_edit" id="car_class_form_edit">
				<input type=hidden id="carclass_id_edit" value="">
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title"><spring:message code="label.edit_car_class" /></h4>
				</div>
				<div class="modal-body">		
					<label class="text-info" style="font-size: 16px; width: 100%; text-align: center;">
						<spring:message code="label.car_class" />&nbsp;<span id="carclass_name_edit"></span>
					</label>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.first_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="label.competition.first_race_time" />" id="first_race_time_edit"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="<spring:message code="dataerror.invalid_time" />" />
						<div class="help-block with-errors"></div>
					</div>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.second_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="label.competition.first_race_time" />" id="second_race_time_edit"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="<spring:message code="dataerror.invalid_time" />" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.lap_count" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_lap_count" />" id="lap_count_edit"
							   required pattern="[1-9]{1}[0-9]{0,1}"
							   data-error="<spring:message code="dataerror.lap_count_invalid" />" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.percentage_offset" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_percentage" />" id="percentage_offset_edit"
							   required pattern="([1-9]{1}[0-9]{0,1})|100"
							   data-error="<spring:message code="dataerror.percentage_offset_invalid" />" />
						<div class="help-block with-errors"></div>
					</div>	
									
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_edit_carclass">	
				</div>
				<div class="modal-footer">					       		
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button class="btn btn-success" type="submit">
						<spring:message code="label.accept" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Delete car class modal -->
<div class="modal fade" id="delete_carclass_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.delete_car_class" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info">
					<spring:message code="label.competition.delete_car_class_confirm_text1" />&nbsp;
					<span id="carclass_delete_name"></span>&nbsp;
					<spring:message code="label.competition.delete_car_class_confirm_text2" />
					(<u><spring:message code="label.competition.delete_car_class_confirm_text3" /></u>)&nbsp;
					<spring:message code="label.competition.delete_car_class_confirm_text4" />?
				</label>
				<input type="hidden" id="carclass_delete_url" value="<c:url value="/carclass/delete" />">
				<input type="hidden" id="carclass_delete_id" value="" />
				<br><br>
				<div class="alert alert-danger" id="delete_carclass_error"
					style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
					<spring:message code="label.competition.delete_car_class_error" />.
				</div>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete_carclass">	
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-danger" type="button" id="delete_carclass">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="changePointsUrl" value="<c:url value="/competition/${competition.id}/changePointsByPlaces" />">

<!-- Edit points modal -->	
<div class="modal fade" id="edit_points_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.competition.change_points" /></h4>
			</div>
			<div class="modal-body">
				<form data-toggle="validator" role="form">
					<div class="text-center" style="width: 100%;">
						<table id="points_table" class="table table-hover text-center" 
					   			style="cursor: pointer; width: 50%; margin: 0 auto 10px;">
							<tr class="warning" style="font-weight: bolder;">
								<td><spring:message code="label.place" /></td>
								<td><spring:message code="label.points" /></td>
							</tr>	
							<c:forEach items="${pointsByPlacesList }" var="pointsByPlace" varStatus="count">
								<tr>
									<td>${count.count }</td>
									<td><input type="text" class="points" style="width: 100px;" 
											value="${pointsByPlace}" 
											required pattern="^[0-9]+$" required
											data-bv-notempty="true"
						       				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
										/>
					   				</td>
								</tr>
							</c:forEach>			
						</table>
						<input type="hidden" id="admin_url" value="<c:url value="/admin" />">
						<button type="button" class="btn btn-primary" id="add_place">
							<spring:message code="label.add" />
						</button>
						<button type="button" class="btn btn-danger" id="delete_place">
							<spring:message code="label.delete_last" />
						</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-success" type="button" id="edit_points" data-dismiss="modal">
					<spring:message code="label.save_changes" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Add place modal -->
<div class="modal fade" id="add_place_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 15%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.admin_add_place" /></h4>
			</div>
			<div class="modal-body">		
				<label class="text-info">
					<spring:message code="label.points_count" />:&nbsp;
				</label>
				<input type="text" class="form-control" 
					   placeholder="<spring:message code="placeholder.points_count" />" id="points_count" />							
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />	
				</button>
				<button class="btn btn-success" type="button" id="add_place_btn" data-dismiss="modal" disabled>
					<spring:message code="label.add" />
				</button>
			</div>
		</div>
	</div>
</div>

<br>
<c:if test="${authority.equals('ROLE_ADMIN')}">
	<c:choose>
			<c:when test="${!empty racersBirthday}">
<label class="text-info" style="font-size: 20px; width: 100%; text-align: center;">
			<spring:message code="label.birthdays" />
		</label>
<table class="table table-hover table-bordered"
					style="text-align: center;">
					<tr class="well">
						<td><spring:message code="label.racer" /></td>
						<td><spring:message code="label.enable" /></td>
						<td><spring:message code="label.car_classes" /></td>
						<td><spring:message code="label.date_of_birth" /></td>
						<td><spring:message code="label.age" /></td>
					</tr>
					<c:forEach items="${racersBirthday}" var="racer">
					<fmt:formatDate value="${racer.birthday}" var="dateString" pattern="dd/MM/yyyy" />
						<tr>
							<td style="text-align: left;"><a
								href='<c:url value="/racer/${racer.id}"/>'>
									${racer.firstName} ${racer.lastName} </a></td>
							<td style="width: 10%;">
								<c:choose>
								<c:when test="${racer.enabled == true}"><span class="glyphicon glyphicon-ok" style="color: green;"></span></c:when>
								<c:otherwise><span class="glyphicon glyphicon-remove" style="color: red;"></span></c:otherwise>
								</c:choose>
								<c:if test="${(authority != 'ROLE_TEAM_LEADER') || (needTeam.id != team.id)}"></c:if>
							</td>
							<td><c:forEach items="${racer.carClassNumbers}"
									var="carClassNumber">
									<b>${carClassNumber.carClass.name}</b>(№${carClassNumber.number})
								</c:forEach></td>
							<td>${dateString}</td>
							<td>${racer.getAge()}</td>
						</tr>
						</c:forEach>
				</table>
			</c:when>
		</c:choose>
</c:if>

<div id="exc">
</div>
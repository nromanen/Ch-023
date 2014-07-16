<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="<c:url value="/resources/style/bootstrap/css/bootstrap-switch.min.css" />" rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/style/bootstrap/js/bootstrap-switch.min.js" />'></script>
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
						<a href='<c:url value="/competition/edit/${competition.id}" />' class="btn btn-info">
							<spring:message code="label.edit" />
						</a>
						<a href="#" class="btn btn-danger" id="delete_competition_btn">
							<spring:message code="label.delete" />
						</a>
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
			</td>
		    <td style="width: 40%; padding: 0px 10px 0px 20px; vertical-align: top; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">
				<div id="competition_calendar" class="single" style="float: right;"></div>
				<input type="hidden" id="competition_calendar_url" value="<c:url value="/competition/${competition.id}/calendar" />">
			</td>
		</tr>
	</table>	
		
	<br>
	<a href="<c:url value="/competition/${competition.id}/mandat" />" class="btn btn-primary">
		<spring:message code="label.competition.mandat_statement" />
	</a>
	<br>
	
	<input type="hidden" id="getRacersCountUrl" value="<c:url value="/carclass/getRacersCountById" />">
	<c:if test="${!empty carClassCompetitionList}">
		<br>
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
				<% int number = 1; %>
				<c:forEach items="${carClassCompetitionList}" var="carClassCompetition">
					<tr data-href='<c:url value="/carclass/${carClassCompetition.id} " />'>
						<td><%= number %></td>
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
					<% number++; %>
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
						<input type="text" class="form-control" placeholder="Enter time in format hh:mm" id="first_race_time"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="This field is required. Time format hh:mm. For example 12:30" />
						<div class="help-block with-errors"></div>
					</div>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.second_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter time in format hh:mm" id="second_race_time"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="This field is required. Time format hh:mm. For example 15:30" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.lap_count" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter lap count" id="lap_count"
							   required pattern="[1-9]{1}[0-9]{0,1}"
							   data-error="This field is required. Number must be less equal 99." />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.percentage_offset" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter percentage offset" id="percentage_offset"
							   value="75" required pattern="([1-9]{1}[0-9]{0,1})|100"
							   data-error="This field is required. Number must be less equal 100." />
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
						<input type="text" class="form-control" placeholder="Enter time in format hh:mm" id="first_race_time_edit"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="This field is required. Time format hh:mm. For example 12:30" />
						<div class="help-block with-errors"></div>
					</div>
						
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.second_race_time" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter time in format hh:mm" id="second_race_time_edit"
							   required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]"
							   data-error="This field is required. Time format hh:mm. For example 15:30" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.lap_count" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter lap count" id="lap_count_edit"
							   required pattern="[1-9]{1}[0-9]{0,1}"
							   data-error="This field is required. Number must be less equal 99." />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.competition.percentage_offset" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="Enter percentage offset" id="percentage_offset_edit"
							   required pattern="([1-9]{1}[0-9]{0,1})|100"
							   data-error="This field is required. Number must be less equal 100." />
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

<div id="exc">
</div>
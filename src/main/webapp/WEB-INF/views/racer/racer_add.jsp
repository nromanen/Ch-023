<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />' charset="UTF-8"></script>
<script type='text/javascript' src='<c:url value="/resources/js/racer.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>

<h2 class="user-info-name"><spring:message code="label.new_racer" /></h2>
<form class="well" action="<c:url value="/racer/addRacer" />"
	data-toggle="validator" role="form" name="new_racer" id="new_racer">

<!-- 	<div class="label label-danger" style="font-size: 12px;">
		All fields are required
	</div> -->
	<p style="margin-top: 15px;">
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.firstname" /><span class="text-danger">*</span>:&nbsp;</label> <input type="text"
			class="form-control" placeholder="<spring:message code="placeholder.firstname" />" id="first_name"
			required pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code="dataerror.firstname" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.lastname" /><span class="text-danger">*</span>:&nbsp;</label> <input type="text"
			class="form-control" placeholder="<spring:message code="placeholder.lastname" />" id="last_name"
			required pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code="dataerror.lastname" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>
		<input type="hidden" value="${team.id}" id="team_id">
		<input type="text" class="form-control" value="${team.name}" disabled>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;</label> <input
			type="text" class="form-control datepicker"
			placeholder="<spring:message
				code="placeholder.date_of_birth" />" id="birthday" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.identification" /><span class="text-danger">*</span>:&nbsp;</label> <input type="text"
			class="form-control" placeholder="<spring:message
				code="placeholder.identification" />" id="document"
			required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span class="text-danger">*</span>:&nbsp;</label> <input type="text"
			class="form-control" placeholder="<spring:message code="placeholder.address" />" id="address"
			required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="sportcategory.sport_category" /><span class="text-danger">*</span>:&nbsp;</label> <select
			class="form-control span6" id="sport_category">
			<option value="0"><spring:message code="sportcategory.without" /></option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4"><spring:message code="sportcategory.candidate_master_of_sports" /></option>
			<option value="5"><spring:message code="sportcategory.master_of_sports" /></option>
		</select>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.car_class" /><span class="text-danger">*</span>:&nbsp;</label> <input type="text"
			class="form-control" id="car_classes" required
			data-error="<spring:message code="dataerror.field_required" />" disabled />
		<div class="help-block with-errors"></div>
	</div>
	<input type="hidden" id="car_classes_id">
	<input type="hidden" id="car_classes_numbers">
	<input type="button" class="btn btn-primary" value="<spring:message code="label.add_car_class" />" id="add_class_modal">
	<input type="button" class="btn btn-danger" value="<spring:message code="label.delete_car_class" />" id="delete_classes">
	<br><br>


	<div class="modal fade" id="basicModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" style="margin-top: 10%;">
				<div class="modal-content">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal">x</button>
						<h4 class="modal-title"><spring:message code="label.add_car_class" /></h4>
					</div>
					<div class="modal-body">							
						<input type="hidden" id="get_occupied_numbers_url" 
								value="<c:url value="/racer/getOccupiedDefaultNumbersForCarClass" />">
						<div class="form-group">
							<label class="text-info"><spring:message code="label.car_class" />:&nbsp;</label>
							<select class="form-control span6" id="car_class">
								<option value=""><spring:message code="label.choose_car_class" /></option>
								<c:if test="${!empty carClassList}">
									<c:forEach items="${carClassList}" var="carClass">
										<option value="${carClass.id}">${carClass.name} (${carClass.lowerYearsLimit}-${carClass.upperYearsLimit})</option>
									</c:forEach>
								</c:if>
							</select>
						</div>						
						<div class="form-group">
							<label class="text-info"><spring:message code="label.car_number" />:&nbsp;</label>
							<select class="form-control span6" id="car_number">
								<option value=""><spring:message code="label.choose_number" /></option>
								<c:forEach var="number" begin="1" end="99">
									<option value="${number}">${number}</option>
								</c:forEach>
							</select>
						</div>
						<br>
						<img src='<c:url value="/resources/img/ajax-loader.gif" />'
							style="display: none; float: right;" id="ajax_loader_add_carclass">
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
						<button class="btn btn-success" type="button" id="add_class"><spring:message code="label.add_car_class" /></button>
					</div>
				</div>
		</div>
	</div>
    <div class="dropdown" id="addDocs">
        <select id="dropdownMenu1" class="fl-left" onchange="" style="width: 200px; margin-right: 5px;">
    <option>Add document</option>
    <option role="presentation" id="lic"><a role="menuitem" tabindex="-1" href="#">License</a></option>
    <option role="presentation" id="ins"><a role="menuitem" tabindex="-1" href="#">Insurance</a></option>
    <option role="presentation" id="med"><a role="menuitem" tabindex="-1" href="#">Medical certificate</a></option>
    <option role="presentation" id="par"><a role="menuitem" tabindex="-1" href="#">Parental permision</a></option>
    </select>
    <div id="addForm" class="well" style="display: none">
    <br>
    <label id="docNum" style="display: none" class="text-info"><spring:message code="label.document_number" /><span class="text-danger">*</span>:&nbsp;</label>
    <input id="docNumInp" style="display: none" type="text" class="form-control" placeholder="<spring:message code="placeholder.document_number" />"
        id="number" name="number" maxlength="100" 
        data-bv-notempty="true"
        data-bv-notempty-message="<spring:message code="dataerror.field_required" /> <spring:message code="dataerror.enter_document_namber" />" />
    <div class="help-block with-errors"></div>
    </div>
</div>
	<br><br>
	<input type="submit" class="btn btn-success" value="<spring:message code="label.accept" />"
		id="add_racer"> <img
		src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br>
	<br>
	<div class="alert alert-danger" id="racer_exists"
		style="display: none; padding: 0px 0px 0px 20px; height: 25px;"><spring:message code="message.racer_exists" /></div>
</form>
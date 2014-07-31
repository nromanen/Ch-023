<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href='<c:url value="/resources/style/datepicker.css" />'
	rel="stylesheet">
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />'
	charset="UTF-8"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />'
	charset="UTF-8"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/racer.js" />'></script>


<h2 class="user-info-name">${racer.firstName}&nbsp;${racer.lastName}</h2>
<form class="well" action="/Carting/racer/confirmEdit" role="form"
	name="edit_racer" id="edit_racer" data-toggle="validator">

	<input type="hidden" id="id" value="${racer.id}"> <input
		type="hidden" id="registration_date" value="${racer.registrationDate}">
	<p style="margin-top: 15px;">
	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.firstname" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.firstname" />"
			value="${racer.firstName}" id="first_name" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code="dataerror.firstname" />" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.lastname" /><span
			class="text-danger">*</span>:&nbsp; </label> <input type="text"
			class="form-control"
			placeholder="<spring:message code="placeholder.lastname" />"
			value="${racer.lastName}" id="last_name" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code="dataerror.lastname" />" />
		<div class="help-block with-errors"></div>
	</div>
	<div class="form-group">
		<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>
		<input type="hidden" value="${team.id}" id="team_id"> <input
			type="text" class="form-control" value="${team.name}" disabled>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message
				code="placeholder.date_of_birth" />"
			value="${dateOfBirth}" id="birthday" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.identification" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message
				code="placeholder.identification" />"
			value=${racer.document } id="document" required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span
			class="text-danger">*</span>:&nbsp; </label> <input type="text"
			class="form-control"
			placeholder="<spring:message code="placeholder.address"  />"
			value="${racer.address}" id="address" required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>
	<div class="form-group">
		<label class="text-info"><spring:message
				code="sportcategory.sport_category" /><span class="text-danger">*</span>:&nbsp;
		</label> <select class="form-control span6" id="sport_category">
			<c:choose>
				<c:when test="${racer.sportsCategory eq '0'}">
					<option selected value="0"><spring:message
							code="sportcategory.without" /></option>
				</c:when>
				<c:otherwise>
					<option value="0"><spring:message
							code="sportcategory.without" /></option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${racer.sportsCategory eq '1'}">
					<option selected value="1">1</option>
				</c:when>
				<c:otherwise>
					<option value="1">1</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${racer.sportsCategory eq '2'}">
					<option selected value="2">2</option>
				</c:when>
				<c:otherwise>
					<option value="2">2</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${racer.sportsCategory eq '3'}">
					<option selected value="3">3</option>
				</c:when>
				<c:otherwise>
					<option value="3">3</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${racer.sportsCategory eq '4'}">
					<option selected value="4"><spring:message
							code="sportcategory.candidate_master_of_sports" /></option>
				</c:when>
				<c:otherwise>
					<option value="4"><spring:message
							code="sportcategory.candidate_master_of_sports" /></option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${racer.sportsCategory eq '5'}">
					<option selected value="5"><spring:message
							code="sportcategory.master_of_sports" /></option>
				</c:when>
				<c:otherwise>
					<option value="5"><spring:message
							code="sportcategory.master_of_sports" /></option>
				</c:otherwise>
			</c:choose>
		</select>
	</div>

	<br> <a href="/Carting/racer/${racer.id}"> <input
		type="button" class="btn btn-primary"
		value="<spring:message code="label.cancel" />" />
	</a> <input type="submit" class="btn btn-success"
		value="<spring:message code="label.accept" />" id="edit_racer">
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader">
</form>

<div class="well">
	<label class="text-info"><spring:message
			code="label.car_classes" />:&nbsp;</label> <input type="text"
		class="form-control" value="${carClassView}" disabled id="car_classes" />
	<input type="hidden" id="car_classes_id_old" value="${carClassIds}">
	<input type="hidden" id="car_classes_numbers_old"
		value="${carClassNames}"> <input type="hidden"
		id="car_classes_id" value="${carClassIds}"> <input
		type="hidden" id="car_classes_numbers" value="${carClassNames}">

	<br> <input type="button" class="btn btn-primary"
		value="<spring:message code="label.edit_numbers" />"
		id="edit_numbers_modal"> <input type="button"
		class="btn btn-primary"
		value="<spring:message code="label.add_car_class" />"
		id="add_class_ER_modal"> <input type="button"
		class="btn btn-danger"
		value="<spring:message code="label.delete_all_car_classes" />"
		id="delete_classes_ER_modal"> <br> <br>
</div>

<!--Dialog about deleting all classes-->
<div class="modal fade" id="deleteClassesERModal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<form data-toggle="validator">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title">
						<spring:message code="message.question_delete_all_car_classes" />
					</h4>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button class="btn btn-danger" type="button" id="delete_classes_ER">
						<spring:message code="label.delete" />
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!--/Dialog about deleting all classes-->


<!-- Edit Numbers Modal -->
<div class="modal fade" id="editNumbersModal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog">
		<form data-toggle="validator">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<spring:message code="label.editing_numbers_in_classes" />
					</h4>
				</div>
				<div class="modal-body">
					<c:if test="${!empty racer.carClassNumbers}">
						<c:forEach items="${racer.carClassNumbers}"
							var="racerCarClassNumber">
							<div class="form-group form-inline text-center">
								<input type="text" class="form-control text-center"
									value="${ racerCarClassNumber.carClass.name}"
									id="car_class_name${racerCarClassNumber.id},${racerCarClassNumber.carClass.id}"
									disabled />
								<select class="form-control text-center car_class_number" 
										id="${racerCarClassNumber.id},${racerCarClassNumber.carClass.id}">
									<c:forEach var="number" begin="1" end="99">
										<option value="${number}"
										<c:if test="${racerCarClassNumber.number == number}">
											selected
										</c:if>
										>${number}</option>
									</c:forEach>
								</select>
								
								<input type="checkbox" class="check_to_delete"
									id=${ racerCarClassNumber.id}
									name="${racerCarClassNumber.id},${racerCarClassNumber.carClass.id}">
								<div class="help-block with-errors"></div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="modal-footer">
					<img src='<c:url value="/resources/img/ajax-loader.gif" />'
						style="display: none;" id="edit_numbers_loader">
					<button type="button" class="btn btn-primary" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button type="button" class="btn btn-danger"
						id="delete_chosen_classes_ER_modal">
						<spring:message code="label.delete_chosen_car_classes" />
					</button>
					<button type="submit" class="btn btn-success" id="edit_numbers_ER">
						<spring:message code="label.accept" />
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- / Edit Numbers Modal -->
<!--Add racerCarClassNumber  -->
<div class="modal fade" id="addClassERModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<form data-toggle="validator">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title" id="myModalLabel">
						<spring:message code="label.add_car_class" />
					</h4>
				</div>
				<div class="modal-body">
					<label class="text-info"><spring:message
							code="label.car_class" />:&nbsp;</label> <select
						class="form-control span6" id="car_class">
						<c:if test="${!empty carClassList}">
							<c:forEach items="${carClassList}" var="carClass">
								<option value="${carClass.id}">${carClass.name} (${carClass.lowerYearsLimit} - ${carClass.upperYearsLimit})</option>
							</c:forEach>
						</c:if>

					</select> <input type="hidden" id="get_occupied_numbers_url"
						value="<c:url value="/racer/getOccupiedDefaultNumbersForCarClass" />">
					<div class="form-group">
						<label class="text-info"><spring:message
								code="label.car_number" />:&nbsp;</label> <select
							class="form-control span6" id="car_number">
							<option value=""><spring:message
									code="label.choose_number" /></option>
							<c:forEach var="number" begin="1" end="99">
								<option value="${number}">${number}</option>
							</c:forEach>
						</select>
					</div>
					<br>
					<!--Alerts if Car number for this class already exists! -->
					<div class="alert alert-danger" id="car_number_for_class_exists"
						style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
						<spring:message code="message.car_namber_exist" />
					</div>
					<!--Alerts if number of the car for this class already exists! -->
					<div class="alert alert-danger" id="car_class_exists"
						style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
						<spring:message code="message.racer_car_class_exist" />
					</div>
					<!--Reports that number of the car for class was added successfully-->
					<div class="alert alert-success" id="added_successfully"
						style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
						<spring:message code="message.car_class_number_add_successfully" />
					</div>
					<!--Indicates that the process-->
					<img src='<c:url value="/resources/img/ajax-loader.gif" />'
						style="display: none; float: right;" id="ajax_loader-modal">
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button class="btn btn-success" type="button" id="add_class_ER">
						<spring:message code="label.accept" />
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- /Add racerCarClassNumber  -->
<!--Dialog about deleting chosen classes-->
<div class="modal fade" id="deleteChosenClassesERModal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title">
					<spring:message code="label.delete_chosen_car_classes" />
				</h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message
						code="message.question_delete_chosen_car_classes" />&nbsp;</label> <br>
				<br> <img
					src='<c:url value="/resources/img/ajax-loader.gif" />'
					style="display: none;" id="ajax_loader_delete">
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-primary" type="button"
					id="delete_chosen_classes_ER">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>
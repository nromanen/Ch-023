<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />' charset="UTF-8"></script>
<script type='text/javascript' src='<c:url value="/resources/js/file-validation.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/racer.js" />'></script>

<h2 class="user-info-name"><spring:message code="label.new_racer" /></h2>
<form class="well" action="<c:url value="/racer/addRacer" />"
	data-toggle="validator" role="form" name="new_racer" id="new_racer">

<!-- 	<div class="label label-danger" style="font-size: 12px;">
		All fields are required
	</div> -->
	<p style="margin-top: 15px;">
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.firstname" /><span class="text-danger">*</span>:&nbsp;</label> 
		<input type="text" autofocus="autofocus"
			class="form-control" placeholder="<spring:message code='placeholder.firstname' />" id="first_name"
			required pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="<spring:message code='dataerror.firstname'/>" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.lastname" /><span class="text-danger">*</span>:&nbsp;</label> 
		<input type="text"
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
			code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;</label> 
			<input type="text" class="form-control datepicker" id="birthday" required
			placeholder="<spring:message code="placeholder.date_of_birth" />" 
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />">
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message
				code="label.identification" /><span class="text-danger">*</span>:&nbsp;</label> 
				<input type="text"
			class="form-control" placeholder="<spring:message
				code="placeholder.identification" />" id="document"
			required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="label.address" /><span class="text-danger">*</span>:&nbsp;</label> 
		<input type="text"
			class="form-control" placeholder="<spring:message code="placeholder.address" />" id="address"
			required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info"><spring:message code="sportcategory.sport_category" /><span class="text-danger">*</span>:&nbsp;</label> 
		<select
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
	<input type="submit" class="btn btn-success" value="<spring:message code="label.accept" />"
		id="add_racer"> <img
		src='<c:url value="/resources/img/ajax-loader.gif" />'
		style="display: none;" id="ajax_loader"> <br>
	<br>
	<div class="alert alert-danger" id="racer_exists"
		style="display: none; padding: 0px 0px 0px 20px; height: 25px;"><spring:message code="message.racer_exists" /></div>
</form>

<br>
<div style="display:none" id="label_add_doc" >
    <h2 class="user-info-name"><spring:message code="label.adding_racer_documents"/></h2>
</div>
<form id="addDocumentsForm" style="display: none"class = "well" style="display: block" action="#"
    data-toggle="validator" role="form" name="new_doc_form">
<!-- Adding documents form -->
	<input type="hidden" id="racerId">
<!-- Navigation tabs -->
	
	<ul class="nav nav-tabs" role="tablist" id="myTab">
	  <li id="tab1" class="active"><a id="a1" href="#licenseInfo" role="tab" data-toggle="tab"><spring:message code="label.document_racer_license"/></a></li>
	  <li id="tab2" ><a id="a2" href="#insuranceInfo" role="tab" data-toggle="tab" ><spring:message code="label.document_racer_insurance"/></a></li>
	  <li id="tab3"><a id="a3" href="#medicalInfo" role="tab" data-toggle="tab"><spring:message code="label.document_racer_medical_cerificate"/></a></li>
	  <li id="tab4"><a id="a4" href="#permissionInfo" role="tab" data-toggle="tab"><spring:message code="label.document_racer_parental_permission"/></a></li>
	</ul>
	
<!-- Tabs content -->
<!-- Racer's license form -->
<br>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="licenseInfo">
			<%-- <form action="<c:url value="/racer/addDocs" />"  method="post" enctype="multipart/form-data" data-toggle="validator" role="form" name="add_lic" id="add_lic"> --%> 
				<div class="form-group">
					<label id="docNum1label"  class="text-info"><spring:message code="label.document_number" /><span class="text-danger">*</span>:&nbsp;</label>
					<input id="docNum1" type="text" class="form-control docInput1" placeholder="<spring:message code="placeholder.document_number" />"
						id="number" name="number" onchange='test()' 
                        data-bv-notempty="true"
                        data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
						pattern="^[\w\.-]+$" 
                        data-bv-regexp-message="<spring:message code='dataerror.carclass_name_exception' />"/>
				</div>
				<label for="filePicker" class="text-info"><spring:message code="label.choose_file" />:</label>
				<table id="fileTable1">
					<tr>
						<td>
							<div class="form-group">
								<input id="file1" type="file" name="file" class="form-control file1"  onchange="return ValidateFileUpload(this)" data-doc="1"/>
							</div>
						</td>
					</tr>
				</table>
			
				<div class="form-group">
					<input id="addFile1" type="button" class="btn btn-primary btn-sm addFile" typeDocument="1" value="<spring:message code="label.another_file" />" />
					<div class="alert alert-danger" id="max_count_achieved1" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
						<spring:message code="dataerror.max_count_achieved" />
					</div>
					<input id="add1" type="button" disabled class="btn btn-success btn-sm adding" doc_type="1" value="<spring:message code='label.add_document'/>" />
				</div>
				
			<%-- </form> --%>
		</div>
		
<!-- Racer's insurance form -->
	
	  <div class="tab-pane fade" id="insuranceInfo">
		<div class="form-group">
				<label class="text-info"><spring:message code="label.document_valid_until" /><span class="text-danger">*</span>:&nbsp;
				</label> 
				<input type="text" class="form-control datepicker docInput2" name="finish_date" onchange='test()'
					placeholder="<spring:message code="placeholder.date" />" value=""
					id="doc_date_picker2"
					data-bv-notempty="true"
					data-bv-notempty-message="<spring:message code="dataerror.field_required" />"			
					data-bv-date-format = "^YYYY-MM-DD$"
					data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
				<label class="text-info"><spring:message code="label.document_number" /><span class="text-danger">*</span>:&nbsp;</label>
				<input type="text" class="form-control docInput2" onchange='test()'
					placeholder="<spring:message code="placeholder.document_number" />"
					id="docNum2" name="number" maxlength="100" 
					data-bv-notempty="true"
                        data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                        pattern="^[\w\.-]+$" 
                        data-bv-regexp-message="<spring:message code='dataerror.carclass_name_exception' />" <spring:message code="dataerror.enter_document_namber" />"	/>
			</div>
			<label for="filePicker" class="text-info"><spring:message code="label.choose_file" />:</label>
			<table id="fileTable2">
				<tr>
					<td>
						<div class="form-group">
							<input type="file" name="file" class="form-control file2" id="file2" onchange="return ValidateFileUpload(this)" 
								data-bv-notempty="true"
								data-bv-notempty-message="<spring:message code="dataerror.field_required" />"/>
						</div>
					</td>
				</tr>
			</table>
		
			<div class="form-group">
				<input id="addFile2" type="button" class="btn btn-primary btn-sm addFile" typeDocument="2" value="<spring:message code="label.another_file" />" />
				<div class="alert alert-danger" id="max_count_achieved2" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
					<spring:message code="dataerror.max_count_achieved" />
				</div>
				<input type="hidden" value = "2">
				<input id="add2" type="button" disabled class="btn btn-success btn-sm adding" doc_type="2" value="<spring:message code='label.add_document'/>" />
			</div>
		</div>
<!-- Racer's medical certificate form -->	
	  <div class="tab-pane fade" id="medicalInfo">
	  <div class="form-group">
				<label class="text-info"><spring:message code="label.document_valid_until" /><span class="text-danger">*</span>:&nbsp;</label> 
				<input type="text" class="form-control datepicker docInput3" name="finish_date" onchange='test()'
					placeholder="<spring:message code="placeholder.date" />"
					id="doc_date_picker3"
					data-bv-notempty="true"
					data-bv-notempty-message="<spring:message code="dataerror.field_required" />"			
					data-bv-date-format = "YYYY-MM-DD"
					data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
					
			</div>
			<label for="filePicker" class="text-info"><spring:message code="label.choose_file" />:</label>
			<table id="fileTable3">
				<tr>
					<td>
						<div class="form-group">
							<input type="file" name="file" class="form-control file3" id="file3" onchange="return ValidateFileUpload(this)"
								data-bv-notempty="true"
								data-bv-notempty-message="<spring:message code="dataerror.field_required" />"/>
						</div>
					</td>
				</tr>
			</table>
		
			<div class="form-group">
				<input id="addFile3" type="button" class="btn btn-primary btn-sm addFile" typeDocument="3" value="<spring:message code="label.another_file" />" />
				<div class="alert alert-danger" id="max_count_achieved3" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
					<spring:message code="dataerror.max_count_achieved" />
				</div>
				<input type="hidden" value = "3">
				<input id="add3" type="button" disabled class="btn btn-success btn-sm adding" doc_type="3" value="<spring:message code='label.add_document'/>" />
			</div>
	  
	  </div>
<!-- Racer's parental permission form -->
		  <div class="tab-pane fade"  id="permissionInfo">
			<div class="form-group">
				<label class="text-info"><spring:message
						code="label.document_date_start" /><span class="text-danger">*</span>:&nbsp;
				</label> 
				<input type="text" class="form-control datepicker docInput4" name="start_date" onchange='test()'
					placeholder="<spring:message code="placeholder.date" />"
					id="doc_date_picker4"
					data-bv-notempty="true"
					data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
					data-bv-date-format = "YYYY-MM-DD"
					data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			</div>
			<label for="filePicker" class="text-info"><spring:message code="label.choose_file" />:</label>
			<table id="fileTable4">
				<tr>
					<td>
						<div class="form-group">
							<input type="file" name="file" class="form-control file4" id="file4" onchange="return ValidateFileUpload(this)" 
								data-bv-notempty="true"
								data-bv-notempty-message="<spring:message code="dataerror.field_required" />"/>
						</div>
					</td>
				</tr>
			</table>
			<div class="form-group">
				<input id="addFile4" type="button" class="btn btn-primary btn-sm addFile" typeDocument="4" value="<spring:message code='label.another_file' />" />
				<div class="alert alert-danger" id="max_count_achieved4" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
					<spring:message code="dataerror.max_count_achieved" />
				</div>
				<input id="add4" type="button" disabled class="btn btn-success btn-sm adding" doc_type="4" value="<spring:message code='label.add_document'/>" />
			</div>
		</div>
	</div>
<!-- end of tabs -->
    <div class="alert alert-danger" id="result" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;"></div>
    <div class="alert alert-success" id="success-result" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
       <spring:message code="label.documents_added"></spring:message></div>
    <div class="alert alert-danger" id="problem-result" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
       <spring:message code="label.document_adding_problems"></spring:message></div>
	<input type="button" class="btn btn-success" value="<spring:message code='label.done'/>" id="finish"> 
	
	<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_docs"> 
	<br><br>
</form>
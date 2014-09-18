<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href="<c:url value="/resources/libs/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/libs/bootstrapValidator/css/bootstrapValidator.css" />" rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
<script src="<c:url value="/resources/js/lib/bootbox.js" />"></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrap-switch/js/bootstrap-switch.min.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/admin.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 30px 20px 40px;">
		
	<table width=100%>
		<tr>
			<td style="width: 80%;">
				<h2 class="user-info-name">
					<spring:message code="label.admin_cabinet" />
				</h2>
			</td>
			<td style="width: 20%; padding: 15px 10px 0px 20px;">
				<a href="<c:url value="/logs/today" />"
					class="btn btn-success" style="float: right;">
					<spring:message code="label.admin_log" />
				</a>
			</td>
		    <td style="width: 20%; padding: 15px 10px 0px 20px;">
				<button type="button" class="btn btn-primary" style="float: right;" id="change_pass_btn">
					<spring:message code="label.change_password" />
				</button>
			</td>
		</tr>
	</table>
	
	<br><label class="text-info" style="font-size: 20px;">
		1.&nbsp;<spring:message code="label.admin_team_leaders" />:
	</label>
	 <input type="hidden" id="enable_url" value="<c:url value="/leader/setEnabled"/>">
	<table class="table table-hover text-center" style="cursor: pointer;">
		<tr class="warning" style="font-weight: bolder;">
			<td class="text-center">№</td>
			<td class="text-center"><spring:message code="label.lastname_firstname" /></td>
			<td class="text-center"><spring:message code="label.login" /></td>
			<td class="text-center"><spring:message code="label.registration_date" /></td>
			<td class="text-center">&nbsp;</td>
			<td class="text-center">&nbsp;</td>
			<td class="text-center">&nbsp;</td>
		</tr>
		<c:forEach items="${leadersList}" var="leader" varStatus="position">
			<tr>
				<td>${position.count }</td>
				<td style="text-align: left;" id="name${leader.id}">
					<a href="<c:url value="../leader/${leader.id}" />">
						${leader.lastName} ${leader.firstName}
					</a>
				</td>
				<td>${leader.user.username}</td>
				<td><fmt:formatDate value="${leader.registrationDate}" pattern="yyyy-MM-dd HH:mm" /></td>
				<td>
					<input type="checkbox" class="enabled" id="${leader.user.username}" 
				    	<c:if test="${leader.user.enabled==true}">checked</c:if>
				    />
				</td>
				<td class="text-center">
					<a href='#' class="btn btn-xs btn-primary reset_pass_btn" id="reset${leader.id}">
						<spring:message code="label.admin_reset_password" />
					</a>
				</td>
				<td>
					<a href='#' class="btn btn-xs btn-danger delete_leader_btn" id="delete${leader.id}">
						<spring:message code="label.delete" />
					</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<br><label class="text-info" style="font-size: 20px;">
		2.&nbsp;<spring:message code="label.admin_feedback_email" />:
	</label>
	<div style="height: 50px;">
		<form action="<c:url value="/admin/changeFeedbackEmail" />"
		  data-toggle="validator" role="form" id="change_feedback_email_form">				
			<div class="form-group">
				<input type="text" class="form-control" value="${adminSettings.feedbackEmail}" 
				   style="width: 250px; float: left; margin-right: 10px;" id="feedback_email"
				   placeholder="<spring:message code="placeholder.email" />" 
				   required pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" 
				   data-error="<spring:message code="dataerror.email_not_valid" />" >				
				<button class="btn btn-primary" type="submit" id="change_feedback_email_btn">
					<spring:message code="label.accept" />
				</button>
				<div class="alert alert-success" id="change_feedback_email_success"
					 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
					<spring:message code="label.data_save_success" />!
				</div>
				<div class="alert alert-danger" id="change_feedback_email_error"
					 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
					<spring:message code="label.data_save_error" />!
				</div>	
				<div class="help-block with-errors"></div>
			</div>	
		</form>
	</div>
	
	<br><label class="text-info" style="font-size: 20px;">
		3.&nbsp;<spring:message code="label.admin_perental_permission_years_limit" />:
	</label>
	<div style="height: 50px;">
		<input type="text" class="form-control" value="${adminSettings.parentalPermissionYears}" 
			   style="width: 150px; float: left; margin-right: 10px;" id="perental_permission_years" 
			   placeholder="<spring:message code="placeholder.perental_permission_years"/>" >
		<input type="hidden" id="change_perental_permission_years_url" value="<c:url value="/admin/changePerentalPermissionYears" />">
		<button class="btn btn-primary" type="button" id="change_perental_permission_years_btn">
			<spring:message code="label.accept" />
		</button>
		<div class="alert alert-success" id="change_perental_permission_years_success"
			 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
			<spring:message code="label.data_save_success" />!
		</div>
		<div class="alert alert-danger" id="change_perental_permission_years_error"
			 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
			<spring:message code="label.data_save_error" />!
		</div>
	</div>
	
	<br><label class="text-info" style="font-size: 20px;">
		4.&nbsp;<spring:message code="label.car_classes" />:
	</label>
	<table class="table table-hover text-center" style="cursor: pointer;">
		<tr class="warning" style="font-weight: bolder;">
			<td class="text-center">№</td>
			<td class="text-center"><spring:message code="label.car_class" /></td>
			<td class="text-center"><spring:message code="label.admin_lower_years_limit" /></td>
			<td class="text-center"><spring:message code="label.admin_upper_years_limit" /></td>
			<td class="text-center">&nbsp;</td>
		</tr>
		<input type="hidden" id="carclass_delete_id" value="">
		<c:forEach items="${carClassList}" var="carClass" varStatus="number">
			<tr>
				<td>${number.count }</td>
				<td id="carClassName${carClass.id}" style="text-align: left;">${carClass.name}</td>
				<td id="lowerYearsLimit${carClass.id}">${carClass.lowerYearsLimit}</td>
				<td id="upperYearsLimit${carClass.id}">${carClass.upperYearsLimit}</td>
				<td>
					<div class="btn-group btn-group-xs">
						<a href='#' class="btn btn-info edit_carclass_btn" id="edit${carClass.id}">
							<spring:message code="label.edit" />
						</a>						
					</div>
					<div class="btn-group btn-group-xs">
						<a href='#' class="btn btn-danger delete_carclass_btn" id="delete${carClass.id}">
							<spring:message code="label.delete" />
						</a>	
					</div>					
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="text-center" style="width: 100%;">
		<button type="button" class="btn btn-primary" id="add_carclass_btn">
			<spring:message code="label.add_car_class" />
		</button>
	</div>
	<div class="alert alert-danger" id="delete_place_error"
		 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
		 <spring:message code="dataerror.carclass_delete" />
	</div>
	<br> 
	<table width="100%">
		<th>
			<div align="left">
				<label class="text-info" style="font-size: 20px;">
					5.&nbsp;<spring:message code="label.admin_points_by_places" />:
				</label>
			</div>
		</th>
		<th>
			<div align="center">
				<label class="text-info" style="font-size: 20px;">
					6.&nbsp;<spring:message code="label.maneuver" />:
				</label>
			</div>
		</th>
		<tr>
			<td>
				<div align="center">
					<form data-toggle="validator" role="form">
						<div class="text-left" style="width: 100%;">
								<table id="points_table" class="table table-hover text-center"
									   style="cursor: pointer; width: 50%;">
									<tr class="warning" style="font-weight: bolder;">
										<td><spring:message code="label.place" /></td>
										<td><spring:message code="label.points" /></td>
										<td></td>
									</tr>
									<c:forEach items="${pointsByPlacesList}" var="pointsByPlace" varStatus="count">
										<tr>
											<td>${count.count }</td>
											<td><input type="text" class="points" style="width: 100px;"
												value="${pointsByPlace}"
												required pattern="^[0-9]+$" required
												data-bv-notempty="true"
												data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
												/>
											</td>
											<td>
												<c:if test="${pointsByPlacesList.size() == count.count}">
													<button id="delete_place" class="btn btn-default btn-sm glyphicon glyphicon-remove" style="color: red; cursor: pointer; float: right;" title="<spring:message code="label.delete" />"/>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</table>
							<div align="right" class="btn-group">
								<button type="button" class="btn btn-primary btn-sm" id="add_place">
									<spring:message code="label.add" />
								</button>
								<button type="button" class="btn btn-success btn-sm" id="edit_place">
									<spring:message code="label.accept_changes" />
								</button>
							</div>
							<input type="hidden" id="admin_url" value="<c:url value="/admin" />">
							<div class="alert alert-success" id="edit_place_success"
								 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
								 <spring:message code="label.data_save_success" />!
							</div>
							<div class="alert alert-danger" id="edit_place_error"
								 style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
								 <spring:message code="label.data_save_error" />!
							</div>
						</div>
					</form>
				</div>
			</td>
			<td align="right">
				<div align="center">
					<table id="maneuver_table" class="table table-hover text-center"
						   style="cursor: pointer; width: 50%;">
						<tr class="warning" style="font-weight: bolder;">
							<td><spring:message code="label.number" /></td>
							<td><spring:message code="label.maneuver" /></td>
							<td></td>
						</tr>
						<c:forEach items="${maneuvers}" var="maneuver" varStatus="index">
							<tr>
								<td>${index.count }</td>
								<td><input maneuverId="${maneuver.id}" class="man"  type="text" style="width: 100px;"
										   value="${maneuver.name}" required
										   data-bv-notempty="true"
										   data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
										/>
								</td>
								<td>
									<button maneuver="${maneuver.id}" class="btn btn-default btn-sm glyphicon glyphicon-remove delete_maneuver" style="color: red; cursor: pointer; float: right;" title="<spring:message code="label.delete" />"/>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div align="center" class="btn-group">
						<button type="button" class="btn btn-primary btn-sm" id="add_maneuver">
							<spring:message code="label.add_maneuver" />
						</button>
						<button type="button" class="btn btn-success btn-sm" id="edit_maneuver">
							<spring:message code="label.accept_changes" />
						</button>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>




<!-- Delete car class modal -->
<div id="carclass_delete_modal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title"><spring:message code="label.delete_car_class" /></h4>
      </div>
      <div class="modal-body">
        <p><spring:message code="label.delete_car_class_сonfirm" /></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="label.cancel" /></button>
        <button type="button" class="btn btn-danger" id="carclass_delete_confirm"><spring:message code="label.accept" /></button>
      </div>
    </div>
  </div>
</div>

<!-- Add car class modal -->
<div class="modal fade" id="add_carclass_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 5%;">
		<div class="modal-content">
			<form id="add_car_class_form" action="<c:url value="/admin/addCarClass" />"
				  role="form" name="add_car_class_form" >
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><spring:message code="label.add_car_class" /></h4>
				</div>
				<div class="modal-body">	
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.name" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.car_class_name" />"
						       id="name" name="name" required 
						       pattern="^[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,50}$"
						        data-bv-regexp-message="<spring:message code="dataerror.carclass_name_exception" />&nbsp
						        <spring:message code="dataerror.carclass_example" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
						       />
					</div>
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_lower_years_limit" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.lower_years_limit" />"
						       id="lower_years_limit" name="lower_years_limit" required 
						       pattern="^[1-9]{1}[0-9]?$" 
						       data-bv-regexp-message="<spring:message code="dataerror.number_value" />&nbsp;
						       <spring:message code="dataerror.value_range" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
							   />
					</div>
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_upper_years_limit" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.upper_years_limit" />"
							   id="upper_years_limit" name="upper_years_limit" required 
							   pattern="^[1-9]{1}[0-9]?$" 
						       data-bv-regexp-message="<spring:message code="dataerror.number_value" />&nbsp;
						       <spring:message code="dataerror.value_range" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
							   />
					</div>	
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_add_carclass">	
				</div>
				<div class="modal-footer">	
					<span id="age_error" style="display:none; color:red; margin-bottom: 5px"><spring:message code="label.age_error" /></span>				       		
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
<div class="modal fade" id="edit_carclass_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 5%;">
		<div class="modal-content">
			<form action="<c:url value="/admin/editCarClass" />" method="post"
				  data-toggle="validator" role="form" name="edit_car_class_form" id="edit_car_class_form">
				<input type=hidden id="id_edit" value="">
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title"><spring:message code="label.edit_car_class" /></h4>
				</div>
				<div class="modal-body">		
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.name" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.car_class_name" />"
						       id="name_edit" name="name" required 
						       pattern="^[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,50}$"
						        data-bv-regexp-message="<spring:message code="dataerror.carclass_name_exception" />&nbsp
						        <spring:message code="dataerror.carclass_example" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
						       />
					</div>
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_lower_years_limit" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.lower_years_limit" />"
						       id="lower_years_limit_edit" name="lower_years_limit_edit" required 
						       pattern="^[1-9]{1}[0-9]?$" 
						       data-bv-regexp-message="<spring:message code="dataerror.number_value" />&nbsp;
						       <spring:message code="dataerror.value_range" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
							   />
					</div>
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_upper_years_limit" />:&nbsp;
						</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.upper_years_limit" />"
							   id="upper_years_limit_edit" name="upper_years_limit_edit" required 
							   pattern="^[1-9]{1}[0-9]?$" 
						       data-bv-regexp-message="<spring:message code="dataerror.number_value" />&nbsp;
						       <spring:message code="dataerror.value_range" />"
						       data-bv-notempty="true"
						       data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
							   />
					</div>	
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_edit_carclass">	
				</div>
				<div class="modal-footer">
					<span id="age_error_edit" style="display:none; color:red; margin-bottom: 5px"><spring:message code="label.age_error" /></span>					       		
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
				<button class="btn btn-success" type="button" id="add_place_btn" disabled>
					<spring:message code="label.add" />
				</button>
			</div>
		</div>
	</div>
</div>


<!-- Add maneuver modal -->
<div class="modal fade" id="add_maneuver_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 15%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.add_maneuver" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info">
					<spring:message code="label.maneuver" />:&nbsp;
				</label>
				<input type="text" class="form-control"
					   placeholder="<spring:message code="label.maneuver" />" id="new_maneuver" />
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-success" type="button" id="add_maneuver_btn" disabled>
					<spring:message code="label.add" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Change password modal -->
<div class="modal fade" id="change_password_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<form action="<c:url value="/admin/changePassword" />"
				  data-toggle="validator" role="form" id="change_password_form">
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title"><spring:message code="label.admin_change_password" /></h4>
				</div>
				<div class="modal-body">		
					
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_old_password" />:&nbsp;
						</label>
						<input type="password" class="form-control" id="old_password"
						       placeholder="<spring:message code="placeholder.admin_old_password" />" 
						       required />	
						<div class="help-block with-errors" id="old_password_error" style="display: none;">
							<spring:message code="dataerror.password_incorrect" />
						</div>
					</div>
					
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_new_password" />:&nbsp;
						</label>
						<input type="password" class="form-control" id="new_password"
						       placeholder="<spring:message code="placeholder.admin_new_password" />" 
						       data-minlength="5" required 
						       data-error="<spring:message code="dataerror.mimimum_5_characters" />"/>
						<div class="help-block with-errors"></div>
					</div>
					
					<div class="form-group">
						<label class="text-info">
							<spring:message code="label.admin_new_password_repeat" />:&nbsp;
						</label>
						<input type="password" class="form-control" id="repeat_password"
						       placeholder="<spring:message code="placeholder.admin_new_password_repeat" />"
						       data-match="#new_password" data-match-error="<spring:message code="dataerror.passwords_don't_match" />" />										
						<div class="help-block with-errors"></div>	
					</div>
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' 
					    style="display: none;" id="ajax_loader_change_password">
					   <input type="hidden" id="change_password_success" 
					   	value="<spring:message code="dataerror.password_has_changed_successfully" />">
				</div>
				<div class="modal-footer">					       		
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />	
					</button>
					<button class="btn btn-success" type="submit" id="change_password_btn">
						<spring:message code="label.accept" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Delete leader modal -->
<div class="modal fade" id="delete_leader_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title">
					<spring:message code="label.admin_delete_leader" />
				</h4>
			</div>
			<div class="modal-body">
				<label class="text-info">
					<spring:message code="label.admin_delete_leader_confirm_text" />&nbsp;
					<span id="leader_delete_name"></span>?
				</label>
				<input type="hidden" id="leader_delete_url" value="<c:url value="/admin/deleteLeader" />">
				<input type="hidden" id="leader_delete_id" value="" />
				<br><br>
				<div class="alert alert-danger" id="leader_has_team"
					style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
					<spring:message code="label.admin_delete_leader_error" />
				</div>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete_leader">	
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-danger" type="button" id="delete_leader">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Reset leader password modal -->
<div class="modal fade" id="reset_pass_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.admin_reset_password" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info">
					<spring:message code="label.admin_reset_password_confirm_text" />&nbsp;
					<span id="reset_pass_leader_name"></span>?
				</label>
				<input type="hidden" id="reset_pass_url" value="<c:url value="/admin/resetLeaderPass" />">
				<input type="hidden" id="reset_pass_leader_id" value="" />
				<br><br>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_reset_pass">	
				<input type="hidden" id="reset_password_success" 
						value="<spring:message code="label.admin_reset_password_success" />">
			</div>
			<div class="modal-footer">					       		
				<button class="btn btn-primary" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-danger" type="button" id="reset_pass">
					<spring:message code="label.admin_reset" />
				</button>
			</div>
		</div>
	</div>
</div>

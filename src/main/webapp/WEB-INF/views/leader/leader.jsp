<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript'
	src='<c:url value="/resources/js/leader.js" />'></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script src="<c:url value="/resources/js/lib/bootbox.js" />"></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 10px 20px 40px;">

	<table class="width-100">
		<tr>
			<td>
				<h2 class="user-info-name">${currentLeader.firstName}&nbsp;${currentLeader.lastName}</h2>
			</td>
			<c:if test="${currentLeader.user.username.equals(currentUserName)}">
				<td style="padding: 15px 10px 0px 20px;">
					<div class="btn-group" style="float: right;">
						<a href='<c:url value="/leader/edit/${currentLeader.id}" />'
							class="btn btn-info"><spring:message code="label.edit" /></a>
						<button type="button" class="btn btn-primary"
							style="float: right;" id="change_pass_btn">
							<spring:message code="label.change_password" />
						</button>
					</div>
				</td>
			</c:if>
		</tr>
	</table>

	<div>
		<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>
		<a href="<c:url value="/team/${team.id}" />">${team.name}</a>
	</div>
	<div>
		<label class="text-info"><spring:message
				code="label.date_of_birth" />:&nbsp;</label>
		<fmt:formatDate value="${currentLeader.birthday}" pattern="yyyy-dd-MM" />
	</div>
	<div>
		<label class="text-info"><spring:message
				code="label.identification" />:&nbsp;</label>${currentLeader.document}</div>
	<div>
		<label class="text-info"><spring:message code="label.address" />:&nbsp;</label>${currentLeader.address}</div>
	<div>
		<label class="text-info"><spring:message
				code="label.license_number" />:&nbsp;</label>${currentLeader.license}</div>
    <div>
        <label class="text-info"><spring:message
                code="label.email" />:&nbsp;</label>${currentLeader.user.email}</div>
                
	<c:if test="${isTeamByLeader==false}">
		<br>
		<a href='<c:url value="/team/add" />' class="btn btn-primary"> <spring:message
				code="label.add_team" />
		</a>
	</c:if>
</div>

<!-- Change password modal -->
<div class="modal fade" id="change_password_modal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<form action="<c:url value="/admin/changePassword" />"
				data-toggle="validator" role="form" id="change_password_form">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title">
						<spring:message code="label.admin_change_password" />
					</h4>
				</div>
				<div class="modal-body">

					<div class="form-group">
						<label class="text-info"> <spring:message
								code="label.admin_old_password" />:&nbsp;
						</label> <input type="password" class="form-control" id="old_password"
							placeholder="<spring:message code="placeholder.admin_old_password" />"
							required />
						<div class="help-block with-errors" id="old_password_error"
							style="display: none;">
							<spring:message code="dataerror.password_incorrect" />
						</div>
					</div>

					<div class="form-group">
						<label class="text-info"> <spring:message
								code="label.admin_new_password" />:&nbsp;
						</label> <input type="password" class="form-control" id="new_password"
							placeholder="<spring:message code="placeholder.admin_new_password" />"
							data-minlength="5" required
							data-error="<spring:message code="dataerror.mimimum_5_characters" />" />
						<div class="help-block with-errors"></div>
					</div>

					<div class="form-group">
						<label class="text-info"> <spring:message
								code="label.admin_new_password_repeat" />:&nbsp;
						</label> <input type="password" class="form-control" id="repeat_password"
							placeholder="<spring:message code="placeholder.admin_new_password_repeat" />"
							data-match="#new_password"
							data-match-error="<spring:message code="dataerror.passwords_don't_match" />" />
						<div class="help-block with-errors"></div>
					</div>
					<br> <img
						src='<c:url value="/resources/img/ajax-loader.gif" />'
						style="display: none;" id="ajax_loader_change_password"> <input
						type="hidden" id="change_password_success"
						value="<spring:message code="dataerror.password_has_changed_successfully" />">
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">
						<spring:message code="label.cancel" />
					</button>
					<button class="btn btn-success" type="submit"
						id="change_password_btn">
						<spring:message code="label.accept" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
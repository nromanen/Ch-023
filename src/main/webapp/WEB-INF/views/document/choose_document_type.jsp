<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript'
	src='<c:url value="/resources/js/choose_document_type.js" />'></script>

<!-- Modal -->
<div class="modal fade" id="select_document_type_modal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	style="margin-top: 10%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="label.document_choose_type" />
				</h4>
			</div>
			<form action="<c:url value="/document/add" />" method="GET">
				<div class="modal-body">

					<div class="form-group">
						<label class="text-info"><spring:message
								code="label.type_of_document" />:&nbsp;</label> <select
							class="form-control span6" id="document_type"
							name="document_type">
							<option value="1"><spring:message
									code="label.document_racer_license" /></option>
							<option value="2"><spring:message
									code="label.document_racer_insurance" /></option>
							<option value="3"><spring:message
									code="label.document_racer_medical_cerificate" /></option>
							<option value="4"><spring:message
									code="label.document_racer_parental_permission" /></option>
						</select>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="history.go(-1);">
						<spring:message code="label.cancel" />
					</button>
					<button type="submit" class="btn btn-success"
						id="choose_document_type">
						<spring:message code="label.accept" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
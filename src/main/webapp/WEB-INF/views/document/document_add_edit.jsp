<%@page import="net.carting.domain.Document"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page session="false"%>

<link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet">
<link href='<c:url value="/resources/libs/bootstrapValidator/css/bootstrapValidator.min.css" />' rel="stylesheet">
		
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />' charset="UTF-8"></script>
<script type='text/javascript' src='<c:url value="/resources/js/document.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/file-validation.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>

<c:if test="${document ne null}">

</c:if>



<h2 class="text-left user-info-name">
	<c:choose>
		<c:when test="${document ne null}"><spring:message code="label.editing_document" /></c:when>
		<c:otherwise><spring:message code="label.add_document_type" /></c:otherwise>
	</c:choose>
	
	&nbsp;"
	<c:choose>
		<c:when test="${documentType==1}"><spring:message code="label.document_racer_license" /></c:when>
		<c:when test="${documentType==2}"><spring:message code="label.document_racer_insurance" /></c:when>
		<c:when test="${documentType==3}"><spring:message code="label.document_racer_medical_cerificate" /></c:when>
		<c:when test="${documentType==4}"><spring:message code="label.document_racer_parental_permission" /></c:when>
	</c:choose>
	"
</h2>

	<c:choose> 
		<c:when test="${document ne null}">
			<form method="POST" class="well " action="<c:url value="/document/confirmEdit" />" role="form" enctype="multipart/form-data" id="editDocument">
		</c:when> 
		<c:otherwise>
			<form method="POST" class="well" action="<c:url value="/document/addDocument" />" role="form" enctype="multipart/form-data" id="addDocument">
		</c:otherwise> 
	</c:choose>
	
	<c:choose> 
		<c:when test="${document ne null}">
			<input type="hidden" id="type" name="document_id" value="${document.id}"> 
			<input type="hidden" id="file_delete_url" value="<c:url value="/document/deleteFile"/>">		
		</c:when> 
		<c:otherwise>
			<input type="hidden" id="type" name="document_type" value="${documentType}">		
		</c:otherwise> 
	</c:choose>
	

	<!-- Date field, can be merged into 1 expression  -->
	<c:if test="${documentType==4 }">
		<div class="form-group">
			<label class="text-info"><spring:message
					code="label.document_date_start" /><span class="text-danger">*</span>:&nbsp;
			</label> 
			<input type="text" class="form-control datepicker" name="start_date" value="${startDate}"
				placeholder="<spring:message code="placeholder.date" />"
				id="doc_date_picker"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"			
				data-bv-date-format = "YYYY-MM-DD"
				data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	<c:if test="${documentType==2 || documentType==3 }">
		<div class="form-group">
			<label class="text-info"><spring:message code="label.document_valid_until" /><span class="text-danger">*</span>:&nbsp;
			</label> 
			<input type="text" class="form-control datepicker" name="finish_date" value="${finishDate}"
				placeholder="<spring:message code="placeholder.date" />"
				id="doc_date_picker"
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" />"			
				data-bv-date-format = "YYYY-MM-DD"
				data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
				
			<div class="help-block with-errors"></div>
		</div>
	</c:if>

	<!-- Document number field  -->	
	<c:if test="${documentType==1 || documentType==2 }">
		<div class="form-group">
			<label class="text-info"><spring:message code="label.document_number" /><span class="text-danger">*</span>:&nbsp;</label>
			<input type="text" class="form-control" value="${document.name}"
				placeholder="<spring:message code="placeholder.document_number" />"
				id="number" name="number" maxlength="100" 
				data-bv-notempty="true"
				data-bv-notempty-message="<spring:message code="dataerror.field_required" /> <spring:message code="dataerror.enter_document_namber" />"	/>
			<div class="help-block with-errors"></div>
		</div>
	</c:if>
	
	<div class="alert alert-warning text-center">
		<strong><spring:message code="message.attention" /></strong>
		<spring:message code="message.file_warning" />
	</div>
	
	<c:choose> 
		<c:when test="${document ne null}">
			<input type="hidden" value="${document.files.size()}" id="fileCount">		
		</c:when> 
		<c:otherwise>
			<input type="hidden" value="0" id="fileCount">		
		</c:otherwise> 
	</c:choose>
	
	
	<c:if test="${document ne null}">
		<!-- Uploaded files table -->
		<div class="col-sm-7 pull-right">
			<table class="table">
				<c:forEach items="${document.files}" var="file">
					<tr>
						<td><a href="data:image/jpg;base64,<c:out value='${file.file}'/>" class="glyphicon glyphicon-paperclip file-link"><c:out value='${file.name}'/></a>/td>
						<td><button type="button" id="${file.id}" class="btn btn-danger btn-sm delete_file_btn" style="float: right">
								<spring:message code="label.delete" />
							</button>
					</tr>
				</c:forEach>
			</table>
		</div>		
	</c:if>
	
	<!--  Display adding file block  -->
	<c:if test="${(document ne null && fn:length(document.files) < 3) || document == null}" >	
		<label for="filePicker" class="text-info"><spring:message code="label.choose_file" />:</label>
		<table id="fileTable">
			<tr>
				<td>
					<div class="form-group">
							<c:choose> 
							<c:when test="${document ne null}">
								<input type="file" name="file" class="form-control file" id="upload_file" onchange="return ValidateFileUpload(this)" />	
							</c:when> 
							<c:otherwise>
								<input type="file" name="file" class="form-control file" id="upload_file" onchange="return ValidateFileUpload(this)"
							data-bv-notempty="true"
							data-bv-notempty-message="<spring:message code="dataerror.field_required" />"/>
							</c:otherwise> 
						</c:choose>
					</div>
				</td>
			</tr>
		</table>
	
		<div class="form-group">
			<input id="addFile" type="button" class="btn btn-primary btn-sm" value="<spring:message code="label.another_file" />" />
			<div class="alert alert-danger" id="max_count_achieved" style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-left: 10px;">
				<spring:message code="dataerror.max_count_achieved" />
			</div>
		</div>
	</c:if>
	<div class="clearfix"></div>
	<c:if test="${document == null }">
		<!-- Racers Table Begin  -->
		<%
			int number = 0;
		%>
		<div class="form-group">
			<table id="team-table" class="table table-bordered">
				<thead style="font-weight: 100;">
					<tr>
						<th class="text-center success">#</th>
						<th class="success" id="racerLabel" colspan="2"><spring:message code="label.racer" /></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${racers}" var="racer">
						<tr>
							<%
								number++;
							%>
							<td class="text-center"><%=number%></td>
							<td class="text-left"><a href='<c:url value="/racer/${racer.id}" />'>${racer.firstName} ${racer.lastName} </a></td>
							<c:choose>
								<c:when test="${documentType==2 }">
									<td class="text-center racer_checked">
									<input type="checkbox" name="racer_id" value="${ racer.id }" 
										data-bv-notempty="true"
										data-bv-notempty-message="<spring:message code="dataerror.field_required" />" />
										
									</td>
								</c:when>
								<c:when test="${documentType==1|| documentType==3 || documentType==4 }">
									<td class="text-center racer_checked"><input type="radio"
										name="racer_id" value="${ racer.id }" 
										data-bv-notempty="true"
										data-bv-notempty-message="<spring:message code="dataerror.field_required" />"/>
									</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- Racers Table End  -->
	</c:if>
	
	<!-- Different submit buttons  -->
	<c:choose> 
		<c:when test="${document ne null}">
			<input type="submit" class="btn btn-success" value="<spring:message code="label.accept" />" id="edit_document">
		</c:when> 
		<c:otherwise>
			<button type="submit" class="btn btn-success" id="add_document"><spring:message code="label.accept" /></button>
		</c:otherwise> 
	</c:choose>
	
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'style="display: none;" id="ajax_loader">
	
</form>

<!-- Modal window for deleting file   -->
<div class="modal fade" id="delete_file_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title">
					<spring:message code="label.document_delete" />
				</h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message code="message.question_delete_document" /></label>
				<c:forEach items="${document.racers}" var="racer">
					<input type="hidden" class="racer_id" value="${racer.id}">
				</c:forEach>
				<input type="hidden" id="document_delete_url" value="<c:url value="/document/delete" />"> 
				<input type="hidden" id="document_type" value="${documentType}">
				<input type="hidden" id="document_delete_id" value="${document.id}">
				<input type="hidden" id="team_id" value="${document.getTeamOwner().id}"> <br> <br>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_delete">
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
				<button class="btn btn-primary delete_file" type="button" id=""><spring:message code="label.delete" /></button>
			</div>
		</div>
	</div>
</div>
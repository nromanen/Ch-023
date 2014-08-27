<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript'
	src='<c:url value="/resources/js/racer.js" />'></script>

<div style="border: 1px solid #e3e3e3; padding: 0px 10px 20px 40px;">

	<table class="width-100">
		<tr>
			<td>
				<h2 class="user-info-name">${racer.firstName}&nbsp;${racer.lastName}</h2>
			</td>
			<td style="padding: 15px 10px 0px 20px;">
				<div class="btn-group" style="float: right;">
					<c:if test="${team.equals(racer.team)}">
						<a href='<c:url value="/racer/edit/${racer.id}" />'
							class="btn btn-info"><spring:message code="label.edit" /></a>
						<a href="#" class="btn btn-danger" id="delete_racer_btn"><spring:message
								code="label.delete" /></a>
					</c:if>
				</div>
			</td>
		</tr>
	</table>

	<div>
		<label class="text-info"><spring:message code="label.team" />:&nbsp;</label>${racer.team.name}</div>
	<div>
		<label class="text-info"><spring:message
				code="label.date_of_birth" />:&nbsp;</label>
		<fmt:formatDate value="${racer.birthday}" pattern="yyyy-MM-dd" />
	</div>
	<div>
		<label class="text-info"><spring:message code="label.age" />:&nbsp;</label>${racer.getAge()}
	</div>
	<div>
		<label class="text-info"><spring:message
				code="label.identification" />:&nbsp;</label>${racer.document}</div>
	<div>
		<label class="text-info"><spring:message code="label.address" />:&nbsp;</label>${racer.address}</div>
	<div>
		<label class="text-info"><spring:message
				code="sportcategory.sport_category" />:&nbsp;</label>
		<c:choose>
			<c:when test="${racer.getSportsCategory()==0}">
				<spring:message code="sportcategory.without" />
			</c:when>
			<c:when test="${racer.getSportsCategory()==1}">1</c:when>
			<c:when test="${racer.getSportsCategory()==2}">2</c:when>
			<c:when test="${racer.getSportsCategory()==3}">3</c:when>
			<c:when test="${racer.getSportsCategory()==4}">
				<spring:message code="sportcategory.candidate_master_of_sports" />
			</c:when>
			<c:when test="${racer.getSportsCategory()==5}">
				<spring:message code="sportcategory.master_of_sports" />
			</c:when>
		</c:choose>
	</div>
	<div>
		<label class="text-info"><spring:message
				code="label.car_class" /> (<spring:message code="label.number" />):&nbsp;</label>
		<c:if test="${!empty racer.carClassNumbers}">
			<c:forEach items="${racer.carClassNumbers}" var="racerCarClassNumber">
				<span style="font-size: 100%"><b>${racerCarClassNumber.carClass.name}</b></span>(№${racerCarClassNumber.number})&nbsp
			</c:forEach>
		</c:if>
	</div>
	<br>
	<c:forEach items="${racer.documents}" var="document">
		<c:if
			test="${document.teamOwner == team || authority.equals('ROLE_ADMIN')}">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<span class="glyphicon glyphicon-list-alt"></span> <label
						class="text-info"
						style="color: #fff; font-size: 16px; margin: 0 0 10px 0"><a
						href='<c:url value="/document/${document.id}"/>'
						style="color: white"><c:choose>
								<c:when test="${document.getType()==1}">
									<spring:message code="label.document_racer_license" />
								</c:when>
								<c:when test="${document.getType()==2}">
									<spring:message code="label.document_racer_insurance" />
								</c:when>
								<c:when test="${document.getType()==3}">
									<spring:message code="label.document_racer_medical_cerificate" />
								</c:when>
								<c:when test="${document.getType()==4}">
									<spring:message code="label.document_racer_parental_permission" />
								</c:when>
							</c:choose></a></label>
				</div>
				<div class="panel-body">
					<c:if test="${document.approved}">
						<img src='<c:url value="/resources/img/approved.bmp" />'
							style="float: right; width: 150px;">
					</c:if>
					<c:if test="${document.approved==false && document.checked}">
						<img src='<c:url value="/resources/img/unapproved.bmp" />'
							style="float: right; width: 150px; margin: 10px 20px 0 0;">
					</c:if>
					<c:if test="${document.name != null}">
						<div>
							<label class="text-info"><spring:message
									code="label.document_number" />:&nbsp;</label>${document.name}</div>
					</c:if>
					<c:if test="${document.startDate != null}">
						<div>
							<label class="text-info"><spring:message
									code="label.document_date_start" />:&nbsp;</label>
							<fmt:formatDate value="${document.startDate}"
								pattern="dd-MM-yyyy" />
						</div>
					</c:if>
					<c:if test="${document.finishDate != null}">
						<div>
							<label class="text-info"><spring:message
									code="label.document_valid_until" />:&nbsp;</label>
							<fmt:formatDate value="${document.finishDate}"
								pattern="dd-MM-yyyy" />
						</div>
					</c:if>
					<c:forEach items="${document.files}" var="file">
						<div>
							<a target="_blank" href="../document/showDocument/<c:out value='${file.id}'/>"
								class="glyphicon glyphicon-paperclip file-link"><c:out value='${file.name}'/>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</c:forEach>
</div>
<br>
<div class="modal fade" id="delete_racer_modal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title">
					<spring:message code="label.delete_racer" />
				</h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message
						code="message.question_delete_racer" /></label> <input type="hidden"
					id="racer_delete_url" value="<c:url value="/racer/delete" />">
				<input type="hidden" id="racer_delete_id"
					value="<c:url value="${racer.id}" />"> <input type="hidden"
					id="racer_delete_redirect_url"
					value="<c:url value="/team/${racer.team.id}" />"> <br>
				<br> <img
					src='<c:url value="/resources/img/ajax-loader.gif" />'
					style="display: none;" id="ajax_loader_delete">
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<spring:message code="label.cancel" />
				</button>
				<button class="btn btn-primary" type="button" id="delete_racer">
					<spring:message code="label.delete" />
				</button>
			</div>
		</div>
	</div>
</div>

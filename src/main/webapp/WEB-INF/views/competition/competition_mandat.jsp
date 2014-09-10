<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript'
	src="<c:url value="/resources/js/mandat.js" />"></script>

<!-- Sorter includes -->	
<script type='text/javascript'
	src="<c:url value="/resources/js//lib/jquery.dataTables.js" />"></script>
<link href="<c:url value="/resources/style/jquery.dataTables.css" />" rel="stylesheet" type="text/css">

<div>

	<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${competition.name}</label>

	<div class="btn-group" style="float: right; margin-bottom: 10px;">		
		<a href="#" id="show_not_valid" class="btn btn-danger"><spring:message code="label.show_not_valid" /></a>
		<a href="#" id="show_valid" class="btn btn-success"><spring:message code="label.show_valid" /></a>
		<a href="#" id="show_all" class="btn btn-primary"><spring:message code="label.show_all" /></a>
	</div>
			
	<select class="form-control fl-left" style="width: 200px; margin-right: 5px;" id="teams">
		<option value="all"><spring:message code="label.all_teams" /></option>
		<c:if test="${!empty teamList}">
			<c:forEach items="${teamList}" var="team">
				<option value="${team.id}">${team.name}</option>
			</c:forEach>
		</c:if>
	</select>
	<select class="form-control fl-left" style="width: 200px; margin-right: 5px;" id="car_classes">
		<option value="all"><spring:message code="label.all_classes" /></option>
		<c:if test="${!empty carClassCompetitions}">
			<c:forEach items="${carClassCompetitions}" var="carClassCompetition">
				<option value="${carClassCompetition.carClass.id}">${carClassCompetition.carClass.name}</option>
			</c:forEach>
		</c:if>
	</select>
	<br><br>
	<table id="team_table" class="table table-hover table-bordered" style="text-align: center;">
		<thead class="well" style="font-weight: 100;">
			<tr>
				<th style="text-align: center;"><spring:message code="label.team" /></th>
				<th style="text-align: center;"><spring:message code="label.lastname_firstname" /></th>
				<th style="text-align: center;"><spring:message code="label.date_of_birth" /></th>
				<th style="text-align: center;"><spring:message code="label.document_parental_permission" /></th>
				<th style="text-align: center;"><spring:message code="sportcategory.sport_category" /></th>
				<th style="text-align: center;"><spring:message code="label.document_license" /></th>
				<th style="text-align: center;"><spring:message code="label.document_medical_cerificate" /></th>
				<th style="text-align: center;"><spring:message code="label.document_insurance" /></th>
				<th style="text-align: center;"><spring:message code="label.car_class" /></th>
				<th style="text-align: center;"><spring:message code="label.number" /></th>
				<c:if test="${authority.equals('ROLE_ADMIN') && competition.enabled}">
					<th style="text-align: center;">&nbsp;</th>
				</c:if>
			</tr>
		</thead>

		<tbody>
			<c:if test="${!empty racerCarClassCompetitionNumbers}">
				<c:forEach items="${racerCarClassCompetitionNumbers}" var="racerCarClassCompetitionNumber">
					<tr team="${racerCarClassCompetitionNumber.racer.team.id}" 
						carclass="${racerCarClassCompetitionNumber.carClassCompetition.carClass.id}" 
						<c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">class="bg-danger"</c:if>
						>
						<td class="text-left">${racerCarClassCompetitionNumber.racer.team.name}</td>
						<td class="text-left">
							<a href='<c:url value="/racer/${racerCarClassCompetitionNumber.racer.id}" />' id="racer${racerCarClassCompetitionNumber.racer.id}">
								${racerCarClassCompetitionNumber.racer.firstName} ${racerCarClassCompetitionNumber.racer.lastName}
							</a>
							<c:if test="${!racerCarClassCompetitionNumber.racer.enabled}">
								<span class="glyphicon glyphicon-remove" style="color: red; cursor: pointer; float: right;" title="Disabled"></span>
							</c:if>
						</td>
						<td>${formater.format(racerCarClassCompetitionNumber.racer.birthday)}</td>
						
						<td class="sortable" style="vertical-align: middle;">
							<!--Parental permission - type 4 -->
							<c:choose>
								<c:when test="${racerCarClassCompetitionNumber.racer.getAge() < perentalPermissionYears}">
									<c:choose>
										<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(4)==null}">
											<span class="glyphicon glyphicon-minus minus"></span>
										</c:when>
										<c:otherwise>
											<a href='<c:url value="/document/${racerCarClassCompetitionNumber.racer.getDocumentByType(4).id}/?competition_id=${racerCarClassCompetitionNumber.carClassCompetition.competition.id}" />'
												class="glyphicon glyphicon-paperclip fl-right"></a>
											<c:choose>
												<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(4).approved}">
													<span class="glyphicon glyphicon-plus plus"></span>
												</c:when>
												<c:otherwise>
													<span class="glyphicon glyphicon-minus minus"></span>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<span class="glyphicon glyphicon-plus plus"></span>
								</c:otherwise>
							</c:choose>
							<c:if test="${ racerCarClassCompetitionNumber.racer.getDocumentByType(4).checked }">
								<span class="glyphicon glyphicon-eye-open fl-left"></span>
							</c:if>
						</td>
						
						<td>${racerCarClassCompetitionNumber.racer.getStringSportsCategory()}</td>
						
						<td class="sortable" style="vertical-align: middle;">
							<!--Racer's license - type 1 -->
							<c:choose>
								<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(1)==null}">
									<span class="glyphicon glyphicon-minus minus"></span>
								</c:when>
								<c:otherwise>
									<a href='<c:url value="/document/${racerCarClassCompetitionNumber.racer.getDocumentByType(1).id}/?competition_id=${racerCarClassCompetitionNumber.carClassCompetition.competition.id}" />'
										class="glyphicon glyphicon-paperclip fl-right"></a>
									<c:choose>
										<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(1).approved}">
											<span class="glyphicon glyphicon-plus plus"></span>
										</c:when>
										<c:otherwise>
											<span class="glyphicon glyphicon-minus minus"></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<c:if test="${ racerCarClassCompetitionNumber.racer.getDocumentByType(1).checked }">
								<span class="glyphicon glyphicon-eye-open fl-left"></span>
							</c:if>
						</td>
						
						<td class="sortable" style="vertical-align: middle;">
							<!--Racer's medical certificate - type 3 -->
							<c:choose>
								<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(3)==null}">
									<span class="glyphicon glyphicon-minus minus"></span>
								</c:when>
								<c:otherwise>
									<a href='<c:url value="/document/${racerCarClassCompetitionNumber.racer.getDocumentByType(3).id}/?competition_id=${racerCarClassCompetitionNumber.carClassCompetition.competition.id}" />'
										class="glyphicon glyphicon-paperclip fl-right"></a>
									<c:choose>
										<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(3).approved}">
											<c:choose>
												<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(3).finishDate.before(racerCarClassCompetitionNumber.carClassCompetition.competition.dateEnd) } ">
													<span class="glyphicon glyphicon-minus minus"></span>
												</c:when>
												<c:otherwise>
													<span class="glyphicon glyphicon-plus plus"></span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<span class="glyphicon glyphicon-minus minus"></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<c:if test="${ racerCarClassCompetitionNumber.racer.getDocumentByType(3).checked }">
								<span class="glyphicon glyphicon-eye-open fl-left"></span>
							</c:if>
						</td>
						
						<td class="sortable" style="vertical-align: middle;">
							<!--Racer's insurance - type 2 -->
							<c:choose>
								<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(2)==null}">
									<span class="glyphicon glyphicon-minus minus"></span>
								</c:when>
								<c:otherwise>
									<a href='<c:url value="/document/${racerCarClassCompetitionNumber.racer.getDocumentByType(2).id}/?competition_id=${racerCarClassCompetitionNumber.carClassCompetition.competition.id}" />'
										class="glyphicon glyphicon-paperclip fl-right"></a>
									<c:choose>
										<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(2).approved}">
											<c:choose>
												<c:when test="${racerCarClassCompetitionNumber.racer.getDocumentByType(2).finishDate.before(racerCarClassCompetitionNumber.carClassCompetition.competition.dateEnd) }">
													<span class="glyphicon glyphicon-minus minus"></span>
												</c:when>
												<c:otherwise>
													<span class="glyphicon glyphicon-plus plus"></span>
												</c:otherwise>
											</c:choose>											
										</c:when>
										<c:otherwise>
											<span class="glyphicon glyphicon-minus minus"></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<c:if test="${ racerCarClassCompetitionNumber.racer.getDocumentByType(2).checked }">
								<span class="glyphicon glyphicon-eye-open fl-left"></span>
							</c:if>
						</td>
						
						<td>
							<span style="font-weight: bold;" id="carclass${racerCarClassCompetitionNumber.carClassCompetition.id}">
								${racerCarClassCompetitionNumber.carClassCompetition.carClass.name}
							</span>
						</td>
						<td>${racerCarClassCompetitionNumber.numberInCompetition}</td>
						<c:if test="${authority.equals('ROLE_ADMIN') && competition.enabled}">
							<td>
								<a href="#" class="btn btn-danger btn-xs unreg_racer_btn"
								   id="unreg_${racerCarClassCompetitionNumber.racer.id}_${racerCarClassCompetitionNumber.carClassCompetition.id}">
									<spring:message code="label.unregister" />
								</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
</div>

<!-- Unregister racer modal -->
<div class="modal fade" id="unreg_racer_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 10%;">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal">x</button>
				<h4 class="modal-title"><spring:message code="label.unregister_racer_from_car_class" /></h4>
			</div>
			<div class="modal-body">
				<label class="text-info"><spring:message code="label.unregister_confirm" />
					<span id="racer_name"></span><spring:message code="label.from_class" /><span id="carclass_name"></span>?&nbsp;
				</label>
				<input type="hidden" id="unreg_racer_url" value="<c:url value="/carclass/" />">
				<input type="hidden" id="unreg_racer_id" value="<c:url value="" />">
				<input type="hidden" id="unreg_carclass_id" value="<c:url value="" />">
				<br><br>
				<div class="alert alert-danger" id="unreg_error"
					style="display: none; padding: 0px 0px 0px 10px; height: 25px;">
					<spring:message code="label.unregister_failed" />
				</div>
				<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_unreg">
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
				<button class="btn btn-danger" type="button" id="unreg_racer"><spring:message code="label.unregister" /></button>
			</div>
		</div>
	</div>
</div>

<p><span class="glyphicon glyphicon-minus"></span>  - <spring:message code="label.document_missing_or_unapproved" />
<p><span class="glyphicon glyphicon-plus"></span>  - <spring:message code="label.document_is_approved" />
<p><span class="glyphicon glyphicon-paperclip"></span>  - <spring:message code="label.document_is_present" />
<p><span class="glyphicon glyphicon-eye-open"></span>  - <spring:message code="label.document_checked_by_administrator" />

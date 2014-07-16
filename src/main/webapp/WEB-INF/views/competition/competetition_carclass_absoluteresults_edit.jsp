<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/carclasscompetition_summaryresults_edit.js" />'></script> 
	<div id="foreach">	
			<form  data-toggle="validator" >
					<h2 class="user-info-name"><spring:message code="label.summary_results_editing" /></h2>

				<table id="abs_edit_table" class="table table-hover table-bordered" style="text-align: center;">
								<thead class="well" style="font-weight: 100;">
									<tr>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_place" /></th>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_carnumber" /></th>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_racer" /></th>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_summarypoints" /></th>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_comment" /></th>
										<th style="text-align: center;"><spring:message code="label.summary_results_editing_fines" /></th>
									<tr>	
								</thead>
								<tbody>
									<c:if test="${!empty absoluteResultsList}">
										<c:forEach items="${absoluteResultsList}" var="absoluteResult">
											<tr>
												<td>${absoluteResult.absolutePlace}</td>
												<td>${absoluteResult.racerCarClassCompetitionNumber.numberInCompetition}</td>
												<td style="text-align: left;">
													<a href='<c:url value="/racer/${absoluteResult.racerCarClassCompetitionNumber.racer.id}" />'>
														<span  id="driver${absoluteResult.id}" >${absoluteResult.racerCarClassCompetitionNumber.racer.firstName} ${absoluteResult.racerCarClassCompetitionNumber.racer.lastName}</span>
													</a>
												</td>
												<td>
												<div class="form-group">
													<input type="text" class="form-control text-center editres" name="result${absoluteResult.id}" 
														 id="${absoluteResult.id}" value="${absoluteResult.absolutePoints}" placeholder="${absoluteResult.absolutePoints}" 
													 	required pattern="[0-9]{1,}" data-error="Enter valid value" />
													 <div class="help-block with-errors"></div>
													 <input type="hidden" id="edit_res_url" value="<c:url value="/carclass/${carClassCompetition.id}/editResults" />">
												</div>
												 <input type="hidden" id="action_def" value="">
												 <input type="hidden" name="id${absoluteResult.id}"> 
												 <input type="hidden" id="back_url" value="<c:url value="/carclass/${carClassCompetition.id}" />">
												 <input type="hidden" id="placeholder_comment" value="<spring:message code="placeholder.comment" />">
												 <input type="hidden" id="placeholder_value_minus" value="<spring:message code="placeholder.value_minus" />">
												 <input type="hidden" id="placeholder_value_plus" value="<spring:message code="placeholder.value_plus" />">
												</td>
												<td>
												${absoluteResult.comment}
												</td>
												<td>
												<a href='#' class="btn btn-success plus_btn" id="plus${absoluteResult.id}">+</a>
												<a href='#' class="btn btn-danger minus_btn" id="minus${absoluteResult.id}">-</a>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
				<div class="modal-footer">
					<img src='<c:url value="/resources/img/ajax-loader.gif" />'
						style="display: none;" id="edit_summary_results_loader">
					<button type="button" class="btn btn-primary" id="edit_results_cancel"><spring:message code="label.back" /></button>
					<button type="submit" class="btn btn-success" id="edit_results_accept"><spring:message code="label.accept" /></button>
				</div>
		</form>
	</div>
	
	
	
<div class="modal fade" id="changeConcreteResult" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="margin-top: 5%;">
		<div class="modal-content">
			<form action="<c:url value="/carclass/editConcreteResultAction" />"
				  data-toggle="validator" role="form" name="points_form_edit" id="points_form_edit">
				<input type=hidden id="absoluteResult_id_edit" value="">
				<div class="modal-header"><button class="close" type="button" data-dismiss="modal">x</button>
					<h4 class="modal-title"><spring:message code="label.edit_summary_points_modal" /></h4>
				</div>
				<div class="modal-body">	
					<div>
					<label class="text-info">  <spring:message code="label.summary_results_editing_racer" />: &nbsp;</label>
					<span  id="driver_edit" >${absoluteResult.racerCarClassCompetitionNumber.racer.firstName} ${absoluteResult.racerCarClassCompetitionNumber.racer.lastName}</span>
					<br>
					</div>
					<div class="form-group">
						<label class="text-info"><spring:message code="label.summary_results_editing_value_for_change_modal" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_value" />" id="fine_value_edit"
							   required pattern="[0-9]{1,}"
							   data-error="<spring:message code="dataerror.enter_value" />" />
						<div class="help-block with-errors"></div>
					</div>	
					
					<div class="form-group">
						<label class="text-info"><spring:message code="label.summary_results_editing_comment" />:&nbsp;</label>
						<input type="text" class="form-control" placeholder="<spring:message code="placeholder.enter_comment" />" id="comment_edit"
							   required pattern=".{1,70}"
							   data-error="<spring:message code="dataerror.enter_comment" />" />
						<div class="help-block with-errors"></div>
					</div>	
									
					<br>
					<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader_edit_carclass">	
				</div>
				<div class="modal-footer">					       		
					<button class="btn btn-primary" type="button" data-dismiss="modal"><spring:message code="label.cancel" /></button>
					<button class="btn btn-success" type="submit"><spring:message code="label.accept" /></button>
				</div>
			</form>
		</div>
	</div>
</div>




		
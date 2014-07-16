<%@ page import="java.io.*,java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type='text/javascript'
	src="<c:url value="/resources/js/filter.js" />"></script>
<script type='text/javascript'
	src='<c:url value="/resources/js/competition_add_team.js" />'></script>

<div class="modal fade" id="select_competition_modal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-top: 15%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"><spring:message code="label.choose_competition" /></h4>
			</div>
			<form action="<c:url value="/competition/teamRegistration" />"
				method="GET">
				<div class="modal-body">

					<select class="form-control" id="competition" name="competition">
						<c:if test="${!empty competitionsList}">
							<c:forEach items="${competitionsList}" var="competition">
								<option value="${competition.id}"><fmt:formatDate
										value="${competition.dateStart}" pattern="dd-MM-yyyy" />
									&nbsp;${competition.name}
								</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="history.go(-1);">
						<spring:message code="label.cancel" />
					</button>
					<button type="submit" class="btn btn-success"
						id="choose_competition">
						<spring:message code="label.accept" />
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
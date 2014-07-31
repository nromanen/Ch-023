<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />' charset="UTF-8"></script>
<script type='text/javascript' src='<c:url value="/resources/js/competition.js" />'></script>


<c:choose>
	<c:when test="${competition ne null}">
		<h2 class="user-info-name"><spring:message code="label.edit_competition" /></h2>
	</c:when>
	<c:otherwise>
		<h2 class="user-info-name"><spring:message code="label.add_competition" /></h2>
	</c:otherwise>
</c:choose>


	<c:choose> 
		<c:when test="${competition ne null}">			
			<form class="well" method="post" action="<c:url value="/competition/editAction" />"
				data-toggle="validator" role="form" name="editedCompetition" id="edited_competition">			
		</c:when> 
		<c:otherwise>
			<form class="well" method="post" action="<c:url value="/competition/addCompetition" />"
				data-toggle="validator" role="form" name="newCompetition" id="new_competition">
		</c:otherwise> 
	</c:choose>
	

		
	<p style="margin-top: 15px;">
	
	<c:if test="${competition ne null}">
		<input type="hidden" id="id" name="id" value="${competition.id}">
	</c:if>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.name" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_competition_name" />" id="name" name="name" required
			pattern="[^<>\&\^\$]{1,200}" data-error="<spring:message code="dataerror.200_symbols_limit" />"
			value="${competition.name}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.place" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_competition_place" />" id="place" name="place"
			required pattern="[^<>\&\^\$]{1,200}" data-error="<spring:message code="dataerror.200_symbols_limit" />"
			value="${competition.place}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.start_date" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message code="placeholder.date" />" id="dateStart"
			name="dateStart" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />"
			value="<fmt:formatDate value="${competition.dateStart}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.end_date" /><span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message code="placeholder.date" />" id="dateEnd"
			name="dateEnd" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />"
			value="<fmt:formatDate value="${competition.dateEnd}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.first_race_date" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message code="placeholder.date" />" id="firstRaceDate"
			name="firstRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />"
			value="<fmt:formatDate value="${competition.firstRaceDate}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.second_race_date" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="<spring:message code="placeholder.date" />" id="secondRaceDate"
			name="secondRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />"
			value="<fmt:formatDate value="${competition.secondRaceDate}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.secretary_name" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_secretary_name" />" id="secretaryName"
			name="secretaryName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,100}"
			data-error="<spring:message code="dataerror.competition_director" />"
			value="${competition.secretaryName}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.secretary_category_judicial_license" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_secretary_category_judical_license" />"
			id="secretaryCategoryJudicialLicense"
			name="secretaryCategoryJudicialLicense" required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.competition_director_license" />"
			value="${competition.secretaryCategoryJudicialLicense}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.director_name" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_director_name" />" id="directorName"
			name="directorName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,100}"
			data-error="<spring:message code="dataerror.competition_director" />" value="${competition.directorName}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info"><spring:message code="label.competition.director_category_judicial_license" /><span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="<spring:message code="placeholder.enter_director_category_judical_license" />"
			id="directorCategoryJudicialLicense"
			name="directorCategoryJudicialLicense" required pattern="[^<>\&\^\$]{1,100}"
			data-error="<spring:message code="dataerror.competition_director_license" />"
			value="${competition.directorCategoryJudicialLicense}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<br>
	<c:choose> 
		<c:when test="${competition ne null}">
			<input type="submit" class="btn btn-success" value="<spring:message code="label.save_changes" />" id="edit_competition">
		</c:when> 
		<c:otherwise>
			<input type="button" class="btn btn-success" value="<spring:message code="label.add" />" id="add_competition">
		</c:otherwise> 
	</c:choose>
	
	<input type="button" class="btn btn-default" value="<spring:message code="label.cancel" />" id="cancel_add_competition"> 
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'style="display: none;" id="ajax_loader">	
	<br>
	<div class="alert alert-danger" id="add_competition_error"
		style="display: none; padding: 0px 10px 0px 10px; height: 25px; margin-top: 10px;">
		<spring:message code="dataerror.competition_date" />
	</div>	
		
</form>
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
		<h2 class="user-info-name">Edit competition</h2>
	</c:when>
	<c:otherwise>
		<h2 class="user-info-name">Add competition</h2>
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
		<label class="text-info">Name<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter competition name" id="name" name="name" required
			pattern=".{1,200}" data-error="Limit: 200 symbols"
			value="${competition.name}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Place<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter competition place" id="place" name="place"
			required pattern=".{1,200}" data-error="Limit: 200 symbols"
			value="${competition.place}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Start date<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="dateStart"
			name="dateStart" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-30"
			value="<fmt:formatDate value="${competition.dateStart}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">End date<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="dateEnd"
			name="dateEnd" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-06-01"
			value="<fmt:formatDate value="${competition.dateEnd}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">First race date<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="firstRaceDate"
			name="firstRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-30"
			value="<fmt:formatDate value="${competition.firstRaceDate}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Second race date<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="secondRaceDate"
			name="secondRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-31"
			value="<fmt:formatDate value="${competition.secondRaceDate}" pattern="yyyy-MM-dd" />" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Secretary name<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter secretary name" id="secretaryName"
			name="secretaryName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,100}"
			data-error="Example: John Watson"
			value="${competition.secretaryName}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Secretary category judicial license<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter secretary category judicial license"
			id="secretaryCategoryJudicialLicense"
			name="secretaryCategoryJudicialLicense" required pattern=".{1,100}"
			data-error="Example: HK"
			value="${competition.secretaryCategoryJudicialLicense}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Director name<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter director name" id="directorName"
			name="directorName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-\.]{1,100}"
			data-error="Example: John Watson" value="${competition.directorName}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Director category judicial license<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter director category judicial license"
			id="directorCategoryJudicialLicense"
			name="directorCategoryJudicialLicense" required pattern=".{1,100}"
			data-error="Example: HK"
			value="${competition.directorCategoryJudicialLicense}" />
		<div class="help-block with-errors"></div>
	</div>
	
	<br>
	<c:choose> 
		<c:when test="${competition ne null}">
			<input type="submit" class="btn btn-success" value="Save changes" id="edit_competition">
		</c:when> 
		<c:otherwise>
			<input type="submit" class="btn btn-success" value="Add" id="add_competition">
		</c:otherwise> 
	</c:choose>
	
	
	<input type="button" class="btn btn-default" value="Cancel" id="cancel_add_competition"> 
	<img src='<c:url value="/resources/img/ajax-loader.gif" />'style="display: none;" id="ajax_loader">
	<br>
		
</form>
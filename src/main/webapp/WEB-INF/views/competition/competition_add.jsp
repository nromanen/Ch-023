<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href='<c:url value="/resources/style/datepicker.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/bootstrap-datepicker.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/datepicker/locales/bootstrap-datepicker.ua.js" />' charset="UTF-8"></script>
<script type='text/javascript' src='<c:url value="/resources/js/competition.js" />'></script>

<h2 class="user-info-name">New competition</h2>

<form class="well" method="post" action="<c:url value="/competition/addCompetition" />"
	data-toggle="validator" role="form" name="newCompetition" id="new_competition">
		
	<p style="margin-top: 15px;">
	
	<div class="form-group">
		<label class="text-info">Name<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter competition name" id="name" name="name" required
			pattern=".{1,200}" data-error="Limit: 200 symbols" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Place<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter competition place" id="place" name="place"
			required pattern=".{1,200}" data-error="Limit: 200 symbols" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Start date<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="dateStart"
			name="dateStart" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-30" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">End date<span class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="dateEnd"
			name="dateEnd" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-06-01" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">First race date<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="firstRaceDate"
			name="firstRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-30" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Second race date<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control datepicker"
			placeholder="Enter date in format (YYYY-MM-DD)" id="secondRaceDate"
			name="secondRaceDate" required
			pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
			data-error="Valid format is YYYY-MM-DD. For example: 2014-05-31" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Secretary name<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter secretary name" id="secretaryName"
			name="secretaryName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="Example: John Watson" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Secretary category judicial license<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter secretary category judicial license"
			id="secretaryCategoryJudicialLicense"
			name="secretaryCategoryJudicialLicense" required pattern=".{1,100}"
			data-error="Example: HK" />
		<div class="help-block with-errors"></div>
	</div>
	
	<div class="form-group">
		<label class="text-info">Director name<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter director name" id="directorName"
			name="directorName" required
			pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,100}"
			data-error="Example: John Watson" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label class="text-info">Director category judicial license<span
			class="text-danger">*</span>:&nbsp;
		</label> <input type="text" class="form-control"
			placeholder="Enter director category judicial license"
			id="directorCategoryJudicialLicense"
			name="directorCategoryJudicialLicense" required pattern=".{1,100}"
			data-error="Example: HK" />
		<div class="help-block with-errors"></div>
	</div>

	<br>
	<input type="submit" class="btn btn-success" value="Add" id="add_competition">
	<input type="button" class="btn btn-default" value="Cancel" id="cancel_add_competition">
	<img src='<c:url value="/resources/img/ajax-loader.gif" />' style="display: none;" id="ajax_loader">
	<br>
		
</form>
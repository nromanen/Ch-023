<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href='<c:url value="/resources/style/wysiwyg.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/carclasscompetition_editrace.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/bootstrap-wysiwyg.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/lib/jquery.hotkeys.js" />'></script>

<h2 class="user-info-name">Edit race</h2>

<form class="well" method="post" action="editRace" id="edit_race_form"
	data-toggle="validator" role="form" commandName="race">

	<p style="margin-top: 15px;">
	<div class="form-group">
		<label path="numberOfLaps" class="text-info">Number of laps:<span class="text-danger">*</span>:&nbsp;
		</label> <input path="numberOfLaps" name="numberOfLaps"
			class="form-control" placeholder="Enter number of laps"
			id="number_of_laps" required pattern="^[1-9]\d*$"
			data-error="Example: Write a valid number"
			value="${carClassCompetition.circleCount}" />
		<div class="help-block with-errors"></div>
	</div>

	<div class="form-group">
		<label path="numberOfMembrs" class="text-info">Number of
			members: ${membersCount}&nbsp;
		</label> <input type="hidden" path="numberOfMembers"
			name="numberOfMembers" class="form-control"
			placeholder="Enter number of members" id="number_of_members" required
			pattern="^[1-9]\d*$" data-error="Example: Write a valid number"
			value="${membersCount}" />
		<div class="help-block with-errors"></div>
	</div>

	<label path="resultSequance" class="text-info">Result sequence<span
		class="text-danger">*</span>:&nbsp;
	</label> <br> <span> Valid numbers:</span> <span  id="validNumbers" data-validnumbers="${validNumbers}" >${validNumbers}</span>
	<div class='error'></div>
	
	<input type="hidden" path="resultSequance" name="resultSequance"
			class="form-control" placeholder="Enter result sequance"
			id="result_sequance" value="${race.resultSequance}" />

	 <div id="editor"> </div> 
	
	<input type="button" class="btn btn-primary" value="Recalculate" id="edit_race_btn">
	<input type="button" class="btn btn-success" value="Validate" id="validate_btn">

</form>		       

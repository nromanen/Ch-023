<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href='<c:url value="/resources/style/bootstrap/css/bootstrap.min.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
			<div class="page-header">
				<c:choose>
					<c:when test="${!empty qualifyingList}">
						<h2 class="user-info-name">Edit qualifying</h2>
					</c:when>
					<c:otherwise>
						<h2 class="user-info-name">Add qualifying</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<c:if test="${membersCount > 0 }">
				<c:choose>
					<c:when test="${!empty qualifyingList}">
						<form role="form" id="testRace" action="proccesQualifying" method="post" class="form-horizontal"
							data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
			                data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
			                data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					</c:when>
					<c:otherwise>
						<form role="form" id="testRace" action="proccesQualifying" method="post"class="form-horizontal"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
			            data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
			            data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					</c:otherwise>
				</c:choose>
				<div class="form-group">
				<label class="col-lg-3 control-label">Number</label>
				<div class="col-lg-3">
				<label class="col-lg-3 control-label">Time<span style="color:red">*</span></label>
				</div>
				</div>
				<c:forEach items="${validNumbers}" var="number" varStatus="counter">
				
					<div class="form-group">
						<label class="col-lg-3 control-label">${number}</label>
						<div class="col-lg-3">
							<input  type="text" class="form-control" onchange='Go()' placeholder="[hh:]mm:ss" id='id_${counter.index}' name="time_${counter.index}"
								<c:if test='${!empty qualifyingList }'>value="${qualifyingList.get(counter.index).racerTime.toString()}"</c:if>
								pattern="^(\d\d:)?[0-5]\d:[0-5]\d$" 
								data-bv-regexp-message="[hh:]mm:ss"
								
								data-bv-notempty="true"
								data-bv-notempty-message='required'>
						</div>
					</div>
				</c:forEach>
					<div class="form-group">
					<input type="hidden" class="times" name="timeResult" id="time">
					<input type="hidden" name="numbersResult" id="numbers" value="${validNumbers}">
					<div class="col-lg-9 col-lg-offset-3">
						
						<input type="submit" class="btn btn-success" onClick="Go()" id="addTestRacesubmit" value="Add">
					</div>
					</div>
				</form>
			</c:if>
 <script type="text/javascript">
 $(document).ready(function() {
	    $('#profileForm').bootstrapValidator()
	    Go();
 });
 
	function Go() {
		var str="";
		var mas=[];
		$('#testRace [id^=id]').each(
			function() {
				if(this.value!='') {
					if(this.value.length==8) {
						if(this.value.indexOf('00')==0) {
							this.value=this.value.substring(3,8)
						}
					}
					if(mas.indexOf(this.value)<0) {
					mas.push(this.value.trim());
					} else {
						this.value='';
						document.getElementById('addTestRacesubmit').disabled=true;
					}
				} else {
					document.getElementById('addTestRacesubmit').disabled=true;
				}
			}
		);
		document.getElementById('time').value=mas;
	}
</script> 

 
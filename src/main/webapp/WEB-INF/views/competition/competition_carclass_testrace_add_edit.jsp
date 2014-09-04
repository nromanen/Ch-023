<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link href='<c:url value="/resources/style/bootstrap/css/bootstrap.min.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
<div class="page-header">
	<c:choose>
		<c:when test="${!empty qualifyingList}">
			<h2 class="user-info-name"><spring:message code="label.edit_qualifying" /></h2>
		</c:when>
		<c:otherwise>
			<h2 class="user-info-name"><spring:message code="label.add_qualifying" /></h2>
		</c:otherwise>
	</c:choose>
</div>
<c:if test="${membersCount > 0 }">
	<form role="form" id="testRace" action="proccesQualifying" method="post"class="form-horizontal"
	data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
	data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
	data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
		<div class="form-group">
			<label class="col-lg-3 control-label"><spring:message code="label.car_number"/></label>
			<div class="col-lg-3">
			<label class="col-lg-3 control-label"><spring:message code="label.time"/><span style="color:red">*</span></label>
			</div>
		</div>
		<c:choose>
				<c:when test="${!empty qualifyingList}">
					<c:forEach items="${qualifyingList}" var="qualifying">
						<div class="form-group">
							<label class="col-lg-3 control-label">${qualifying.racerNumber}</label>
							<div class="col-lg-3">
								<input  type="text" class="form-control" onchange='Go()' placeholder="[hh:]mm:ss" id='id_${counter.index}' name="time_${counter.index}"
									value="${qualifying.getTimeString()}"
									pattern="^((\d?\d:)?[0-5]?\d:)?[0-5]?\d((,|\.)\d{1,3})?$" 
									data-bv-regexp-message="<spring:message code="qualifying.time_format"/>"
									data-bv-notempty="true"
									data-bv-notempty-message="<spring:message code="label.all_fields_are_required"/>">
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${validNumbers}" var="number" varStatus="counter">
	
						<div class="form-group">
							<label class="col-lg-3 control-label">${number}</label>
							<div class="col-lg-3">
								<input  type="text" class="form-control" onchange='Go()' placeholder="[hh:]mm:ss" id='id_${counter.index}' name="time_${counter.index}"
									pattern="^((\d?\d:)?[0-5]?\d:)?[0-5]?\d((,|\.)\d{1,3})?$" 
									data-bv-regexp-message="<spring:message code="qualifying.time_format"/>"
									data-bv-notempty="true"
									data-bv-notempty-message="<spring:message code="label.all_fields_are_required"/>">
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		<div class="form-group">
		<input type="text" class="times" name="timeResult" id="time">
		<input type="hidden" name="numbersResult" id="numbers" value="${validNumbers}">
		<div class="col-lg-9 col-lg-offset-3">
			<c:choose>
				<c:when test="${!empty qualifyingList}">
					<input type="submit" class="btn btn-success" onClick="Go()" id="addTestRacesubmit" 
						value="<spring:message code="label.edit"/>">
				</c:when>
				<c:otherwise>
					<input type="submit" class="btn btn-success" onClick="Go()" id="addTestRacesubmit" 
						value="<spring:message code="label.add"/>">
				</c:otherwise>
			</c:choose>
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
					this.value = this.value.replace(",",".")
					if(this.value.indexOf(',')>0) {
						alert(this.value)
						this.value=this.value.replace(",",".")
						alert(this.value)
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

 
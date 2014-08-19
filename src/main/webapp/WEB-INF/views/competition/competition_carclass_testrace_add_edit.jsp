<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
<h2 class="user-info-name">Add test race</h2>
	<c:if test="${membersCount > 0 }">
		<form role="form" id="addTestRace" action="addQualifying" method="post">
			<div class="form-group" style="max-width: 250px">
				<table width="200" class="table">
					<thead>
						<tr>
							<th>Number</th>
							<th>Time</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${validNumbers}" var="number" varStatus="counter">
							<tr>
								<td style="width: 100px; text-align: center">
									<h4>${number}</h4>
								</td>
								<td style="width: 100px;" class="time"><input type="hidden" value="${number}">
									<input style="width: 100px;" required type="text" class="form-control time" onchange='Go()' placeholder="mm:ss" id='id_${counter.index}' name="time_${counter.index}"
									pattern="^\d\d:[0-5]\d$"
									data-bv-regexp-message="The full name can consist of alphabetical characters and spaces only"
									data-bv-notempty
									data-bv-notempty-message='<spring:message code="dataerror.field_required"/>'
									>
								</td>
							</tr>
							<input type="hidden" value="${number}" name="number_${counter.index}" id="n_${counter.index}">
							
						</c:forEach>
 					</tbody>
				</table>
				<input type="text" class="times" name="timeResult" id="time">
				<input type="submit" class="btn btn-success" id="addTestRacesubmit" value="Add">
			</div>
		</form>
	</c:if>

 <script type="text/javascript">
	function Go() {
		var str="";
		var mas=[];
		$('#addTestRace [id^=id]').each(
			function() {
				if(this.value!='') {
					if(mas.indexOf(this.value)<0) {
					mas.push(this.value);
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

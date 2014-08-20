<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript' src='<c:url value="/resources/js/competition_carclass.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.js" />'></script>
<c:choose>
	<c:when test="${!empty qualifyingList}">
		<h2 class="user-info-name">Edit qualifying</h2>
	</c:when>
	<c:otherwise>
		<h2 class="user-info-name">Add qualifying</h2>
	</c:otherwise>
</c:choose>
	<c:if test="${membersCount > 0 }">
		<c:choose>
			<c:when test="${!empty qualifyingList}">
				<form role="form" id="testRace" action="editQualifying" method="post">
			</c:when>
			<c:otherwise>
				<form role="form" id="testRace" action="addQualifying" method="post">
			</c:otherwise>
		</c:choose>
			<div class="form-group" style="max-width: 250px">
				<table width="200" class="table">
					<thead>
						<tr>
							<th>Number</th>
							<th>Time<span style="color:red">*</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${validNumbers}" var="number" varStatus="counter">
							<tr>
								<td style="width: 100px; text-align: center">
									<h4>${number}</h4>
								</td>
								<td style="width: 100px;" class="time">
									<input style="width: 100px;" type="text" class="form-control time" onchange='Go()' placeholder="[HH:]mm:ss" id='id_${counter.index}' name="time_${counter.index}"
										<c:if test='${!empty qualifyingList }'>value="${qualifyingList.get(counter.index).racerTime.toString()}"</c:if>
										pattern="^(\d\d:)?[0-5]\d:[0-5]\d$" required 
										data-bv-regexp-message="The full name can consist of alphabetical characters and spaces only"
										data-bv-notempty
										data-bv-notempty-message='<spring:message code="dataerror.field_required"/>'>
								</td>
							</tr>
						</c:forEach>
 					</tbody>
				</table>
				<input type="text" class="times" name="timeResult" id="time">
				<input type="submit" class="btn btn-success" onClick="Go()" id="addTestRacesubmit" value="Add">
			</div>
		</form>
	</c:if>

 <script type="text/javascript">
	function Go() {
		var str="";
		var mas=[];
		$('#testRace [id^=id]').each(
			function() {
				if(this.value!='') {
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

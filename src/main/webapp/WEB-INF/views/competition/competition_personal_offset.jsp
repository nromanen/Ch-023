<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.vertical {
		-moz-transform: rotate(90deg);
    	-webkit-transform: rotate(90deg);
    	-o-transform: rotate(90deg);
    	writing-mode: tb-rl;
	}
	th {
		height: 50px;
		text-align: center;
	}
</style>
<div>

	<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${competition.name}</label>			
	
	<table class="table table-hover table-bordered" style="text-align: center;">
		<thead class="well" style="font-weight: 100;">
			<tr>
				<th rowspan="2">№</th>
				<th rowspan="2"><spring:message code="label.lastname_firstname" /></th>
				<th rowspan="2"><spring:message code="label.command_city" /></th>
				<th rowspan="2" class="vertical"><spring:message code="sportcategory.sport_category" /></th>
				<th rowspan="2"><spring:message code="label.start_number" /></th>
				<th colspan="2"><spring:message code="label.control_race" /></th>
				<th colspan="3"><spring:message code="label.first_final_race" /></th>
				<th colspan="3"><spring:message code="label.second_final_race" /></th>
				<th rowspan="2"><spring:message code="label.points_sum" /></th>
				<th rowspan="2"><spring:message code="label.competition.place_in_race" /></th>
				<th rowspan="2"><spring:message code="label.points_by_table_b" /></th>
			</tr>
			<tr>
				<th class="vertical"><spring:message code="label.time" /></th>
				<th class="vertical"><spring:message code="label.competition.place_in_race" /></th>
				<th class="vertical"><spring:message code="label.laps" /></th>
				<th class="vertical" ><spring:message code="label.competition.place_in_race" /></th>
				<th class="vertical"><spring:message code="label.points" /></th>
				<th class="vertical"><spring:message code="label.laps" /></th>
				<th class="vertical"><spring:message code="label.competition.place_in_race" /></th>
				<th class="vertical"><spring:message code="label.points" /></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
			
</div>

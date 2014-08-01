<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div>

	<label class="text-info" style="font-size: 20px; width: 100%; text-align: center; margin-bottom: 20px;">${competition.name}</label>			
	
	<table id="team_table" class="table table-hover table-bordered" style="text-align: center;">
		<thead class="well" style="font-weight: 100;">
			<tr>
				<th style="text-align: center;">№</th>
				<th style="text-align: center;"><spring:message code="label.lastname_firstname" /></th>
				<th style="text-align: center;"><spring:message code="label.command_city" /></th>
				<th style="text-align: center;"><spring:message code="sportcategory.sport_category" /></th>
				<th style="text-align: center;"><spring:message code="label.start_number" /></th>
				<th style="text-align: center;">
					<table>
						<tr>
							<th style="text-align: center;"><spring:message code="label.control_race" /></th>
						</tr>
						<tr>
							<th style="text-align: center;"><spring:message code="label.time" /></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
						</tr>
					</table>
				</th>
				<th style="text-align: center;">
					<table>
						<tr>
							<th style="text-align: center;"><spring:message code="label.first_final_race" /></th>
						</tr>
						<tr>
							<th style="text-align: center;"><spring:message code="label.laps" /></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
							<th style="text-align: center;"><spring:message code="label.points" /></th>
						</tr>
					</table>
				</th>
				<th style="text-align: center;">
					<table>
						<tr>
							<th style="text-align: center;"><spring:message code="label.second_final_race" /></th>
						</tr>
						<tr>
							<th style="text-align: center;"><spring:message code="label.laps" /></th>
							<th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
							<th style="text-align: center;"><spring:message code="label.points" /></th>
						</tr>
					</table>
				</th>
				<th style="text-align: center;"><spring:message code="label.points_sum" /></th>
				<th style="text-align: center;"><spring:message code="label.competition.place_in_race" /></th>
				<th style="text-align: center;"><spring:message code="label.points_by_table_b" /></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
			
</div>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<table class="table">
	<c:if test="${!empty teamList}">
		<tr>
			<td style="text-align: center;">
				<div>${competition.name}</div>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<div>${competition.place}</div>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<div>${competitionDate}</div>
			</td>
		</tr>
		<tr>
			<td>
				<table class="table table-hover table-bordered" id="racers_table"
					style="text-align: center;">
					<thead class="well">
						<tr>
							<th style="text-align: center;" rowspan="2">№</th>
							<th style="text-align: center;" rowspan="2">Team name</th>
							<th style="text-align: center;" colspan="2">ShKP</th>
							<th style="text-align: center;" colspan="2">Maneuver</th>
							<th style="text-align: center;" colspan="2">Total</th>
						</tr>
						<tr>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
							<th style="text-align: center;">Points</th>
							<th style="text-align: center;">Place</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${teamList}" var="team" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td style="text-align: left; padding-left: 20px;">
									<a href="<c:url value="/team/${team.id}" />">${team.name}</a> 
								</td>
								<td>${ShKPResults[index.index]}</td>
								<td>${absPlaces[index.index]}</td>
								<td>${manResults[index.index]}</td>
								<td>${manPlaces[index.index]}</td>
								<td></td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				Secretary: ${competition.secretaryName}
			</td>
		</tr>
		<tr>
			<td>
				Director: ${competition.directorName}
			</td>
		</tr>
	</c:if>
</table>

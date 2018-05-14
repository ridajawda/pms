<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<div class="panel panel-primary panel-lg">
	<div class="panel-heading">
		Employee(s) &nbsp;<span class="badge"><c:if
				test="${projectEmployeesList!=null}">${projectEmployeesList.size()}</c:if></span>

	</div>
	<div class="panel-body">
		<c:if test="${!empty projectEmployeesList}">
			<div class="table-responsive">
				<table class="table table-bordered table-hover table-striped"
					id="projectEmployeesTable">
					<thead>
						<tr>
							<th>S.NO</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projectEmployeesList}" var="projectEmployee"
							varStatus="projectEmployeesListStatus">
							<tr>
								<td>${projectEmployeesListStatus.index+1 }</td>
								<td>${projectEmployee.firstName}</td>
								<td>${projectEmployee.lastName}</td>
								<td><a
									href="javascript:deleteProjectEmp('${project.id}','${projectEmployee.id}')">Delete</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
	<div class="panel-heading">
		Clients(s) &nbsp;<span class="badge"><c:if
				test="${projectClientsList!=null}">${projectClientsList.size()}</c:if></span>
	</div>
	<div class="panel-body">
		<c:if test="${!empty projectClientsList}">
			<div class="table-responsive">
				<table class="table table-bordered table-hover table-striped"
					id="projectEmployeesTable">
					<thead>
						<tr>
							<th>S.NO</th>
							<th>Name</th>
							<th>Address</th>
							<th>Email</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projectClientsList}" var="projectClient"
							varStatus="projectEmployeesListStatus">
							<tr>
								<td>${projectClientsListStatus.index+1 }</td>
								<td>${projectClient.name}</td>
								<td>${projectClient.address}</td>
								<td>${projectClient.email}</td>
								<td><a
									href="javascript:deleteProjectEmp('${project.id}','${projectClient.id}')">Delete</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
	<div class="panel-heading">
		Consultants(s) &nbsp;<span class="badge"><c:if
				test="${projectConsultantsList!=null}">${projectConsultantsList.size()}</c:if></span>
	</div>
	<div class="panel-body">
		<c:if test="${!empty projectConsultantsList}">
			<div class="table-responsive">
				<table class="table table-bordered table-hover table-striped"
					id="projectEmployeesTable">
					<thead>
						<tr>
							<th>NO</th>
							<th>Name</th>
							<th>Address</th>
							<th>Email</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projectConsultantsList}" var="projectConsultant"
							varStatus="projectEmployeesListStatus">
							<tr>
								<td>${projectConsultantsListStatus.index+1 }</td>
								<td>${projectConsultant.name}</td>
								<td>${projectConsultant.address}</td>
								<td>${projectConsultant.email}</td>
								<td><a
									href="javascript:deleteProjectEmp('${project.id}','${projectConsultant.id}')">Delete</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$('#projectEmployeesTable').DataTable();
	});
</script>
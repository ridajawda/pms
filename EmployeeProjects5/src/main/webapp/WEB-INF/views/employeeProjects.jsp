<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
<title>Employee Projects Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://www.jquery-az.com/boots/css/bootstrap-multiselect/bootstrap-multiselect.css"
	type="text/css">
<script type="text/javascript"
	src="https://www.jquery-az.com/boots/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#employeeId").focus();
		$('#projectsId').multiselect({
			includeSelectAllOption : true,
			buttonWidth : 250,
			enableFiltering : true
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h1>Add Employee Projects</h1>

		<c:url var="addAction" value="/employee/projects/add"></c:url>

		<form class="form-inline" action="${addAction}" method="post">
			<div class="form-group">
				<label for="projectsId">Select Project(s):</label> 
				<select
					class="form-control" name="projects" id="projectsId" multiple="multiple" >
					<c:forEach var="project" items="${listProjects}">
						<option value="${project.id}">${project.name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="employeeId">Select Employee:</label> 
				<select
					class="form-control" name="employeeId" id="employeeId" >
					<option value="">Select Employee</option>
					<c:forEach var="employee" items="${listEmployees}">
						<option value="${employee.id}">${employee.firstName}</option>
					</c:forEach>
				</select>
			</div>
			<button type="submit" class="btn btn-primary"
				onclick="return verify()">Submit</button>
		</form>

		<br>
		<div class="panel panel-primary panel-lg">
			<div class="panel-heading">
				Employees Projects&nbsp;<span class="badge"><c:if
						test="${listEmployees!=null}">${listEmployees.size()}</c:if></span>

			</div>
			<div class="panel-body">
				<c:if test="${!empty listEmployees}">
					<div class="table-responsive">
						<table class="table table-bordered table-hover table-striped"
							id="employeeProjectsTable">
							<thead>
								<tr>
									<th>Employee ID</th>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Projects</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listEmployees}" var="employee">
									<tr>
										<td>${employee.id}</td>
										<td>${employee.firstName}</td>
										<td>${employee.lastName}</td>
										<td><c:if
												test="${employee.projects!=null && employee.projects.size()>0}">
												<c:forEach items="${employee.projects}" var="project" varStatus="status">
                                                    ${project.name}
                                                <c:if test="${status.index+1 != employee.projects.size()}">,</c:if>
												</c:forEach>
										</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</div>
		</div>

	</div>
	<script type="text/javascript">
		toastr.options = {
			"closeButton" : true,
			"debug" : false,
			"newestOnTop" : true,
			"progressBar" : true,
			"positionClass" : "toast-top-right",
			"preventDuplicates" : true,
			"onclick" : null,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "5000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}

		function showMessage(message, type) {
			if (type == "error") {
				toastr.error(message, "Error");
			} else if (type == "info") {
				toastr.info(message, "Info");
			} else if (type == "warning") {
				toastr.warning(message, "Warning");
			} else if (type == "success") {
				toastr.success(message, "Success");
			} else {
			}
		}
		$(document).ready(function() {
			$('#employeeProjectsTable').DataTable();
		});
		function verify() {
			if ($("#employeeId").val() == "") {
				showMessage("Please Select Employee", "warning");
				$("#employeeId").focus();
				return false;
			} else if ($("#projectsId").val() == "") {
				showMessage("Please Select Project(s)", "warning");
				$("#projectsId").focus();
				return false;
			} else {
				return true;
			}
		}
	</script>
</body>
</html>

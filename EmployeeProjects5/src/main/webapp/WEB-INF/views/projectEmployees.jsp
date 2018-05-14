<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
<title>Project Employees</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
	<div class="container">
		<h1>Project Employees</h1>
		<form action="/projectEmployees" id="projectEmployeesFormId"
			method="get">
			<div class=" col-xs-4">
				<select name="project" class="form-control"
					onchange="javascript:projectEmployees('<c:url value='/project/employees/' />',this.value)">
					<option value="">Select Project</option>
					<c:forEach items="${projectsList}" var="project">
						<option value="${project.id}">${project.name }</option>
					</c:forEach>
				</select>
			</div>
		</form>
		<br> <br>
		<div id="projectEmployeesGridId"></div>
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
		
		function projectEmployees(serverUrl, project) {
			if (project != "") {
				$.ajax({
					url : serverUrl + '?project=' + project,
					success : function(data) {
						$("#projectEmployeesGridId").html(data);
					},
					error : function() {
						alert("Unable to load details");
					}
				});
			}
		}

		function deleteProjectEmp(project, employee) {
			if (confirm("Are you sure you want to delete?")) {
				$.ajax({
					url : '<c:url value='/project/employee/delete?project=' />'+ project
							+ '&employee=' + employee,
					success : function(data) {
						alert(data);
						window.location.reload();
					},
					error : function() {
						alert("Unable to load details");
					}
				});
			}
		}
	</script>
</body>
</html>

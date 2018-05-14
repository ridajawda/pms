<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
<title>Client Projects Page</title>
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
		$("#clientId").focus();
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
		<h1>Add Client Projects</h1>

		<c:url var="addAction" value="/client/projects/add"></c:url>

		<form class="form-inline" action="${addAction}" method="post">
			<div class="form-group">
				<label for="clientId">Select Client:</label> 
				<select
					class="form-control" name="clientId" id="clientId" >
					<option value="">Select Client</option>
					<c:forEach var="client" items="${listClients}">
						<option value="${client.id}">${client.name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="projectsId">Select Project(s):</label> 
				<select
					class="form-control" name="projects" id="projectsId" multiple="multiple" >
					<c:forEach var="project" items="${listProjects}">
						<option value="${project.id}">${project.name}</option>
					</c:forEach>
				</select>
			</div>
			<button type="submit" class="btn btn-primary"
				onclick="return verify()">Submit</button>
		</form>

		<br>
		<div class="panel panel-primary panel-lg">
			<div class="panel-heading">
				Clients Projects&nbsp;<span class="badge"><c:if
						test="${listClients!=null}">${listClients.size()}</c:if></span>

			</div>
			<div class="panel-body">
				<c:if test="${!empty listClients}">
					<div class="table-responsive">
						<table class="table table-bordered table-hover table-striped"
							id="clientProjectsTable">
							<thead>
								<tr>
									<th>Client ID</th>
									<th>Client Name</th>
									<th>Projects</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listClients}" var="client">
									<tr>
										<td>${client.id}</td>
										<td>${client.name}</td>
										<td><c:if
												test="${client.projects!=null && client.projects.size()>0}">
												<c:forEach items="${client.projects}" var="project" varStatus="status">
                                                    ${project.name}
                                                <c:if test="${status.index+1 != client.projects.size()}">,</c:if>
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
			$('#clientProjectsTable').DataTable();
		});
		function verify() {
			if ($("#clientId").val() == "") {
				showMessage("Please Select Client", "warning");
				$("#clientId").focus();
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

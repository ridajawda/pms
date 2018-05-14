<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
</head>
<body>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-primary panel-lg">
					<div class="panel-heading">
						Projects&nbsp;<span class="badge"><c:if
								test="${projects!=null}">${projects.size()}</c:if></span>
						<button class="btn btn-xs btn-success pull-right"
							onclick="javascript:showProjectPopup('<c:url value='/project/showProjectPopup' />')">Add project</button>
					</div>
					<div class="panel-body">
						<c:if test="${!empty projects}">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped"
									id="projectTable">
									<thead>
										<tr>
											<th>Project Type</th>
											<th>Project Name</th>
											<th>Description</th>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Cost</th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${projects}" var="project">
											<tr >
												<td>${project.projectType}</td>
												<td>${project.name}</td>
												<td>${project.description}</td>
												<td><fmt:formatDate value="${project.startDate}"
														pattern="dd-MM-yyyy" /></td>
												<td><fmt:formatDate value="${project.endDate}"
														pattern="dd-MM-yyyy" /></td>
												<td>${project.cost}</td>
												<td><a
													href="javascript:updateProject('<c:url value='/project/update/${project.id}' />')">
														<span class="glyphicon glyphicon-edit" title="edit"></span>
												</a></td>
												<td><a
													href="<c:url value='/project/delete/${project.id}' />">
														<span class="glyphicon glyphicon-remove text-danger"
														title="Remove"></span>
												</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div id="projectModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">project Form</h4>
				</div>
				<div class="modal-body">
					<div id="proAddPopupId">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('#projectTable').DataTable();
		});
		function saveProject() {
			if ($("#projectType").val() == "") {
				showMessage("Please Enter Project Type", "warning");
				$("#projectType").focus();
				return false;
			} else if ($("#projectName").val() == "") {
				showMessage("Please Enter Project Name", "warning");
				$("#projectName").focus();
				return false;
			} else if ($("#description").val() == "") {
				showMessage("Please Enter Description", "warning");
				$("#description").focus();
				return false;
			} else if ($("#startDate").val() == "") {
				showMessage("Please Select Start Date", "warning");
				$("#startDate").focus();
				return false;
			} else if ($("#endDate").val() == "") {
				showMessage("Please Select End Date", "warning");
				$("#endDate").focus();
				return false;
			} else if ($("#cost").val() == "") {
				showMessage("Please Enter Cost", "warning");
				$("#cost").focus();
				return false;
			}  else {
				$.ajax({
					url : $("#projectFormId").attr("action"),
					type : 'post',
					data : $("#projectFormId").serialize(),
					success : function(data) {
						alert(data);
						$("#projectFormId")[0].reset();
						window.location.reload();
					},
					error : function() {
						alert("Unable to load details.");
					}
				});
			}
		}

		function showProjectPopup(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#proAddPopupId").html(data);
					$('#projectModal').modal('show');
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}

		function updateProject(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#proAddPopupId").html(data);
					$('#projectModal').modal('show');
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}

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
	</script>
</body>
</html>

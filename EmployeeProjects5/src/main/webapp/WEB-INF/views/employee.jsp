<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>Employees</title>
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
			<div class="col-sm-22">
				<div class="panel panel-primary panel-lg">
					<div class="panel-heading">
						Employees&nbsp;<span class="badge"><c:if
								test="${employees!=null}">${employees.size()}</c:if></span>
						<button class="btn btn-xs btn-success pull-right"
							onclick="javascript:showEmpPopup('<c:url value='/employee/showEmpPopup' />')">Add
							Employee</button>
					</div>
					<div class="panel-body">
						<c:if test="${!empty employees}">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped"
									id="employeeTable">
									<thead>
										<tr>
											<th>First Name</th>
											<th>Last Name</th>
											<th>Email</th>
											<th>DOB</th>
											<th>Hiring Date</th>
											<th>Termination Date</th>
											<th>Telephone</th>
											<th>Job Title</th>
											<th>Manager</th>
											<th></th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${employees}" var="employee">
											<tr>
												<td>${employee.firstName}</td>
												<td>${employee.lastName}</td>
												<td>${employee.email}</td>
												<td><fmt:formatDate value="${employee.dob}"
														pattern="dd-MM-yyyy" /></td>
												<td><fmt:formatDate value="${employee.hiringDate}"
														pattern="dd-MM-yyyy" /></td>
												<td><fmt:formatDate value="${employee.terminationDate}"
														pattern="dd-MM-yyyy" /></td>
												<td>${employee.telephone}</td>
												<td>${employee.jobTitle}</td>
												<td>${employee.manager.firstName}
													${employee.manager.lastName}</td>
												<td><a
													href="javascript:updateEmloyee('<c:url value='/employee/update/${employee.id}' />')">
														<span class="glyphicon glyphicon-edit" title="edit"></span>
												</a></td>
												<td><a
													href="<c:url value='/employee/delete/${employee.id}' />">
														<span class="glyphicon glyphicon-remove text-danger"
														title="Remove"></span>
												</a></td>
												<td><a
													href="javascript:showEmpInfoPopup('<c:url value='/employee/showEmpInfoPopup?employeeId=${employee.id}' />')">
														<span class="glyphicon glyphicon-user" title="Info"></span>
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
	<!-- Employee Form Modal Start -->
	<div id="empAddModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Employee Form</h4>
				</div>
				<div class="modal-body">
					<div id="empAddPopupId"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<!-- Employee Info Modal End -->
	<!-- Employee Form Modal Start -->
	<div id="empInfoModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Employee Info</h4>
				</div>
				<div class="modal-body">
					<div id="empInfoPopupId"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<!-- Employee Info Modal End -->
	<script>
		$(document).ready(function() {
			$('#employeeTable').DataTable();
		});
		function saveEmployee() {
			if ($("#firstName").val() == "") {
				showMessage("Please Enter First Name", "warning");
				$("#firstName").focus();
				return false;
			} else if ($("#lastName").val() == "") {
				showMessage("Please Enter Last Name", "warning");
				$("#lastName").focus();
				return false;
			} else if ($("#email").val() == "") {
				showMessage("Please Enter Email", "warning");
				$("#email").focus();
				return false;
			} else if ($("#dob").val() == "") {
				showMessage("Please Select Date Of Birth", "warning");
				$("#dob").focus();
				return false;
			} else if ($("#hiringDate").val() == "") {
				showMessage("Please Select Hiring Date", "warning");
				$("#hiringDate").focus();
				return false;
			} else if ($("#telephone").val() == "") {
				showMessage("Please Enter Telephone", "warning");
				$("#telephone").focus();
				return false;
			} else if ($("#jobTitle").val() == "") {
				showMessage("Please Enter Job Title", "warning");
				$("#jobTitle").focus();
				return false;
			}
			
			else {
				$.ajax({
					url : $("#employeeFormId").attr("action"),
					type : 'post',
					data : $("#employeeFormId").serialize(),
					success : function(data) {
						alert(data);
						$("#employeeFormId")[0].reset();
						window.location.reload();
					},
					error : function() {
						alert("Unable to load details.");
					}
				});
			}
		}

		function showEmpPopup(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#empAddPopupId").html(data);
					$('#empAddModal').modal('show');
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}
		
		function showEmpInfoPopup(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#empInfoPopupId").html(data);
					$('#empInfoModal').modal('show');
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}

		function updateEmloyee(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#empAddPopupId").html(data);
					$('#empAddModal').modal('show');
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

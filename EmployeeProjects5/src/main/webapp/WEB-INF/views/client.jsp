<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>Clients</title>
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
						Clients&nbsp;<span class="badge"><c:if
								test="${clients!=null}">${clients.size()}</c:if></span>
						<button class="btn btn-xs btn-success pull-right"
							onclick="javascript:showCliPopup('<c:url value='/client/showCliPopup' />')">Add
							Client</button>
					</div>


					<div class="panel-body">
						<c:if test="${!empty clients}">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped"
									id="clientTable">
									<thead>
										<tr>
											<th>Name</th>
											<th>Address</th>
											<th>Telephone</th>
											<th>Email</th>
											<th></th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${clients}" var="client">
											<tr>
												<td>${client.name}</td>
												<td>${client.address}</td>
												<td>${client.telephone}</td>
												<td>${client.email}</td>
												<td><a
													href="javascript:updateClient('<c:url value='client/update/${client.id}' />')">
														<span class="glyphicon glyphicon-edit" title="edit"></span>
												</a></td>
												<td><a
													href="<c:url value='/client/delete/${client.id}' />"> <span
														class="glyphicon glyphicon-remove text-danger"
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
	<!-- Client Form Modal Start -->
	<div id="cliAddModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Client Form</h4>
				</div>
				<div class="modal-body">
					<div id="cliAddPopupId"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('#clientTable').DataTable();
		});
		function saveClient() {
			if ($("#name").val() == "") {
				showMessage("Please Enter Name", "warning");
				$("#name").focus();
				return false;
				} else if ($("#telephone").val() == "") {
				showMessage("Please Enter Telephone", "warning");
				$("#telephone").focus();
				return false;
				} else if ($("#address").val() == "") {
					showMessage("Please Enter Telephone", "warning");
					$("#address").focus();
					return false;
				} else if ($("#email").val() == "") {
				showMessage("Please Enter Email", "warning");
				$("#email").focus();
					return false;
				} 
				
				else {
				     $.ajax({
					url : $("#clientFormId").attr("action"),
					type : 'post',
					data : $("#clientFormId").serialize(),
					success : function(data) {
						alert(data);
						$("#clientFormId")[0].reset();
						window.location.reload();
					},
					error : function() {
						alert("Unable to load details.");
					}
				});
			}
		}

		function showCliPopup(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#cliAddPopupId").html(data);
					$('#cliAddModal').modal('show');
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}
		
		function updateClient(serverUrl) {
			$.ajax({
				url : serverUrl,
				type : 'get',
				success : function(data) {
					$("#cliAddPopupId").html(data);
					$('#cliAddModal').modal('show');
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

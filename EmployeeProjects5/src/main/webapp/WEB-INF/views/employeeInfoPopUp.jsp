<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<div class="row">
	<div class="col-sm-12">
		<c:url var="addAction" value="/employee/info/add"></c:url>
		<form action="${addAction}" id="employeeInfoFormId">
			<input type="hidden" name="id" value="${empInfo.id}" id="">
			<input type="hidden" name="employeeId"
				value="${employee.id}">
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label for="firstName">Username:</label> <input type="text"
							class="form-control" id="userName" name="userName"
							value="${employee.empInfo.userName}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="lastName">Password:</label> <input type="password"
							class="form-control" id="password" name="password"
							value="${employee.empInfo.password}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="email">Role:</label> <input type="text"
							class="form-control" id="role" name="role"
							value="${employee.empInfo.role}">
					</div>
				</div>
			</div>
			<div class="row">

				<div class="col-sm-4">
					<div class="form-group">
						<label for="salary">Salary:</label> <input type="text"
							class="form-control" id="salary" name="salary"
							value="${employee.empInfo.salary}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="evaluation">Evaluation:</label> <input type="text"
							class="form-control" id="evaluation" name="evaluation"
							value="${employee.empInfo.evaluation}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="scn">SCN:</label> <input type="text"
							class="form-control" id="scn" name="scn"
							value="${employee.empInfo.scn}">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<button type="button" class="btn btn-success"
						onclick="saveEmployeeInfo()">
						<c:if test="${employee.empInfo==null}">
						Save</c:if>
						<c:if test="${employee.empInfo!=null && employee.empInfo.id!=0}">
						Update
						</c:if>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	$(document).ready(function() {
		$("#userName").focus();
	});

	function saveEmployeeInfo() {
		if ($("#userName").val() == "") {
			showMessage("Please Enter Username", "warning");
			$("#userName").focus();
			return false;
		} else if ($("#password").val() == "") {
			showMessage("Please Enter Password", "warning");
			$("#password").focus();
			return false;
		} else if ($("#role").val() == "") {
			showMessage("Please Enter Role", "warning");
			$("#role").focus();
			return false;
		} else if ($("#salary").val() == "") {
			showMessage("Please Enter Salary", "warning");
			$("#salary").focus();
			return false;
		} else if ($("#evaluation").val() == "") {
			showMessage("Please Enter Evaluation", "warning");
			$("#evaluation").focus();
			return false;
		} else if ($("#scn").val() == "") {
			showMessage("Please Enter Scn", "warning");
			$("#scn").focus();
			return false;
		} else {
			$.ajax({
				url : $("#employeeInfoFormId").attr("action"),
				type : 'post',
				data : $("#employeeInfoFormId").serialize(),
				success : function(data) {
					alert(data);
					$("#employeeInfoFormId")[0].reset();
					window.location.reload();
				},
				error : function() {
					alert("Unable to load details.");
				}
			});
		}
	}
</script>
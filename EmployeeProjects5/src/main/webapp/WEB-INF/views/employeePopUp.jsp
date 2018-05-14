<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<div class="row">
	<div class="col-sm-12">
		<c:url var="addAction" value="/employee/add"></c:url>
		<form action="${addAction}" id="employeeFormId">
			<input type="hidden" name="id" value="${employee.id}"
				id="hiddenEmpVal">
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label for="firstName">First name:</label> <input type="text"
							class="form-control" id="firstName" name="firstName"
							value="${employee.firstName}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="lastName">Last Name:</label> <input type="text"
							class="form-control" id="lastName" name="lastName"
							value="${employee.lastName}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="email">Email:</label> <input type="email"
							class="form-control" id="email" name="email"
							value="${employee.email}">
					</div>
				</div>
			</div>
			<div class="row">

				<div class="col-sm-4">
					<div class="form-group">
						<label for="dob">Date Of Birth:</label> <input type="text"
							class="form-control" id="dob" name="dob" placeholder="dd-mm-yyyy"
							value="<fmt:formatDate value="${employee.dob}" pattern="dd-MM-yyyy"/>">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="hiringDate">Hiring Date:</label> <input type="text"
							class="form-control" id="hiringDate" name="hiringDate"
							placeholder="dd-mm-yyyy"
							value="<fmt:formatDate value="${employee.hiringDate}" pattern="dd-MM-yyyy"/>">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="terminationDate">Termination Date:</label> <input
							type="text" class="form-control" id="terminationDate"
							name="terminationDate" placeholder="dd-mm-yyyy"
							value="<fmt:formatDate value="${employee.terminationDate}" pattern="dd-MM-yyyy"/>">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label for="telephone">Telephone Number:</label> <input
							type="text" class="form-control" id="telephone" name="telephone"
							value="${employee.telephone}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="jobTitle">Job Title:</label> <input type="text"
							class="form-control" id="jobTitle" name="jobTitle"
							value="${employee.jobTitle}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="manager">Manager:</label> <select class="form-control"
							id="manager" name="managerId">
							<option value="">Select Manager</option>
							<c:forEach var="employee" items="${employees}">
								<option value="${employee.id}">${employee.firstName}
									${employee.lastName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<button type="button" class="btn btn-success"
						onclick="saveEmployee()">
						<c:if test="${employee.id==0}">
						Save</c:if>
						<c:if test="${employee.id!=0}">
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
		$("#firstName").focus();
		$("#dob").datepicker({
			format : 'dd-mm-yyyy'
		});
		$("#hiringDate").datepicker({
			format : 'dd-mm-yyyy'
		});
		$("#terminationDate").datepicker({
			format : 'dd-mm-yyyy'
		});
	});
</script>
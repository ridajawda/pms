<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<div class="row">
	<div class="col-sm-12">
		<c:url var="addAction" value="/consultant/add"></c:url>
		<form action="${addAction}" id="consultantFormId">
			<input type="hidden" name="id" value="${consultant.id}" id="hiddenCliVal">
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label for="name">Name:</label> <input type="text"
							class="form-control" id="name" name="name"
							value="${consultant.name}">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="telephone">Telephone Number:</label> <input
							type="text" class="form-control" id="telephone" name="telephone"
							value="${consultant.telephone}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="email">Email:</label> <input type="email"
							class="form-control" id="email" name="email"
							value="${consultant.email}">
					</div>
				</div>
			</div>

			<div class="row">

				<div class="col-sm-4">
					<div class="form-group">
						<label for="Address">Address:</label> <input type="text"
							class="form-control" id="Address" name="Address"
							value="${consultant.address}">
					</div>
				</div>



			</div>
			<div class="row">
				<div class="col-sm-4">
					<button type="button" class="btn btn-success"
						onclick="saveConsultant()">
						<c:if test="${consultant.id==0}">
						Save</c:if>
						<c:if test="${consultant.id!=0}">
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
		$("#name").focus();
		$("#address").focus();
		$("#telephone").focus();
		$("#email").focus();
		
	});
</script>
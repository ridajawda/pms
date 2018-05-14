<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<div class="row">
	<div class="col-sm-12">
		<c:url var="addAction" value="/project/add"></c:url>
		<form action="${addAction}" id="projectFormId">
			<input type="hidden" name="id" value="${project.id}">
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label for="projectType">Project Type:</label> <input type="text"
							class="form-control" id="projectType" name="projectType"
							value="${project.projectType}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="name">Project Name:</label> <input type="text"
							class="form-control" id="name" name="name"
							value="${project.name}">
					</div>
				</div>

				<div class="col-sm-6">
					<div class="form-group">
						<label for="description">Description:</label> <input type="text"
							class="form-control" id="description" name="description"
							value="${project.description}">
					</div>
				</div>
			</div>
			<div class="row">

				<div class="col-sm-4">
					<div class="form-group">
						<label for="startDate">Start Date:</label> <input type="text"
							class="form-control" id="startDate" name="startDate"
							placeholder="dd-mm-yyyy"
							value="<fmt:formatDate value="${project.startDate}" pattern="dd-MM-yyyy"/>">
					</div>
				</div>

				<div class="col-sm-4">
					<div class="form-group">
						<label for="endDate">End Date:</label> <input type="text"
							class="form-control" id="endDate" name="endDate"
							placeholder="dd-mm-yyyy"
							value="<fmt:formatDate value="${project.endDate}" pattern="dd-MM-yyyy"/>">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="cost">Cost</label> <input type="text"
							class="form-control" id="cost" name="cost"
							value="${project.cost}">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<button type="button" class="btn btn-success"
						onclick="saveProject()">
						<c:if test="${project.id==0}">
						Save</c:if>
						<c:if test="${project.id>0}">
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
		$("#projectType").focus();
		$("#startDate").datepicker({
			format : 'dd-mm-yyyy'
		});
		$("#endDate").datepicker({
			format : 'dd-mm-yyyy'
		});
	});
</script>
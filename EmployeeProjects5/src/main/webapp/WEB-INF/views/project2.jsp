<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
<title>Project Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#projectNameId").focus();
	});
</script>
</head>
<body>
	<div class="container">
		<h1>Add Project</h1>

		<c:url var="addAction" value="/project/add"></c:url>
		<form:form action="${addAction}" commandName="employee"
			cssClass="form-inline">
			<c:if test="${!empty project.name}">
				<div class="form-group">
					<label for="id">Id:</label> <input type="text"
						value="${project.id }" readonly="readonly" class="form-control"
						id="id"> <input type="hidden" name="id"
						value="${project.id}">
				</div>
			</c:if>
			<div class="form-group">
				<label for="projectNameId">Project Name:</label> <input type="text"
					value="${project.name}" class="form-control" id="projectNameId"
					placeholder="Enter project name" name="name">
			</div>

			<button type="submit" class="btn btn-primary">
				<c:choose>
					<c:when test="${!empty project.name}">  
Update    </c:when>

					<c:otherwise>  
Save    </c:otherwise>
				</c:choose>
			</button>
		</form:form>
		<br>
		<h3>Projects List</h3>
		<c:if test="${!empty listProjects}">
			<table class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>Project ID</th>
						<th>Project Name</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listProjects}" var="project">
						<tr>
							<td>${project.id}</td>
							<td>${project.name}</td>
							<td><a href="<c:url value='/project/update/${project.id}' />">Update</a></td>
							<td><a
								href="<c:url value='/project/delete/${project.id}' />">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>

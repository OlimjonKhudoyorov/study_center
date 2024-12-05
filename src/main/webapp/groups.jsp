<%@ page import="uz.code.modul.Groups" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.code.repository.GroupsRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <title>Group Management</title>
</head>
<body class="bg-light">

<%
    String moduleIdParam = request.getParameter("moduleId");
    List<Groups> groups = null;

    if (moduleIdParam != null && !moduleIdParam.isEmpty()) {
        int moduleId = Integer.parseInt(moduleIdParam);
        groups = GroupsRepository.getGroupsByModuleId(moduleId);
    }
%>

<div class="container py-5">
    <h1 class="text-center mb-4">Group Management</h1>

    <form action="/group/add" method="post" class="mb-4 p-4 border rounded shadow-sm bg-white">
        <div class="mb-3">
            <label for="groupName" class="form-label">Module Name</label>
            <input type="text" id="groupName" name="name" class="form-control" placeholder="Enter group name"
                   required>
        </div>
        <input type="hidden" name="moduleId" value="<%= moduleIdParam %>">
        <button type="submit" class="btn btn-success w-100">Add Group</button>
    </form>

    <table class="table table-bordered table-striped shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Group Name</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (groups != null && !groups.isEmpty()) {
                for (Groups group : groups) {
        %>
        <tr>
            <td><%= group.getId() %>
            </td>
            <td><%= group.getName() %>
            </td>
            <td>
                <form action="/students.jsp" method="get">
                    <input type="hidden" name="groupsId" value="<%=group.getId()%>">
                    <button class="btn btn-warning btn-sm">Go to Student Management</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="2" class="text-center">No groups found.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoA2uH8z9DPw4soMjV81hYIcnRpCQuJO4nLT9KEHi3m9g9Q"
        crossorigin="anonymous"></script>

</body>
</html>
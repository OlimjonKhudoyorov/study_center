<%@ page import="uz.code.modul.Modules" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.code.repository.ModulesRepository" %>
<%@ page import="uz.code.repository.CoursesRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <title>Module Management</title>
</head>
<body class="bg-light">

<%
    String courseIdParam = request.getParameter("courseId");
    List<Modules> modules = null;

    if (courseIdParam != null && !courseIdParam.isEmpty()) {
        int courseId = Integer.parseInt(courseIdParam);
        modules = ModulesRepository.getModulesByCourseId(courseId);
    }
%>

<div class="container py-5">
    <h1 class="text-center mb-4">Module Management</h1>

    <form action="/module/add" method="post" class="mb-4 p-4 border rounded shadow-sm bg-white">
        <div class="mb-3">
            <label for="moduleName" class="form-label">Module Name</label>
            <input type="text" id="moduleName" name="name" class="form-control" placeholder="Enter module name"
                   required>
        </div>
        <input type="hidden" name="courseId" value="<%= courseIdParam %>">
        <button type="submit" class="btn btn-success w-100">Add Module</button>
    </form>

    <table class="table table-bordered table-striped shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (modules != null && !modules.isEmpty()) {
                for (Modules module : modules) {
        %>
        <tr>
            <td><%= module.getId() %>
            </td>
            <td><%= module.getName() %>
            </td>
            <td>
                <form action="/groups.jsp" method="get">
                    <input type="hidden" name="moduleId" value="<%=module.getId()%>">
                    <button class="btn btn-warning btn-sm">Go to Group Management</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3" class="text-center">No modules found.</td>
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
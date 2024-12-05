<%@ page import="uz.code.modul.Courses" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.code.repository.CoursesRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Course Management</title>
</head>
<body class="bg-light">
<%
    List<Courses> courses = CoursesRepository.getAllCourses();
%>
<div class="container py-5">
    <h1 class="text-center mb-4">Course Management</h1>

    <form action="/course/add" method="post" class="mb-4 p-4 border rounded shadow-sm bg-white">
        <div class="mb-3">
            <label for="courseName" class="form-label">Course Name</label>
            <input type="text" id="courseName" name="name" class="form-control" placeholder="Enter course name"
                   required>
        </div>
        <button type="submit" name="submit" class="btn btn-success w-100">Add Course</button>
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
            for (Courses course : courses) {
        %>
        <tr>
            <td><%=course.getId()%>
            </td>
            <td><%=course.getName()%>
            </td>
            <td>
                <form action="/modules.jsp" method="get">
                    <input type="hidden" name="courseId" value="<%=course.getId()%>">
                    <button class="btn btn-warning btn-sm">Go to Module Management</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="text-center mt-4">
        <a href="/report.jsp" class="btn btn-primary">Go to Report</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoA2uH8z9DPw4soMjV81hYIcnRpCQuJO4nLT9KEHi3m9g9Q"
        crossorigin="anonymous"></script>
</body>
</html>
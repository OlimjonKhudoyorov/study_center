<%@ page import="uz.code.modul.Students" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.code.repository.StudentsRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <title>Student Management</title>
</head>
<body class="bg-light">

<%
    String groupIdParam = request.getParameter("groupsId");
    List<Students> students = null;

    if (groupIdParam != null && !groupIdParam.isEmpty()) {
        int groupId = Integer.parseInt(groupIdParam);
        students = StudentsRepository.getStudentsByGroupId(groupId);
    }
%>

<div class="container py-5">
    <h1 class="text-center mb-4">Student Management</h1>

    <form action="/student/add" method="post" class="mb-4 p-4 border rounded shadow-sm bg-white">
        <div class="mb-3">
            <label for="studentName" class="form-label">Student Name</label>
            <input type="text" id="studentName" name="name" class="form-control" placeholder="Enter student name"
                   required>
        </div>
        <input type="hidden" name="groupId" value="<%= groupIdParam %>">
        <button type="submit" class="btn btn-success w-100">Add Student</button>
    </form>

    <table class="table table-bordered table-striped shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Total Payment</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (students != null && !students.isEmpty()) {
                for (Students student : students) {
                    double totalPayment = student.getTotalPayment();
        %>
        <tr>
            <td><%= student.getId() %>
            </td>
            <td><%= student.getName() %>
            </td>
            <td><%= totalPayment %>
            </td>
            <td>
                <a href="/payments.jsp?studentId=<%= student.getId() %>" class="btn btn-success btn-sm">+ Add
                    Payment</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center">No students found.</td>
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
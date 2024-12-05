<%@ page import="java.util.List" %>
<%@ page import="uz.code.repository.ReportRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Course Report</title>
</head>
<body class="bg-light">

<%
    List<Object[]> reportData = ReportRepository.getCourseReportDirectly();
%>

<div class="container py-5">
    <h1 class="text-center mb-4">Courses Report</h1>

    <table class="table table-bordered table-striped shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Course Name</th>
            <th scope="col">Student Count</th>
            <th scope="col">Total Payments</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (reportData != null && !reportData.isEmpty()) {
                for (Object[] row : reportData) {
        %>
        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td><%= row[2] %></td>
            <td><%= row[3] %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center">No report data available.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="text-center mt-4">
        <a href="/courses.jsp" class="btn btn-primary">Back to Courses Management</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoA2uH8z9DPw4soMjV81hYIcnRpCQuJO4nLT9KEHi3m9g9Q"
        crossorigin="anonymous"></script>
</body>
</html>
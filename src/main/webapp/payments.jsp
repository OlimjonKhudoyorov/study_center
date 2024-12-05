<%@ page import="uz.code.modul.Students" %>
<%@ page import="uz.code.modul.Payments" %>
<%@ page import="uz.code.repository.StudentsRepository" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <title>Payment Management</title>
</head>
<body class="bg-light">

<%
    String studentIdParam = request.getParameter("studentId");
    Students student = null;
    List<Payments> payments = null;

    if (studentIdParam != null && !studentIdParam.isEmpty()) {
        int studentId = Integer.parseInt(studentIdParam);
        student = StudentsRepository.getStudentById(studentId);
        payments = StudentsRepository.getPaymentsByStudentId(studentId);
    }

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>

<div class="container py-5">
    <h1 class="text-center mb-4">Payment Management</h1>

    <form action="/payment/add" method="post" class="mb-4 p-4 border rounded shadow-sm bg-white">
        <div class="mb-3">
            <label for="amount" class="form-label">Payment Amount</label>
            <input type="text" id="amount" name="amount" class="form-control" placeholder="Enter payment amount"
                   required>
        </div>
        <input type="hidden" name="studentId" value="<%= student != null ? student.getId() : "" %>">
        <button type="submit" class="btn btn-success w-100">Add Payment</button>
    </form>

    <table class="table table-bordered table-striped shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Amount</th>
            <th scope="col">Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (payments != null) {
                for (Payments payment : payments) {
                    String formattedDate = payment.getPaymentDate().format(formatter);
        %>
        <tr>
            <td><%= payment.getId() %>
            </td>
            <td><%= payment.getAmount() %>
            </td>
            <td><%= formattedDate %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3" class="text-center">No payments found.</td>
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
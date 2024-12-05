<%@ page import="uz.code.repository.PaymentsRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String studentIdParam = request.getParameter("studentId");
    String amountParam = request.getParameter("amount");

    if (studentIdParam != null && amountParam != null) {
        try {
            int studentId = Integer.parseInt(studentIdParam);
            double amount = Double.parseDouble(amountParam);
            PaymentsRepository.addPayment(studentId, amount);

            response.sendRedirect("students.jsp?groupsId=" + request.getParameter("groupsId"));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
%>
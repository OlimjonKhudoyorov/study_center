package uz.code.servlet;

import jakarta.persistence.EntityManager;
import uz.code.modul.Payments;
import uz.code.modul.Students;
import uz.code.repository.StudentsRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static uz.code.MyListener.EMF;

@WebServlet("/payment/add")
public class AddPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentIdParam = req.getParameter("studentId");
        String amountParam = req.getParameter("amount");

        if (studentIdParam == null || studentIdParam.isEmpty() || amountParam == null || amountParam.isEmpty()) {
            resp.getWriter().write("Student ID or Amount is missing");
            return;
        }

        try {
            int studentId = Integer.parseInt(studentIdParam);
            double amount = Double.parseDouble(amountParam);

            Students student = StudentsRepository.getStudentById(studentId);
            if (student == null) {
                resp.getWriter().write("Student not found");
                return;
            }

            Payments payment = new Payments(amount, student);

            try (EntityManager entityManager = EMF.createEntityManager()) {
                entityManager.getTransaction().begin();
                entityManager.persist(payment);
                entityManager.getTransaction().commit();
            }

            resp.sendRedirect("/payments.jsp?studentId=" + studentId);

        } catch (NumberFormatException e) {
            resp.getWriter().write("Invalid format for student ID or amount");
        } catch (Exception e) {
            resp.getWriter().write("An error occurred while adding the payment");
        }
    }
}
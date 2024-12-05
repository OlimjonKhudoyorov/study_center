package uz.code.servlet;

import jakarta.persistence.EntityManager;
import uz.code.modul.Courses;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static uz.code.MyListener.EMF;

@WebServlet("/course/add")
public class AddCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            String name = req.getParameter("name");
            Courses courses = new Courses(name);
            entityManager.getTransaction().begin();
            entityManager.persist(courses);
            entityManager.getTransaction().commit();
            resp.sendRedirect("/courses.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

package uz.code.servlet;

import jakarta.persistence.EntityManager;
import uz.code.modul.Courses;
import uz.code.modul.Modules;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static uz.code.MyListener.EMF;

@WebServlet("/module/add")
public class AddModuleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            String name = req.getParameter("name");
            String courseId = req.getParameter("courseId");
            if (courseId == null || courseId.isEmpty()) {
                resp.getWriter().write("Invalid Course ID format");
                return;
            }

            int coursesId = Integer.parseInt(courseId);
            Courses course = entityManager.find(Courses.class, coursesId);
            if (course == null) {
                resp.getWriter().write("Course not found");
                return;
            }

            entityManager.getTransaction().begin();
            Modules module = new Modules(
                    name,
                    course);
            entityManager.persist(module);
            entityManager.getTransaction().commit();
            resp.sendRedirect("/modules.jsp?courseId=" + coursesId);
        } catch (NumberFormatException e) {
            resp.getWriter().write("Invalid Course ID format");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
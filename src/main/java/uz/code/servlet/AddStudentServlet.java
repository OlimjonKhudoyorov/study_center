package uz.code.servlet;

import jakarta.persistence.EntityManager;
import uz.code.modul.Groups;
import uz.code.modul.Students;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static uz.code.MyListener.EMF;

@WebServlet("/student/add")
public class AddStudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            String name = req.getParameter("name");
            String groupId = req.getParameter("groupId");

            int coursesId = Integer.parseInt(groupId);
            Groups groups = entityManager.find(Groups.class, coursesId);
            if (groups == null) {
                resp.getWriter().write("Group not found");
                return;
            }
            entityManager.getTransaction().begin();

            Students student = new Students(name, groups);
            entityManager.persist(student);
            entityManager.getTransaction().commit();
            resp.sendRedirect("/students.jsp?groupsId=" + groupId);
        } catch (NumberFormatException e) {
            resp.getWriter().write("Invalid Group ID format");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
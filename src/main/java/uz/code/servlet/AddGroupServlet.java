package uz.code.servlet;

import jakarta.persistence.EntityManager;
import uz.code.modul.Groups;
import uz.code.modul.Modules;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static uz.code.MyListener.EMF;

@WebServlet("/group/add")
public class AddGroupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            String name = req.getParameter("name");
            String moduleId = req.getParameter("moduleId");
            if (moduleId == null || moduleId.isEmpty()) {
                resp.getWriter().write("Invalid Module ID format");
                return;
            }

            int modulesId = Integer.parseInt(moduleId);
            Modules modules = entityManager.find(Modules.class, modulesId);
            if (modules == null) {
                resp.getWriter().write("Module not found");
                return;
            }

            entityManager.getTransaction().begin();
            Groups module = new Groups(
                    null,
                    name,
                    modules);
            entityManager.persist(module);
            entityManager.getTransaction().commit();
            resp.sendRedirect("/groups.jsp?moduleId=" + modulesId);
        } catch (NumberFormatException e) {
            resp.getWriter().write("Invalid Module ID format");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

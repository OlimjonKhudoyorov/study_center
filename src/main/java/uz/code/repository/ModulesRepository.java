package uz.code.repository;

import jakarta.persistence.EntityManager;
import uz.code.modul.Modules;

import java.util.List;

import static uz.code.MyListener.EMF;

public class ModulesRepository {
    public static List<Modules> getModulesByCourseId(int courseId) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return entityManager
                    .createQuery("select m from Modules m where m.courses.id = :courses_id", Modules.class)
                    .setParameter("courses_id", courseId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

package uz.code.repository;

import jakarta.persistence.EntityManager;
import uz.code.modul.Courses;

import java.util.List;

import static uz.code.MyListener.EMF;

public class CoursesRepository {

    public static List<Courses> getAllCourses() {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return entityManager.createQuery("from Courses", Courses.class).getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
package uz.code.repository;

import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import uz.code.modul.Payments;
import uz.code.modul.Students;

import java.util.List;

import static uz.code.MyListener.EMF;

public class StudentsRepository {

    @Transactional
    public static List<Students> getStudentsByGroupId(int groupId) {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            String query = "select s from Students s "
                    + "left join fetch s.payments p "
                    + "where s.groups.id = :groupId";

            List<Students> students = entityManager.createQuery(query, Students.class)
                    .setParameter("groupId", groupId)
                    .getResultList();

            return students;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving students by group ID", e);
        }
    }

    public static Students getStudentById(int studentId) {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            return entityManager.find(Students.class, studentId);
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving student with ID => " + studentId, e);
        }
    }

    public static List<Payments> getPaymentsByStudentId(int studentId) {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            Students student = entityManager.find(Students.class, studentId);
            return student != null ? student.getPayments() : null;
        }
    }
}
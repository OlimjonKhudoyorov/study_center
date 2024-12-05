package uz.code.repository;

import jakarta.persistence.EntityManager;
import uz.code.modul.Payments;
import uz.code.modul.Students;

import static uz.code.MyListener.EMF;

public class PaymentsRepository {

    public static void addPayment(int studentId, Double amount) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            entityManager.getTransaction().begin();

            Students student = entityManager.find(Students.class, studentId);
            if (student != null) {
                Payments payment = new Payments();
                payment.setAmount(amount);
                payment.setStudents(student);

                entityManager.persist(payment);

                student.setTotalPayment(student.getTotalPayment() + amount);
                entityManager.merge(student);

                entityManager.getTransaction().commit();
            }
        } catch (Exception e) {
            throw new RuntimeException("Error while adding payment", e);
        }
    }
}
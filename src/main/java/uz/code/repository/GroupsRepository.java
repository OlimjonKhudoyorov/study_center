package uz.code.repository;

import jakarta.persistence.EntityManager;
import uz.code.modul.Groups;

import java.util.List;

import static uz.code.MyListener.EMF;

public class GroupsRepository {
    public static List<Groups> getGroupsByModuleId(int moduleId) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return entityManager
                    .createQuery("select g from Groups g where g.modules.id = :modules_id", Groups.class)
                    .setParameter("modules_id", moduleId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

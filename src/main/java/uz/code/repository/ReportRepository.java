package uz.code.repository;

import jakarta.persistence.EntityManager;

import java.util.List;

import static uz.code.MyListener.EMF;

public class ReportRepository {
    public static List<Object[]> getCourseReportDirectly() {
        EntityManager entityManager = EMF.createEntityManager();
        List<Object[]> results;

        try {
            String query = """
                    select g.modules.id as moduleId,
                           g.modules.name as moduleName,
                           count(s.id) as studentCount,
                           coalesce(sum(p.amount), 0) as totalPayments
                    from Groups g
                    left join Students s on s.groups.id = g.id
                    left join Payments p on p.students.id = s.id
                    group by g.modules.id, g.modules.name
                    """;

            results = entityManager.createQuery(query).getResultList();
        } finally {
            entityManager.close();
        }

        return results;
    }
}

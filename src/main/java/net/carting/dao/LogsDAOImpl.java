package net.carting.dao;

import org.springframework.stereotype.Repository;

import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Date;
import java.util.List;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
@Repository
public class LogsDAOImpl implements LogsDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List getAllLogs() {
        return entityManager.createQuery("from Logs").getResultList();
    }

    @Override
    public List getLogsByDate(Date date) {
        Query query = entityManager.createQuery("FROM Logs l WHERE l.date = :date");
        query.setParameter("date", date);
        return query.getResultList();
    }

    @Override
    public List getLogsByPeriod(Date start, Date end) {
        Query query = entityManager.createQuery("FROM Logs l WHERE l.date  >= :startDate AND l.date <= :endDate");
        query.setParameter("startDate", start);
        query.setParameter("endDate", end);
        return query.getResultList();
    }
}

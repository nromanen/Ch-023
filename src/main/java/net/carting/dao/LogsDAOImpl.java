package net.carting.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
@Repository
public class LogsDAOImpl implements LogsDAO {
    
    private static final Logger LOG = LoggerFactory.getLogger(LogsDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List getAllLogs() {
        LOG.debug("Get all logs from DB");
        return entityManager.createQuery("from Logs").getResultList();
    }

    @Override
    public List getLogsByDate(Date date) {
        Query query = entityManager.createQuery("FROM Logs l WHERE l.date = :date");
        query.setParameter("date", date);
        LOG.debug("Get all logs by date {}", date);
        return query.getResultList();
    }

    @Override
    public List getLogsByPeriod(Date start, Date end) {
        Query query = entityManager.createQuery("FROM Logs l WHERE l.date  >= :startDate AND l.date <= :endDate");
        query.setParameter("startDate", start);
        query.setParameter("endDate", end);
        LOG.debug("Get all logs for period(from = {}, to = {})", start, end);
        return query.getResultList();
    }
}

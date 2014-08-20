package net.carting.dao;

import net.carting.domain.Logs;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
    public List<Logs> getAllLogs() {
        List<Logs> logsList = entityManager.createQuery("from Logs").getResultList();
        return logsList;
    }
}

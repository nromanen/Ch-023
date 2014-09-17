package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Competition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class CompetitionDAOImpl implements CompetitionDAO {

    private static final Logger LOG = LoggerFactory.getLogger(CompetitionDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;


    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllCompetitions() {
        Query query = entityManager.createQuery("from Competition ORDER BY dateStart DESC");
        LOG.debug("Get all competitions");
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllEnabledCompetitions() {
        Query query = entityManager
                .createQuery("from Competition WHERE enabled = '1' ORDER BY dateStart DESC");
        LOG.debug("Get all enabled competitions");
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getCompetitionsByYear(int year) {
        Query query = entityManager
                .createQuery("from Competition WHERE YEAR(dateStart) = :year ORDER BY dateStart DESC");
        query.setParameter("year", year);
        LOG.debug("Get competitions by the year = {}", year);
        return query.getResultList();
    }


    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllCompetitionsByPage(int page, int competitionsPerPage) {
        Query query = entityManager
                .createQuery("from Competition ORDER BY dateStart DESC");
        query.setFirstResult((page - 1) * competitionsPerPage);
        query.setMaxResults(competitionsPerPage);
        return query.getResultList();
    }

    @Override
    public Competition getCompetitionById(int id) {
        Competition comp = entityManager.find(Competition.class, id);
        LOG.debug("Get competition with id = {}", id);
        return comp;
    }

    @Override
    public void addCompetition(Competition competition) {
        entityManager.persist(competition);
        LOG.debug("Add competition {}", competition);

    }

    @Override
    public void updateCompetition(Competition competition) {
        entityManager.merge(competition);
        LOG.debug("Updated competititon with id = {}", competition.getId());
    }

    @Override
    public void deleteCompetition(Competition competition) {
        Query query = entityManager.createNativeQuery(
                "DELETE FROM car_class_competition WHERE competition_id = :id");
        query.setParameter("id", competition.getId());
        query.executeUpdate();
        LOG.debug("Deleted all car class competitions with competition_id = {}", competition.getId());

        Competition c = entityManager.find(Competition.class, competition.getId());
        entityManager.remove(c);
        LOG.debug("Deleted competition with id = {}", competition.getId());
    }

    @Override
    public void setEnabled(int competitionId, boolean enabled) {
        Query query = entityManager.
                createQuery("UPDATE Competition SET enabled = :enabled "
                        + "WHERE id = :id");
        query.setParameter("enabled", enabled);
        query.setParameter("id", competitionId);
        query.executeUpdate();
        LOG.debug("Competition with id = {} is {}", competitionId, enabled ? "enabled" : "disabled");
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Integer> getCompetitionsYearsList() {
        Query query = entityManager
                .createQuery("SELECT YEAR(dateStart) FROM Competition "
                        + "GROUP BY YEAR(dateStart) "
                        + "ORDER BY YEAR(dateStart) ASC");
        LOG.debug("Get all competitions years ordered by desc");
        return query.getResultList();
    }
    
    @Override
    public long getCountOfCompetitions() {
        return  (long) entityManager.createQuery("SELECT COUNT(*) FROM Competition").getSingleResult();
    }

}

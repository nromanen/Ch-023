package net.carting.dao;

import net.carting.domain.Competition;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class CompetitionDAOImpl implements CompetitionDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    public static final int COMPETITION_PER_PAGE = 1;

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllCompetitions() {

        Query query = entityManager.createQuery("from Competition ORDER BY dateStart DESC");
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllEnabledCompetitions() {
        Query query = entityManager
                .createQuery("from Competition WHERE enabled = '1' ORDER BY dateStart DESC");
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getCompetitionsByYear(int year) {
        Query query = entityManager
                .createQuery("from Competition WHERE YEAR(dateStart) = :year ORDER BY dateStart DESC");
        query.setParameter("year", year);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Competition> getAllCompetitionsByPage(int page) {
        Query query = entityManager
                .createQuery("from Competition ORDER BY dateStart DESC");
        query.setFirstResult((page - 1) * COMPETITION_PER_PAGE);
        query.setMaxResults(COMPETITION_PER_PAGE);
        return query.getResultList();
    }

    @Override
    public Competition getCompetitionById(int id) {
        return (Competition) entityManager.createQuery("from Competition where id = :id")
                .setParameter("id", id).getResultList().get(0);
    }

    @Override
    public void addCompetition(Competition competition) {
        entityManager.persist(competition);

    }

    @Override
    public void updateCompetition(Competition competition) {
        entityManager.merge(competition);

    }

    @Override
    public void deleteCompetition(Competition competition) {
        Query query = entityManager.createQuery(
                "DELETE FROM Competition c WHERE c.id = :id");
        query.setParameter("id", competition.getId());
        query.executeUpdate();
    }

    @Override
    public void setEnabled(int competitionId, boolean enabled) {
        Query query = entityManager.
                createQuery("UPDATE Competition SET enabled = :enabled "
                        + "WHERE id = :id");
        query.setParameter("enabled", enabled);
        query.setParameter("id", competitionId);
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Integer> getCompetitionsYearsList() {
        Query query = entityManager
                .createQuery("SELECT YEAR(dateStart) FROM Competition "
                        + "GROUP BY YEAR(dateStart) "
                        + "ORDER BY YEAR(dateStart) DESC");

        return query.getResultList();
    }

}

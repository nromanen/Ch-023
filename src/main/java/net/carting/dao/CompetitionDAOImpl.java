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

    @Override
    public List<Competition> getAllCompetitions() {

        Query query = entityManager.createQuery("from Competition ORDER BY dateStart DESC");
        List<Competition> competitions = query.getResultList();

        return competitions;
    }

    @Override
    public List<Competition> getAllEnabledCompetitions() {
        Query query = entityManager
                .createQuery("from Competition WHERE enabled = '1' ORDER BY dateStart DESC");
        List<Competition> competitions = query.getResultList();

        return competitions;
    }

    @Override
    public List<Competition> getCompetitionsByYear(int year) {
        Query query = entityManager
                .createQuery("from Competition WHERE YEAR(dateStart) = :year ORDER BY dateStart DESC");
        query.setParameter("year", year);
        List<Competition> competitions = query.getResultList();
        return competitions;
    }

    @Override
    public List<Competition> getAllCompetitionsByPage(int page) {
        Query query = entityManager
                .createQuery("from Competition ORDER BY dateStart DESC");
        query.setFirstResult((page - 1) * COMPETITION_PER_PAGE);
        query.setMaxResults(COMPETITION_PER_PAGE);
        List<Competition> competitions = query.getResultList();

        return competitions;
    }

    @Override
    public Competition getCompetitionById(int id) {
        Competition competition = (Competition) entityManager.createQuery("from Competition where id = :id")
                .setParameter("id", id).getResultList().get(0);

        return competition;
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
        entityManager.remove(competition);

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

    @Override
    public List<Integer> getCompetitionsYearsList() {
        Query query = entityManager
                .createQuery("SELECT YEAR(dateStart) FROM Competition "
                        + "GROUP BY YEAR(dateStart) "
                        + "ORDER BY YEAR(dateStart) DESC");
        List<Integer> competitions = query.getResultList();

        return competitions;
    }

}

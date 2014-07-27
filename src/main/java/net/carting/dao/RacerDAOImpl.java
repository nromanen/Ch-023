package net.carting.dao;

import net.carting.domain.Racer;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.Date;
import java.util.List;

@Repository
public class RacerDAOImpl implements RacerDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getAllRacers() {
        List<Racer> racers = entityManager.createQuery("from Racer").getResultList();

        return racers;
    }

    @Override
    public Racer getRacerById(int id) {
        Racer racer = (Racer) entityManager
                .createQuery("from Racer where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);

        return racer;
    }

    @Override
    public void addRacer(Racer racer) {
        entityManager.persist(racer);

    }

    @Override
    public void updateRacer(Racer racer) {
        entityManager.merge(racer);

    }

    @Override
    public void deleteRacer(Racer racer) {
        entityManager.remove(racer);

    }

    @Override
    public boolean isSetRacer(String firstName, String lastName, Date birthday) {
        String hql = "from Racer r where r.firstName=? and r.lastName=? and r.birthday=?";
        Query query = entityManager.createQuery(hql)
                .setParameter(0, firstName)
                .setParameter(1, lastName)
                .setParameter(2, birthday);

        List result = query.getResultList();

        return result.size() > 0;
    }

    @Override
    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType) {
        String hql = "SELECT racer FROM Racer racer JOIN racer.documents document WHERE document.type = :documentType";
        Query query = entityManager.createQuery(hql);
        query.setParameter("documentType", documentType);
        List<Racer> racers = query.getResultList();

        return racers;
    }

}

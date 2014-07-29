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
        return entityManager.createQuery("from Racer").getResultList();
    }

    @Override
    public Racer getRacerById(int id) {
        return (Racer) entityManager
                .createQuery("from Racer where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
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
        //TODO: do not works - Cannot delete or update a parent row: a foreign key constraint fails
        try {

            Racer r = entityManager.getReference(Racer.class, racer.getId());
          //  entityManager.refresh(r);
            entityManager.remove(r);
            /*Racer r = entityManager.find(Racer.class, racer.getId());
            entityManager.remove(r);
            entityManager.merge(r);
            */
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*Query query = entityManager.createQuery(
                "DELETE FROM Racer c WHERE c.id = :id");
        query.setParameter("id", racer.getId());
        query.executeUpdate();*/
    }

    @Override
    public boolean isSetRacer(String firstName, String lastName, Date birthday) {
        String hql = "from Racer r where r.firstName= :firstName and r.lastName= :lastName and r.birthday= :birthday";
        Query query = entityManager.createQuery(hql)
                .setParameter("firstName", firstName)
                .setParameter("lastName", lastName)
                .setParameter("birthday", birthday);
        List result = query.getResultList();
        return result.size() > 0;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType) {
        String hql = "from Racer racer JOIN racer.documents document WHERE document.type = :documentType";
        Query query = entityManager.createQuery(hql);
        query.setParameter("documentType", documentType);

        return query.getResultList();
    }

}

package net.carting.dao;

import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;


@Repository
public class RacerCarClassNumberDAOImpl implements RacerCarClassNumberDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getAllRacerCarClassNumbers() {
        return entityManager
                .createQuery("from RacerCarClassNumber")
                .getResultList();
    }

    @Override
    public RacerCarClassNumber getRacerCarClassNumberById(int id) {
        return (RacerCarClassNumber) entityManager
                .createQuery("from RacerCarClassNumber where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addCarClass(RacerCarClassNumber racerCarClassNumber) {
        entityManager.persist(racerCarClassNumber);
    }

    @Override
    public void updateCarClass(RacerCarClassNumber racerCarClassNumber) {
        entityManager.merge(racerCarClassNumber);
    }

    @Override
    public void deleteCarClass(RacerCarClassNumber racerCarClassNumber) {
        Query query = entityManager.createQuery(
                "DELETE FROM RacerCarClassNumber c WHERE c.id = :id");
        query.setParameter("id", racerCarClassNumber.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass) {
        Query query = entityManager.createQuery("from RacerCarClassNumber where carClass= :carClass ");
        query.setParameter("carClass", carClass);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId) {
        Query query = entityManager
                .createQuery("from RacerCarClassNumber where carClass.id = :carClassId ")
                .setParameter("carClassId", carClassId);

        return query.getResultList();
    }

    @Override
    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number) {
        Query query = entityManager.
                createNativeQuery("SELECT * FROM racer_car_class_numbers "
                        + "WHERE car_class_id = :car_class_id AND "
                        + "number = :number");
        //TODO: Was: .addEntity(RacerCarClassNumber.class); Need to test, if it works ok without this line. UPD: 29/07/14 Seems to work ok.
        query.setParameter("car_class_id", Integer.toString(carClassId));
        query.setParameter("number", Integer.toString(number));
        List result = query.getResultList();

        return result.size() > 0;
    }

    @Override
    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassNumber rccn "
                        + "WHERE rccn.carClass.id = :carClassId AND "
                        + "rccn.racer.id = :racerId");
        query.setParameter("carClassId", carClassId);
        query.setParameter("racerId", racerId);

        return (RacerCarClassNumber) query.getSingleResult();
    }

    @Override
    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId) {
        String sqlQuery = "SELECT * FROM racer_car_class_numbers WHERE car_class_id = :carClassId AND racer_id = :racerId";
        Query query = entityManager
                .createNativeQuery(sqlQuery).
                        setParameter("carClassId", carClassId).
                        setParameter("racerId", racerId);
        List result = query.getResultList();

        return result.size() > 0;
    }

}

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

    @Override
    public List<RacerCarClassNumber> getAllRacerCarClassNumbers() {
        List<RacerCarClassNumber> racerCarClassNumbers = entityManager
                .createQuery("from RacerCarClassNumber")
                .getResultList();

        return racerCarClassNumbers;
    }

    @Override
    public RacerCarClassNumber getRacerCarClassNumberById(int id) {
        RacerCarClassNumber number = (RacerCarClassNumber) entityManager
                .createQuery("from RacerCarClassNumber where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);

        return number;
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
        entityManager.remove(racerCarClassNumber);

    }

    @Override
    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass) {
        Query query = entityManager.createQuery("from RacerCarClassNumber where carClass= :carClass ").setParameter("carClass", carClass);
        List<RacerCarClassNumber> numbers = query.getResultList();

        return numbers;
    }

    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId) {
        Query query = entityManager
                .createQuery("from RacerCarClassNumber where carClass.id = :carClassId ")
                .setParameter("carClassId", carClassId);
        List<RacerCarClassNumber> numbers = query.getResultList();

        return numbers;
    }

    @Override
    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number) {
        Query query = entityManager.
                createQuery("SELECT * FROM racer_car_class_numbers "
                        + "WHERE car_class_id = :car_class_id AND "
                        + "number = :number");
        //TODO: Was: .addEntity(RacerCarClassNumber.class); Need to test, if it works ok without this line
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

        RacerCarClassNumber number = (RacerCarClassNumber) query.getResultList().get(0);

        return number;
    }

    @Override
    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId) {
        String sqlQuery = "SELECT * FROM racer_car_class_numbers WHERE car_class_id = :carClassId AND racer_id = :racerId";
        Query query = entityManager
                .createQuery(sqlQuery).
                        setParameter("carClassId", carClassId).
                        setParameter("racerId", racerId);
        List result = query.getResultList();

        return result.size() > 0;
    }

}

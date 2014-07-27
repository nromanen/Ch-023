package net.carting.dao;

import java.util.List;

import net.carting.domain.CarClassCompetition;

import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Repository
public class CarClassCompetitionDAOImpl implements CarClassCompetitionDAO{

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

	@Override
	public List<CarClassCompetition> getAllCarClassCompetitions() {
        List<CarClassCompetition> classCompetitions = entityManager
                .createQuery("from CarClassCompetition").getResultList();
        
        return classCompetitions;
	}

	@Override
	public CarClassCompetition getCarClassCompetitionById(int id) {
        CarClassCompetition carClassCompetition = (CarClassCompetition) entityManager
                .createQuery("from CarClassCompetition where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
		return carClassCompetition;
	}

	@Override
	public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
        entityManager.persist(carClassCompetition);
        
	}

	@Override
	public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {
		Query query = entityManager.createQuery("UPDATE CarClassCompetition "
				+ "SET firstRaceTime = :firstRaceTime, "
				+ "secondRaceTime = :secondRaceTime, "
				+ "circleCount = :circleCount, "
				+ "percentageOffset = :percentageOffset "
				+ "WHERE id = :id");

		query.setParameter("firstRaceTime", carClassCompetition.getFirstRaceTime());
		query.setParameter("secondRaceTime", carClassCompetition.getSecondRaceTime());

        query.setParameter("circleCount", carClassCompetition.getCircleCount());
		query.setParameter("percentageOffset", carClassCompetition.getPercentageOffset());
		query.setParameter("id", carClassCompetition.getId());
		
		query.executeUpdate();
	}

	@Override
	public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
        entityManager.remove(carClassCompetition);
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId) {
		Query query = entityManager.
				createQuery("FROM CarClassCompetition ccc "
                        + "WHERE ccc.competition.id = :id "
                        + "ORDER BY ccc.carClass.name");
		query.setParameter("id", competitionId);
        List<CarClassCompetition> competitions = query.getResultList();
        
		return competitions;
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {	
		Query query = entityManager.
				createQuery("FROM CarClassCompetition ccc "
						  + "WHERE ccc.carClass.id = :id "
						  + "ORDER BY ccc.carClass.name");
		query.setParameter("id", carClassId);
        List<CarClassCompetition> competitions = query.getResultList();
		return competitions;
	}
	

}

package net.carting.dao;

import java.text.SimpleDateFormat;
import java.util.List;

import net.carting.domain.CarClassCompetition;

import net.carting.util.EntityManagerUtil;
import org.springframework.stereotype.Repository;

import javax.persistence.Query;

@Repository
public class CarClassCompetitionDAOImpl implements CarClassCompetitionDAO{

	@Override
	public List<CarClassCompetition> getAllCarClassCompetitions() {
        List<CarClassCompetition> classCompetitions = EntityManagerUtil.getEntityManager().
                createQuery("from CarClassCompetition").getResultList();
        EntityManagerUtil.closeTransaction();
        return classCompetitions;
	}

	@Override
	public CarClassCompetition getCarClassCompetitionById(int id) {
        CarClassCompetition carClassCompetition = EntityManagerUtil.getEntityManager().getReference(CarClassCompetition.class, id);
        EntityManagerUtil.closeTransaction();
		return carClassCompetition;
	}

	@Override
	public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
        EntityManagerUtil.getEntityManager().persist(carClassCompetition);
        EntityManagerUtil.closeTransaction();
	}

	@Override
	public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {
        //TODO: NEED TO TEST
		Query query = EntityManagerUtil.getEntityManager().createQuery("UPDATE CarClassCompetition "
				+ "SET firstRaceTime = :firstRaceTime, "
				+ "secondRaceTime = :secondRaceTime, "
				+ "circleCount = :circleCount, "
				+ "percentageOffset = :percentageOffset "
				+ "WHERE id = :id");

        //TODO: WAS setTime
		query.setParameter("firstRaceTime", carClassCompetition.getFirstRaceTime());
		query.setParameter("secondRaceTime", carClassCompetition.getSecondRaceTime());

        query.setParameter("circleCount", carClassCompetition.getCircleCount());
		query.setParameter("percentageOffset", carClassCompetition.getPercentageOffset());
		query.setParameter("id", carClassCompetition.getId());
		
		query.executeUpdate();
        EntityManagerUtil.closeTransaction();
	}

	@Override
	public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
        EntityManagerUtil.getEntityManager().remove(carClassCompetition);
        EntityManagerUtil.closeTransaction();
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId) {
		Query query = EntityManagerUtil.getEntityManager().
				createQuery("FROM CarClassCompetition ccc "
                        + "WHERE ccc.competition.id = :id "
                        + "ORDER BY ccc.carClass.name");
		query.setParameter("id", competitionId);
        List<CarClassCompetition> competitions = query.getResultList();
        EntityManagerUtil.closeTransaction();
		return competitions;
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {	
		Query query = EntityManagerUtil.getEntityManager().
				createQuery("FROM CarClassCompetition ccc "
						  + "WHERE ccc.carClass.id = :id "
						  + "ORDER BY ccc.carClass.name");
		query.setParameter("id", carClassId);
        List<CarClassCompetition> competitions = query.getResultList();
        EntityManagerUtil.closeTransaction();
		return competitions;
	}
	

}

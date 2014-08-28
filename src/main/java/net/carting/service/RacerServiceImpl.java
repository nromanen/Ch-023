package net.carting.service;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.CarClassDAO;
import net.carting.dao.RacerDAO;
import net.carting.domain.*;
import net.carting.util.CompetitionValidator;
import net.carting.util.DateUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class RacerServiceImpl implements RacerService {

	@Autowired
	private RacerDAO racerDAO;

	@Autowired
	private AdminSettingsDAO adminSettingsDAO;

	@Autowired
	private CarClassDAO carClassDAO;

	@Override
	@Transactional
	public List<Racer> getAllRacers() {
		return racerDAO.getAllRacers();
	}

	@Override
	public List<Racer> getBirthdayRacers(Date checkdate) {
		return racerDAO.getBirthdayRacers(checkdate);
	}

	@Override
	@Transactional
	public Racer getRacerById(int id) {
		return racerDAO.getRacerById(id);
	}

	@Override
	@Transactional
	public void addRacer(Racer racer) {
		racerDAO.addRacer(racer);
	}

	@Override
	@Transactional
	public void updateRacer(Racer racer) {
		racerDAO.updateRacer(racer);
	}

	@Override
	@Transactional
	public void deleteRacer(Racer racer) {
		racerDAO.deleteRacer(racer);
	}

	@Override
	@Transactional
	public boolean isSetRacer(String firstName, String lastName, Date birthday) {
		return racerDAO.isSetRacer(firstName, lastName, birthday);
	}

	private static final Logger LOG = Logger.getLogger(RacerServiceImpl.class);

	@Override
	@Transactional
	public Set<RacerCarClassNumber> parseCarClasses(String carClassesId,
			String carClassNumbers, Racer racer) {

		Set<RacerCarClassNumber> racerCarClassNumbers = new HashSet<RacerCarClassNumber>();
		String[] carClassesIdParts = carClassesId.split(",");
		String[] carClassNumbersParts = carClassNumbers.split(",");

		for (int i = 0; i < carClassesIdParts.length; i++) {
			CarClass cc = carClassDAO.getCarClassById(Integer
					.parseInt(carClassesIdParts[i].trim()));
			RacerCarClassNumber rccn = new RacerCarClassNumber(racer, cc,
					Integer.parseInt(carClassNumbersParts[i].trim()));
			racerCarClassNumbers.add(rccn);
		}

		return racerCarClassNumbers;
	}

	@Override
	@Transactional
	public Set<RacerCarClassNumber> parseUpdatedRacerCarClassNumbers(
			String updatedRacerCarClassNumbersStr, Racer racer) {

		Set<RacerCarClassNumber> racerCarClassNumbers = new HashSet<RacerCarClassNumber>();
		String[] racerCarClassNumbersParts = updatedRacerCarClassNumbersStr
				.split("#");

		for (int i = 0; i < racerCarClassNumbersParts.length; i++) {
			String[] racerCarClassNumberParts = racerCarClassNumbersParts[i]
					.split(",");
			int racerCarClassNumberId = Integer
					.parseInt(racerCarClassNumberParts[0]);
			RacerCarClassNumber racerCarClassNumber = new RacerCarClassNumber();
			racerCarClassNumber.setId(racerCarClassNumberId);
			CarClass carClass = carClassDAO.getCarClassById(Integer
					.parseInt(racerCarClassNumberParts[1]));
			racerCarClassNumber.setCarClass(carClass);
			racerCarClassNumber.setRacer(racer);
			racerCarClassNumber.setNumber(Integer
					.parseInt(racerCarClassNumberParts[2]));

			racerCarClassNumbers.add(racerCarClassNumber);
		}

		return racerCarClassNumbers;
	}

	@Override
	@Transactional
	public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
			int documentType) {
		return racerDAO
				.getListOfRacersWithSetDocumentByDocumentType(documentType);
	}

	@Override
	@Transactional
	public Set<Racer> getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
			int documentType, Team team) {
		Set<Racer> allTeamRecersWithoutSetDocument = team.getRacers();
		allTeamRecersWithoutSetDocument.removeAll(racerDAO
				.getListOfRacersWithSetDocumentByDocumentType(documentType));
		return allTeamRecersWithoutSetDocument;
	}

	@Override
	@Transactional
	public Set<Racer> getSetOfRacersNeedingPerentalPermisionByTeam(Team team) {
		Set<Racer> allTeamRecersNeedingPerentalPermision = getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
				Document.TYPE_RACER_PERENTAL_PERMISSIONS, team);
		Iterator<Racer> it = allTeamRecersNeedingPerentalPermision.iterator();
		adminSettingsDAO.getAdminSettings().getParentalPermissionYears();
		while (it.hasNext()) {
			if (it.next().getAge() >= adminSettingsDAO.getAdminSettings()
					.getParentalPermissionYears()) {
				it.remove();
			}
		}
		return allTeamRecersNeedingPerentalPermision;
	}

	@Override
	@Transactional
	public void setDocumentToRacers(Document document, String[] racersId) {
		for (int i = 0; i < racersId.length; i++) {
			/*
			 * -1 - it's gag in case none of racers hasn't been checked
			 */
			if (!racersId[i].equals("-1")) {
				Racer racer = getRacerById(Integer.parseInt(racersId[i]));
				racer.getDocuments().add(document);
				updateRacer(racer);
				LOG.info("Leader of team " + racer.getTeam().getName()
						+ " added '"
						+ Document.getStringDocumentType(document.getType())
						+ "'" + " to racer " + racer.getFirstName() + " "
						+ racer.getLastName());
			}
		}
	}
}

package net.carting.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import net.carting.domain.Competition;

import java.util.Date;

/**
 * Carting
 * Created by manson on 7/22/14.
 */
public class CompetitionValidator implements Validator {

    private static boolean compareDate(Date first, Date second) {
        return first.compareTo(second) >= 0;
    }


    @Override
    public boolean supports(Class aClass) {
        return Competition.class.equals(aClass);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        Competition competition = (Competition) obj;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "directorName", "dataerror.competition_director_name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "dataerror.competition_name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "secretaryName", "dataerror.competition_secretary_name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "place", "dataerror.competition_place");

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "directorCategoryJudicialLicense", "dataerror.competition_license");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "secretaryCategoryJudicialLicense", "dataerror.competition_license");

        Date dBegin = competition.getDateStart();
        Date dEnd = competition.getDateEnd();
        Date firstRace = competition.getFirstRaceDate();
        Date secondRace = competition.getSecondRaceDate();

        boolean validBegin = compareDate(dEnd, dBegin);

        // First race date must be >= Begin date
        boolean validFirstBegin = compareDate(firstRace, dBegin);

        // First race date must be <= End date
        boolean validFirstEnd = compareDate(dEnd, firstRace);

        // Second race date must be >= First date race
        boolean validRace = compareDate(secondRace, firstRace);

        // Second race date must be >= Begin date
        boolean validSecondBegin = compareDate(secondRace, dBegin);

        // Second race date must be <= End date
        boolean validSecondEnd = compareDate(dEnd, secondRace);

        boolean validDates = validBegin && validFirstBegin && validFirstEnd && validRace && validSecondBegin && validSecondEnd;

        if (!validDates) {
            errors.rejectValue("dateStart", "dataerror.competition_date");
        }

    }
}

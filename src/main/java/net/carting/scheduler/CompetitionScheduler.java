package net.carting.scheduler;

import net.carting.domain.Competition;
import net.carting.service.CompetitionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * Carting
 * Created by manson on 7/28/14.
 */
@Component
public class CompetitionScheduler {

    private static final Logger LOG = LoggerFactory.getLogger(CompetitionScheduler.class);

    @Autowired
    private CompetitionService competitionService;

    //TODO: date after, date before
    private static boolean compareDate(Date first, Date second) {
        return first.compareTo(second) > 0;
    }

    //Fire event everyday at 00:30 pm
    @Scheduled(cron = "0 30 0 ? * *")
    public void disablePastCompetition() {
        Date today = new Date();
        List<Competition> competitions = competitionService.getAllCompetitions();
        for (Competition c : competitions) {
            Date competitionEndDate = c.getDateEnd();
            if (compareDate(today, competitionEndDate)) {
                if (c.isEnabled()) {
                    LOG.info("Disabling competition: {} ( id = {} )", c.getName(), c.getId());
                    competitionService.setEnabled(c.getId(), false);
                }
            }
        }
    }

}

package net.carting.web;

import net.carting.domain.Leader;
import net.carting.domain.Racer;
import net.carting.domain.Team;
import net.carting.service.RacerService;
import net.carting.service.RacerServiceImpl;
import net.carting.service.CompetitionService;
import net.carting.service.UserService;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.context.TilesRequestContext;
import org.apache.tiles.preparer.ViewPreparerSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller("leftSideController")
@Scope("session")
public class LeftSideController extends ViewPreparerSupport implements Serializable {

    private static final long serialVersionUID = 982938625855026222L;

    @Autowired
    private CompetitionService competitionService;  
    @Autowired
    private RacerService racerService;

    @Override
    public void execute(TilesRequestContext tilesContext, AttributeContext attributeContext) {
        Map<String, Object> response = tilesContext.getRequestScope();       
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        Date today = new Date();
        List<Racer> racers = racerService.getBirthdayRacers(today);        
        response.put("currentYear", currentYear);
        response.put("competitionListByCurrentYear", competitionService.getCompetitionsByYear(currentYear));
        response.put("racers", racers);
    }
    
  
    
}

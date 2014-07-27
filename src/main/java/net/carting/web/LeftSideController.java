package net.carting.web;

import net.carting.service.CompetitionService;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.context.TilesRequestContext;
import org.apache.tiles.preparer.ViewPreparerSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Map;

@Controller("leftSideController")
@Scope("session")
public class LeftSideController extends ViewPreparerSupport implements Serializable {

    private static final long serialVersionUID = 982938625855026222L;

    @Autowired
    private CompetitionService competitionService;

    @Override
    public void execute(TilesRequestContext tilesContext, AttributeContext attributeContext) {
        Map<String, Object> response = tilesContext.getRequestScope();
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        response.put("currentYear", currentYear);
        response.put("competitionListByCurrentYear", competitionService.getCompetitionsByYear(currentYear));
    }
}

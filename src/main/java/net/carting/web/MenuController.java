package net.carting.web;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.service.CompetitionService;
import net.carting.service.DocumentService;
import net.carting.service.LeaderService;
import net.carting.service.TeamService;
import net.carting.service.UserService;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.context.TilesRequestContext;
import org.apache.tiles.preparer.ViewPreparerSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Map;

@Controller("menuController")
@Scope("session")
public class MenuController extends ViewPreparerSupport implements Serializable {

    @Autowired
    private UserService userService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private CompetitionService competitionService;
    @Autowired
    private DocumentService documentService;
    
    @Override
    public void execute(TilesRequestContext tilesContext, AttributeContext attributeContext) {

        Map<String, Object> response = tilesContext.getRequestScope();

        String username = userService.getCurrentUserName();
        if (userService.getCurrentAuthority().equals(UserService.ROLE_TEAM_LEADER)) {

            Leader leader = leaderService.getLeaderByUserName(username);
            response.put("leader", leader);
            boolean isTeamByLeader = teamService.isTeamByLeaderId(leader.getId());
            response.put("isTeamByLeader", isTeamByLeader);
            if (isTeamByLeader) {
                Team team = teamService.getTeamByLeader(leader);
                response.put("team", team);
            }
        }
        response.put("currentYear", Calendar.getInstance().get(Calendar.YEAR));
        response.put("username", username);
        response.put("authority", userService.getCurrentAuthority());
        response.put("uncheckedDocsCount",documentService.gelAllUncheckedDocuments().size());
    }

}

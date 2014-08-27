package net.carting.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import net.carting.domain.Document;
import net.carting.domain.File;
import net.carting.domain.Leader;
import net.carting.domain.Racer;
import net.carting.domain.Team;
import net.carting.service.DocumentService;
import net.carting.service.FileService;
import net.carting.service.LeaderService;
import net.carting.service.RacerService;
import net.carting.service.TeamService;
import net.carting.service.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/document")
public class DocumentController {

    @Autowired
    ServletContext context;
    
    @Autowired
    private MessageSource messageSource;
    
    @Autowired
    private FileService fileService;
    
    @Autowired
    private DocumentService documentService;
    
    @Autowired
    private TeamService teamService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private LeaderService leaderService;
    
    @Autowired
    private RacerService racerService;

    private static final Logger LOG = LoggerFactory.getLogger(DocumentController.class);

    private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };
    /* TODO Remove HttpServletRequest */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String documentPage(Map<String, Object> map,
            @PathVariable("id") int id, HttpServletRequest request) {
        Document document = documentService.getDocumentById(id);
        map.put("document", document);
        map.put("request", request);
        if (userService.getCurrentAuthority().equals(UserService.ROLE_ADMIN)) {
            /*
             * If user is administrator, he is redirected to page of document
             */
            return "document";
        }
        /*
         * Gets team that is owner of this document
         */
        Team teamOwner = document.getTeamOwner();
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        /*
         * Compares team whose leader is authorized and team that is owner of
         * this document
         */
        if (teamService.isTeamByLeaderId(leader.getId())) {
            Team team = teamService.getTeamByLeader(leader);
            if (team.getId() == teamOwner.getId()) {
                /*
                 * If user is owner of document, he is redirected to page of
                 * document
                 */
                return "document";
            } else {
                /*
                 * If team leader isn't owner of document, he is redirected to
                 * page of his team
                 */

                LOG.trace("Leader of team {} tried to see a document of team {}, but was redirected to page of his team",
                		team.getName(), teamOwner.getName());
                return "redirect:/team/" + team.getId();
            }
        } else {
			/*
			 * If team leader don't has a team, he is redirected to page in
			 * which he can add team
			 */
            LOG.trace("Leader {} {} tried to see a document of team {}, but was redirected to add team, because he didn't has a team",
            		leader.getFirstName(), leader.getLastName(), teamOwner.getName());
            return "redirect:/team/add";
        }

    }

    @RequestMapping(value = "/add/{documentType}", method = RequestMethod.GET)
    public String pageForAddDocument(Map<String, Object> map, @PathVariable int documentType) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        if (teamService.isTeamByLeaderId(leader.getId())) {
            Team team = teamService.getTeamByLeader(leader);
            map.put("documentType", documentType);
            if (documentType == Document.TYPE_RACER_PARENTAL_PERMISSIONS) {
                map.put("racers", racerService
                        .getSetOfRacersNeedingPerentalPermisionByTeam(team));
            } else {
                map.put("racers", racerService
                        .getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
                                documentType, team));
            }
            LOG.trace("Leader of team {} tried to add document {}",
            		team.getName(), Document.getStringDocumentType(documentType));
            return "document_add_edit";
        } else {
            LOG.trace("Leader {} {} tried to add document , but was redirected to add team, because he didn't has a team", 
            		leader.getFirstName(), leader.getLastName());
            return "redirect:/team/add";
        }
    }

    @RequestMapping(value = "/addDocument", method = RequestMethod.POST)
    public String addDocument(@RequestParam("racer_id") String[] racersId,
                              @RequestParam(value="document_type") Integer documentType,
                              @RequestParam(value="number", required=false) String number,
                              @RequestParam(value="start_date", required=false) String startDate,
                              @RequestParam(value="finish_date", required=false) String finishDate,
                              @RequestParam("file") MultipartFile[] files,
                              Locale locale,
                              Map<String, Object> map) {
    	/* Getting current leader */
    	
    	 String username = userService.getCurrentUserName();
         Leader leader = leaderService.getLeaderByUserName(username);

         if (teamService.isTeamByLeaderId(leader.getId())) {
             Team team = teamService.getTeamByLeader(leader);
             if (racersId.length == 0) {
                 /*
                  * If team leader doesn't choose racers, he is redirected to
                  * page of his team
                  */
                 LOG.trace("Team leader doesn't choose racers...");
                 return "redirect:/team/" + team.getId();
             } else {
                 /*
                  * Getting document data from form and creating object
                  * 'Document'
                  */
                 try {
                     documentService.addDocumentAndUpdateRacers(documentType, racersId, number, startDate, finishDate, files, leader);
                 } catch (IOException e) {
                     map.put("message", messageSource.getMessage("dataerror.invalid_file_loading", null, locale));
                     LOG.error("Leader {} {} tried to add document, but happened some problem with writing files to server",
                     leader.getFirstName(), leader.getLastName());
                     return "custom_generic_exception";
                 }
                 return "redirect:/team/" + team.getId();
             }
         } else {
             LOG.error("Team leader doesn't exists...");
             return "redirect:/team/add";
         }
    }

    @RequestMapping(value = "/setApproved", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String setDocumentApproved(@RequestBody Map<String, Object> map) {
        Document document = documentService.getDocumentById(Integer
                .parseInt(map.get("documentId").toString()));
        document.setReason("");
        document.setApproved(true);
        document.setChecked(true);
        documentService.updateDocument(document);
        return "success";
    }

    @RequestMapping(value = "/setUnapproved", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String setDocumentUnpproved(@RequestBody Map<String, Object> map) {
        Document document = documentService.getDocumentById(Integer
                .parseInt(map.get("documentId").toString()));
        document.setReason(map.get("reason").toString());
        document.setApproved(false);
        document.setChecked(true);
        documentService.updateDocument(document);
        return "success";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteDocument(@RequestBody Map<String, Object> map) {
    	LOG.debug("Start deleteDocument method");
            int documentId = Integer.parseInt(map.get("document_id").toString());
            Document document = documentService.getDocumentById(documentId);
            String[] racersIdString = map.get("racers_id_string").toString()
                    .split("#");
            int[] racersId = new int[racersIdString.length];
            for (int i = 0; i < racersIdString.length; i++) {
                racersId[i] = Integer.parseInt(racersIdString[i]);
                documentService.deleteDocumentFromRacerByRacerIdAndDocumentId(
                        documentId, racersId[i]);
                LOG.trace("'{}' was deleted from racer {} {} by leader {} {} of team {}",
                		document.getCurrentStringDocumentType(), racerService.getRacerById(racersId[i]).getFirstName(),
                        racerService.getRacerById(racersId[i]).getLastName(), document.getTeamOwner().getLeader().getFirstName(), 
                        document.getTeamOwner().getLeader().getLastName(), document.getTeamOwner().getName());
            }
            if (!documentService.isRacerOwnerOfDocument(documentId)) {
                documentService.deleteDocument(document);
                LOG.trace("{} was deleted by leader of team '{}'", document.getCurrentStringDocumentType(), document.getTeamOwner().getName());
            }
            LOG.debug("End deleteDocument method");
        return "success";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String pageForEditDocument(Map<String, Object> map, @PathVariable("id") int id) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        if (teamService.isTeamByLeaderId(leader.getId())) {
            Document document = documentService.getDocumentById(id);
            Team team = teamService.getTeamByLeader(leader);
            if (team.getId() == document.getTeamOwner().getId()) {
                map.put("document", document);
                if (document.getStartDate() != null) {
                    map.put("startDate",
                            formatter.get().format(document.getStartDate()));
                }
                if (document.getFinishDate() != null) {
                    map.put("finishDate",
                            formatter.get().format(document.getFinishDate()));
                }
                map.put("documentType", document.getType());
                return "document_add_edit";
            } else {
                return "redirect:/team/" + team.getId();
            }
        } else {
            return "redirect:/team/add";
        }
    }

    @RequestMapping(value = "/confirmEdit", method = RequestMethod.POST)
    public String editDocument(@RequestParam("document_id") Integer documentId,
                               @RequestParam(value="number", required=false) String number,
                               @RequestParam(value="start_date", required=false) String startDate,
                               @RequestParam(value="finish_date", required=false) String finishDate,
                               @RequestParam("file") MultipartFile[] files, 
                               Locale locale,
                               Map<String, Object> map) {
        
        try {
            documentService.editDocument(documentId, number, startDate, finishDate, files);
            return "redirect:/document/" + documentId;
        } catch (IOException e) {
            String username = userService.getCurrentUserName();
            Leader leader = leaderService.getLeaderByUserName(username);
            map.put("message", messageSource.getMessage("dataerror.invalid_file_loading", null, locale));
            LOG.error("Leader {} {} tried to add document, but happened some problem with writing files to server",
                    leader.getFirstName(), leader.getLastName());
            return "custom_generic_exception";
        }
    }

    @RequestMapping(value = "/deleteFile", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteFile(@RequestBody Map<String, Object> map) {
        int fileId = Integer.parseInt(map.get("fileId").toString());
        File file = fileService.getFileById(fileId);
        fileService.deleteFile(file);
        return "success";
    }

    @RequestMapping(value = "/checkingDocuments/{index}", method = RequestMethod.GET)
    public String checkingDocuments(@PathVariable("index") int index,
                                    Map<String, Object> map) {

        List<Document> documents = documentService.gelAllUncheckedDocuments();
        if (index >= documents.size()) {
            return "redirect:" + (documents.size() - 1);
        }
        map.put("documents", documents);
        map.put("isEmpty", documents.isEmpty());
        map.put("index", index);

        return "checking_documents";
    }

    @RequestMapping(value = "/allDocuments", method = RequestMethod.GET)
    public String allDocuments(Map<String, Object> map,
            @RequestParam(value = "type", required = false) String type) {
        if (type == null) {
            type = "modern";
        }
        map.put("teams", teamService.getAllTeams());
       List<String> teamDocStatus = new ArrayList<String>();
       String status;
       
       for (Team team:teamService.getAllTeams()) {
    	   status = "hasDocs";
    	   System.out.println(team.getDocuments());
    	   if (!team.getDocuments().isEmpty()) {
    		   for (Racer racer:team.getRacers()) {
    			   if(racer.getDocuments()!=null) {
    				   for(Document doc:racer.getDocuments()) {
    					   if (!doc.isChecked()) {
    						   status = "unchecked";
						   }
					   }
				   }
			   }
		   } else {
			   System.out.println(team.getName()+" - " + team.getDocuments());
			   status = "noDocs";
		   }
    	   teamDocStatus.add(status);
    	}
        map.put("team_doc_status", teamDocStatus);
        map.put("all_docs", documentService.getAllDocuments());
        map.put("unchecked_docs", documentService.gelAllUncheckedDocuments());
        map.put("type", type);

        return "all_documents";
    }

    @RequestMapping(value = "/allDocuments/classic", method = RequestMethod.GET)
    public String allDocumentsClassic(Map<String, Object> map,
            @RequestParam(value = "type", required = false) String type) {
        if (type == null) {
            type = "classic";
        }
        map.put("type", type);
        return "redirect:/document/allDocuments";
    }

}

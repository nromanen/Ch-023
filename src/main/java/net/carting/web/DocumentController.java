package net.carting.web;

import net.carting.domain.*;
import net.carting.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String documentPage(Map<String, Object> map,
            @PathVariable("id") int id, @RequestParam(value="competition_id", required=false) Integer competitionId) {
        Document document = documentService.getDocumentById(id);
        map.put("document", document);
        if (competitionId != null){
            map.put("competitionId",  competitionId);
        }
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
                map.put("racersList", racerService
                        .getSetOfRacersNeedingPerentalPermisionByTeam(team));
            } else {
                map.put("racersList", racerService
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
                              @RequestParam(value = "document_type") Integer documentType,
                              @RequestParam(value = "number", required = false) String number,
                              @RequestParam(value = "start_date", required = false) String startDate,
                              @RequestParam(value = "finish_date", required = false) String finishDate,
                              @RequestParam(value = "fileExtensions") String[] fileNames,
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
                LOG.info("Team leader doesn't choose racers...");
                return "redirect:/team/" + team.getId();
            } else {
                 /*
                  * Getting document data from form and creating object
                  * 'Document'
                  */
                try {
                    documentService.addDocumentAndUpdateRacers(documentType, racersId, number, startDate, finishDate, files, fileNames);
                } catch (Exception e) {
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
            LOG.info("'{}' was deleted from racer {} {} by leader {} {} of team {}",
                        document.getCurrentStringDocumentType(), racerService.getRacerById(racersId[i]).getFirstName(),
                        racerService.getRacerById(racersId[i]).getLastName(), document.getTeamOwner().getLeader().getFirstName(),
                    document.getTeamOwner().getLeader().getLastName(), document.getTeamOwner().getName());
        }
        if (!documentService.isRacerOwnerOfDocument(documentId)) {
            documentService.deleteDocument(document);
            LOG.info("{} was deleted by leader of team '{}'", document.getCurrentStringDocumentType(), document.getTeamOwner().getName());
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
                               @RequestParam(value = "number", required = false) String number,
                               @RequestParam(value = "start_date", required = false) String startDate,
                               @RequestParam(value = "finish_date", required = false) String finishDate,
                               @RequestParam(value = "fileExtensions") String[] fileExtensions,
                               @RequestParam("file") MultipartFile[] files,
                               Locale locale,
                               Map<String, Object> map) {

        try {
            documentService.editDocument(documentId, number, startDate, finishDate, files, fileExtensions);
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

    @RequestMapping(value = "/showDocument/{id}", method = RequestMethod.GET)
    public ModelAndView showDocument(Model model, @PathVariable("id") int id) {
        model.addAttribute("pdf", false);
        try {
        File f = fileService.getFileById(id);
        model.addAttribute("file", f);
        } catch (Exception e) {
            model.addAttribute("exception", true);
        }
        return new ModelAndView("document_view");
    }

    @RequestMapping(value = "/showFile/{id}", method = RequestMethod.GET)
    public ModelAndView showFile(Model model, @PathVariable("id") int id) {
        model.addAttribute("pdf", true);
        try {
            File f = fileService.getFileById(id);
            model.addAttribute("file", f);
        } catch (Exception e) {
            model.addAttribute("exception", true);
        }
        return new ModelAndView("document_view");
    }
    
    
    @RequestMapping(value = "/addDocs", method = RequestMethod.POST)
    public @ResponseBody String addDocumentsForNewRacerAction(
            @RequestParam("files[]") MultipartFile[]  files,
            @RequestParam("docType") Integer docType,
            @RequestParam("racerId") String racerId,
            @RequestParam("fileExtensions") String fileExtensions,
            @RequestParam(value = "doc_number", required = false) String number,
            @RequestParam(value = "start_date", required = false) String startDate,
            @RequestParam(value = "finish_date", required = false) String finishDate) { 
        try {
            if(Integer.parseInt(racerId)<1) {
                /*
                 * If team leader doesn't choose racers, he is redirected to
                 * page of his team
                 */
               LOG.info("Team leader doesn't choose racers...");
               return "Team leader doesn't choose racers";
            }
        } catch (Exception e) {
            return "RacerId don't exist";
        }
        if (files == null || files.length <1) {
            return "problem";
        }
        String[]racersId={racerId};
        String[]fileExtensionsArray = fileExtensions.split(",");
        /* Getting current leader */
        Leader leader = leaderService.getLeaderByUserName(userService.getCurrentUserName());
        String msg = "problem";
           if (teamService.isTeamByLeaderId(leader.getId())) {
               Team team = teamService.getTeamByLeader(leader);
               for (Racer racer : team.getRacers()) {
                   if (racer.getId()==Integer.parseInt(racerId)) {
                       try {
                           documentService.addDocumentAndUpdateRacers(docType, racersId, number, startDate, finishDate, files, fileExtensionsArray);
                           System.out.println("File added!");
                           msg="added";
                       } catch (Exception e) {
                           msg= "problem";
                           LOG.error("Leader {} {} tried to add document, but happened some problem with writing files to server",
                                   leader.getFirstName(), leader.getLastName());
                           System.out.println("Something wrong with properties.");
                           return msg;
                       }
                   }
               }
              
           } else { 
               LOG.error("Team leader doesn't exists...");
               msg = "Relogin in, please!";
           }
       return msg;
    }
}

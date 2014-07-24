package net.carting.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import net.carting.domain.Document;
import net.carting.domain.File;
import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.service.DocumentService;
import net.carting.service.FileService;
import net.carting.service.LeaderService;
import net.carting.service.RacerService;
import net.carting.service.TeamService;
import net.carting.service.UserService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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

	private static final Logger LOG = Logger
			.getLogger(DocumentController.class);

	private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>() {
		@Override
		protected SimpleDateFormat initialValue() {
			return new SimpleDateFormat("yyyy-MM-dd");
		}
	};

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

				LOG.info("Leader of team " + team.getName()
						+ "tried to see a document of team "
						+ teamOwner.getName()
						+ ", but was redirected to page of his team");
				return "redirect:/team/" + team.getId();
			}
		} else {
			/*
			 * If team leader don't has a team, he is redirected to page in
			 * which he can add team
			 */
			LOG.info("Leader "
					+ leader.getFirstName()
					+ " "
					+ leader.getLastName()
					+ "tried to see a document of team "
					+ teamOwner.getName()
					+ ", but was redirected to add team, because he didn't has a team");
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
			if (documentType == Document.TYPE_RACER_PERENTAL_PERMISSIONS) {
				map.put("racers", racerService
						.getSetOfRacersNeedingPerentalPermisionByTeam(team));
			} else {
				map.put("racers", racerService
						.getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
								documentType, team));
			}
			LOG.info("Leader of team " + team.getName()
					+ " tried to add document "
					+ Document.getStringDocumentType(documentType));
			return "document_add";
		} else {
			LOG.info("Leader "
					+ leader.getFirstName()
					+ " "
					+ leader.getLastName()
					+ "tried to add document , but was redirected to add team, because he didn't has a team");
			return "redirect:/team/add";
		}
	}

	@RequestMapping(value = "/addDocument", method = RequestMethod.POST)
	public String addDocument(@RequestParam("racer_id") String[] racersId,
			@RequestParam("file") MultipartFile[] files,
			HttpServletRequest request, Map<String, Object> map) {
		/* Getting current leader */
		String username = userService.getCurrentUserName();
		Leader leader = leaderService.getLeaderByUserName(username);

		if (teamService.isTeamByLeaderId(leader.getId())) {
			Team team = teamService.getTeamByLeader(leader);
			if (racersId.length == 1) {
				/*
				 * If team leader doesn't choose racers, he is redirected to
				 * page of his team
				 */
				return "redirect:/team/" + team.getId();
			} else {
				/*
				 * Getting document data from form and creating object
				 * 'Document'
				 */
				try {
					documentService.addDocumentAndUpdateRacers(request, files,
							racersId, leader);
				} catch (IOException e) {
					map.put("message",
							"Просимо вибачення, але сталася помилка при завантаженні файлів і Ваш документ не був доданий. Спробуйту, будь ласка, пізніше.");
					LOG.error("Leader "
							+ leader.getFirstName()
							+ " "
							+ leader.getLastName()
							+ " tried to add document, but happened some problem with writing files to server");
					return "custom_generic_exception";
				}
				return "redirect:/team/" + team.getId();
			}

		} else {
			return "redirect:/team/add";
		}
	}

	@RequestMapping(value = "/setApproved", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String setDocumentApproved(@RequestBody Map<String, Object> map) {
		Document document = documentService.getDocumentById(Integer
				.parseInt(map.get("documentId").toString()));
		document.setReason("");
		document.setApproved(true);
		document.setChecked(true);
		documentService.updateDocument(document);
		return "success";
	}

	@RequestMapping(value = "/setUnapproved", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String setDocumentUnpproved(@RequestBody Map<String, Object> map) {
		Document document = documentService.getDocumentById(Integer
				.parseInt(map.get("documentId").toString()));
		document.setReason(map.get("reason").toString());
		document.setApproved(false);
		document.setChecked(true);
		documentService.updateDocument(document);
		return "success";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String deleteDocument(@RequestBody Map<String, Object> map) {
		int documentId = Integer.parseInt(map.get("document_id").toString());
		Document document = documentService.getDocumentById(documentId);
		String[] racersIdString = map.get("racers_id_string").toString()
				.split("#");
		int[] racersId = new int[racersIdString.length];
		for (int i = 0; i < racersIdString.length; i++) {
			racersId[i] = Integer.parseInt(racersIdString[i]);
			documentService.deleteDocumentFromRacerByRacerIdAndDocumentId(
					documentId, racersId[i]);
			LOG.info("'" + document.getCurrentStringDocumentType() + "'"
					+ " was deleted from racer "
					+ racerService.getRacerById(racersId[i]).getFirstName()
					+ " "
					+ racerService.getRacerById(racersId[i]).getLastName()
					+ " by leader "
					+ document.getTeamOwner().getLeader().getFirstName() + " "
					+ document.getTeamOwner().getLeader().getLastName()
					+ " of team " + document.getTeamOwner().getName() + "'");
		}
		if (documentService.isRacerOwnerOfDocument(documentId) == false) {
			for (File file : document.getFiles()) {
				documentService.deleteFileFromServer(file.getPath());
			}
			documentService.deleteDocument(document);
			LOG.info(document.getCurrentStringDocumentType()
					+ "was deleted by leader of team '"
					+ document.getTeamOwner().getName() + "'");
		}

		return "success";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String pageForEditDocument(Map<String, Object> map,
			@PathVariable("id") int id) {
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
				return "document_edit";
			} else {
				return "redirect:/team/" + team.getId();
			}
		} else {
			return "redirect:/team/add";
		}
	}

	@RequestMapping(value = "/confirmEdit", method = RequestMethod.POST)
	public String editDocument(HttpServletRequest request,
			@RequestParam("file") MultipartFile[] files, Map<String, Object> map) {
		int documentId = Integer.parseInt(request.getParameter("document_id")
				.toString());
		try {
			documentService.editDocument(documentId, request, files);
			return "redirect:/document/" + documentId;
		} catch (IOException e) {
			String username = userService.getCurrentUserName();
			Leader leader = leaderService.getLeaderByUserName(username);
			map.put("message",
					"Просимо вибачення, але сталася помилка при завантаженні файлів і Ваш документ не був відредагований. Спробуйту, будь ласка, пізніше.");
			LOG.error("Leader "
					+ leader.getFirstName()
					+ " "
					+ leader.getLastName()
					+ " tried to add document, but happened some problem with writing files to server");
			return "custom_generic_exception";
		}

	}

	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String deleteFile(@RequestBody Map<String, Object> map) {
		int fileId = Integer.parseInt(map.get("fileId").toString());
		File file = fileService.getFileById(fileId);
		if (documentService.deleteFileFromServer(file.getPath())) {
			fileService.deleteFile(file);
		}
		return "success";
	}

	@RequestMapping(value = "/checkingDocuments/{index}", method = RequestMethod.GET)
	public String checkingDocuments(@PathVariable("index") int index,
			Map<String, Object> map) {

		List<Document> documents = documentService.gelAllUncheckedDocuments();
		if(index>=documents.size()){
			return "redirect:"+(documents.size()-1);
		}
		map.put("documents", documents);
		map.put("isEmpty", documents.isEmpty());
		map.put("index", index);

		return "checking_documents";
	}
}

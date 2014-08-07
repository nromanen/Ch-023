package net.carting.service;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Leader;
import net.carting.util.DateUtil;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Service
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    ServletContext context;

    Logger logger = Logger.getLogger(DocumentServiceImpl.class);

    @Autowired
    private DocumentDAO documentDAO;

    @Autowired
    public FileService fileService;

    @Autowired
    public RacerService racerService;

    @Override
    @Transactional
    public List<Document> getAllDocuments() {
        return documentDAO.getAllDocuments();
    }

    @Override
    @Transactional
    public Document getDocumentById(int id) {
        return documentDAO.getDocumentById(id);
    }

    @Override
    @Transactional
    public void addDocument(Document document) {
        documentDAO.addDocument(document);

    }

    @Override
    @Transactional
    public void updateDocument(Document document) {
        documentDAO.updateDocument(document);

    }

    @Override
    @Transactional
    public void deleteDocument(Document document) {
        documentDAO.deleteDocument(document);
    }

    @Override
    @Transactional
    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
                                                              int racerId) {
        documentDAO.deleteDocumentFromRacerByRacerIdAndDocumentId(documentId,
                racerId);
    }

    @Override
    @Transactional
    public boolean isRacerOwnerOfDocument(int documentId) {
        return documentDAO.isRacerOwnerOfDocument(documentId);
    }

    @Override
    @Transactional
    public void addDocumentAndUpdateRacers(HttpServletRequest request,
                                           MultipartFile[] files, String[] racersId, Leader leader)
            throws IOException {
        int documentType = Integer.parseInt(request.getParameter(
                "document_type").toString());
        Document document = new Document();
        document.setType(documentType);
        document = setDocumentParametersFromRequestAcordingToType(document,
                request);
        addDocument(document);
        List<String> paths = getPathsAndWriteFilesToServer(files, documentType,
                leader.getId());
        fileService.addFilesToDocument(document, paths);
        racerService.setDocumentToRacers(document, racersId);
    }

    @Override
    @Transactional
    public void editDocument(int documentId, HttpServletRequest request,
                             MultipartFile[] files) throws IOException {
        Document document = getDocumentById(documentId);
        document.setApproved(false);
        document.setChecked(false);
        document.setReason("");
        document = setDocumentParametersFromRequestAcordingToType(document,
                request);
        updateDocument(document);

        int documentType = document.getType();
        List<String> paths = getPathsAndWriteFilesToServer(files, documentType,
                document.getTeamOwner().getLeader().getId());
        fileService.addFilesToDocument(document, paths);
        logger.info("Leader "
                + document.getTeamOwner().getLeader().getFirstName() + " "
                + document.getTeamOwner().getLeader().getLastName()
                + " of team " + document.getTeamOwner().getName()
                + " edited document "
                + Document.getStringDocumentType(documentType));
    }

    @Override
    public List<String> getPathsAndWriteFilesToServer(MultipartFile[] files,
                                                      int documentType, int leaderId) throws IOException {
        List<String> pathsToFiles = new ArrayList<String>();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
                byte[] bytes = file.getBytes();
                String fileName = Document.getStringDocumentType(documentType)
                        .replace(" ", "_")
                        + Calendar.getInstance().getTimeInMillis()
                        + leaderId
                        + "."
                        + FilenameUtils
                        .getExtension(file.getOriginalFilename());
                String directoryAbsoltePath = createDirectoryForFilesAndGetAbsolutePath();
                File serverFile = new File(directoryAbsoltePath
                        + File.separator + fileName);
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();
                pathsToFiles.add(fileName);
            }
        }
        return pathsToFiles;
    }

    @Override
    public Document setDocumentParametersFromRequestAcordingToType(
            Document document, HttpServletRequest request) {
        int documentType = document.getType();
        switch (documentType) {
            case Document.TYPE_RACER_LICENCE:
                document.setName(request.getParameter("number").toString());
                break;
            case Document.TYPE_RACER_INSURANCE:
                document.setName(request.getParameter("number").toString());
                document.setFinishDate(DateUtil.getDateFromString(request
                        .getParameter("finish_date").toString()));
                break;
            case Document.TYPE_RACER_PERENTAL_PERMISSIONS:
                document.setStartDate(DateUtil.getDateFromString(request
                        .getParameter("start_date").toString()));
                break;
            case Document.TYPE_RACER_MEDICAL_CERTIFICATE:
                document.setFinishDate(DateUtil.getDateFromString(request
                        .getParameter("finish_date").toString()));
                break;
            default:
                break;
        }
        return document;
    }

    public String createDirectoryForFilesAndGetAbsolutePath() {
        File dir = new File( this.context.getRealPath("") + DocumentService.DOCUMENTS_UPLOAD_DIR);
        if (!dir.exists())
            dir.mkdirs();
        return dir.getAbsolutePath();
    }

    @Override
    public boolean deleteFileFromServer(String filePath) {
        File serverFile = new File(createDirectoryForFilesAndGetAbsolutePath()
                + File.separator + filePath);
        if (!serverFile.exists()) {
            return true;
        }
        return serverFile.delete();
    }

    @Override
    @Transactional
    public List<Document> gelAllUncheckedDocuments() {
        return documentDAO.gelAllUncheckedDocuments();
    }
}
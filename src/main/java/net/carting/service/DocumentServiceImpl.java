package net.carting.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Leader;
import net.carting.util.DateUtil;
import net.carting.util.PdfWriter;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.text.DocumentException;

@Service
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    ServletContext context;

    Logger logger = LoggerFactory.getLogger(DocumentServiceImpl.class);

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
    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId, int racerId) {
        documentDAO.deleteDocumentFromRacerByRacerIdAndDocumentId(documentId, racerId);
    }

    @Override
    @Transactional
    public boolean isRacerOwnerOfDocument(int documentId) {
        return documentDAO.isRacerOwnerOfDocument(documentId);
    }

    @Override
    @Transactional
    public void addDocumentAndUpdateRacers(Integer documentType, String[] racersId, String number, 
                                            String startDate, String finishDate, MultipartFile[] files, Leader leader) throws IOException  {
        Document document = new Document();
        document.setType(documentType);
        document = setDocumentParametersByType(document, number, startDate, finishDate);
        addDocument(document);
        List<String> paths = null;
        try {
            paths = getPathsAndWriteFilesToServer(files, documentType, leader.getId());
        } catch (IOException e) {
            e.printStackTrace();
        }
        fileService.addFilesToDocument(document, paths);
        racerService.setDocumentToRacers(document, racersId);
    }


    @Override
    @Transactional
    public void editDocument(Integer documentId, String number, String startDate, String finishDate, 
                             MultipartFile[] files) throws IOException {
 
        Document document = getDocumentById(documentId);
        document.setApproved(false);
        document.setChecked(false);
        document.setReason("");
        document = setDocumentParametersByType(document, number, startDate, finishDate);
        updateDocument(document);

        int documentType = document.getType();
        List<String> paths = getPathsAndWriteFilesToServer(files, documentType,
                document.getTeamOwner().getLeader().getId());
        fileService.addFilesToDocument(document, paths);
        logger.info("Leader {} {} of team {} edited document {}",
                document.getTeamOwner().getLeader().getFirstName(),
                document.getTeamOwner().getLeader().getLastName(),
                document.getTeamOwner().getName(),
                Document.getStringDocumentType(documentType));
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
                String directoryAbsolutePath = createDirectoryForFilesAndGetAbsolutePath();
                File serverFile = new File(directoryAbsolutePath
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
    public Document setDocumentParametersByType(Document document, String number, String startDate, String finishDate) {
        int documentType = document.getType();
        switch (documentType) {
            case Document.TYPE_RACER_LICENCE:
                document.setName(number);
                break;
            case Document.TYPE_RACER_INSURANCE:
                document.setName(number);
                document.setFinishDate(DateUtil.getDateFromString(finishDate));
                break;
            case Document.TYPE_RACER_PERENTAL_PERMISSIONS:
                document.setStartDate(DateUtil.getDateFromString(startDate));
                break;
            case Document.TYPE_RACER_MEDICAL_CERTIFICATE:
                document.setFinishDate(DateUtil.getDateFromString(finishDate));
                break;
            default:
                break;
        }
        return document;
    }

    public String createDirectoryForFilesAndGetAbsolutePath() {
        File dir = new File(this.context.getRealPath("") + DocumentService.DOCUMENTS_UPLOAD_DIR);
        if (!dir.exists())
            dir.mkdirs();
        return dir.getAbsolutePath();
    }

    @Override
    public boolean deleteFileFromServer(String filePath) {
        File serverFile = new File(createDirectoryForFilesAndGetAbsolutePath() + File.separator + filePath);
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

    @Override
    public void createStartStatement(String html) {
        try {
            String path = createDirectoryForFilesAndGetAbsolutePath() + "/start.pdf";
            PdfWriter.createStartStatement(path, html);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
}
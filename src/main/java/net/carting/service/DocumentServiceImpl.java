package net.carting.service;

import com.itextpdf.text.DocumentException;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Leader;
import net.carting.util.DateUtil;
import net.carting.util.PdfWriter;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;

import java.io.*;
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
        try {
            Document document = new Document();
            document.setType(documentType);
            document = setDocumentParametersByType(document, number, startDate, finishDate);
            boolean set = false;
            for(String racerId:racersId) {
            	if(set) continue;
            	if(!racerId.equals("-1")) {
                	document.setTeam(racerService.getRacerById(Integer.valueOf(racersId[racersId.length-1])).getTeam());
                	set = true;
                }
            }
            addDocument(document);
            List<byte[]> fileList = new ArrayList<>();
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    fileList.add(file.getBytes());
                }
            }
            fileService.addFilesToDocument(document, fileList);
            racerService.setDocumentToRacers(document, racersId);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        List<byte[]> fileList = new ArrayList<byte[]>();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                fileList.add(file.getBytes());
            }
        }
                //getPathsAndWriteFilesToServer(files, documentType,
                //document.getTeamOwner().getLeader().getId());
        fileService.addFilesToDocument(document, fileList);
        logger.info("Leader "
                + document.getTeamOwner().getLeader().getFirstName() + " "
                + document.getTeamOwner().getLeader().getLastName()
                + " of team " + document.getTeamOwner().getName()
                + " edited document "
                + Document.getStringDocumentType(documentType));
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
            case Document.TYPE_RACER_PARENTAL_PERMISSIONS:
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


    @Override
    @Transactional
    public List<Document> gelAllUncheckedDocuments() {
        return documentDAO.gelAllUncheckedDocuments();
    }

    @Override
    public void createStartStatement(String html) {
        try {
            File dir = new File(this.context.getRealPath("") + DocumentService.DOCUMENTS_UPLOAD_DIR);
            if (!dir.exists())
                dir.mkdirs();
            String path = dir.getAbsolutePath() + "/start.pdf";
            PdfWriter.createStartStatement(path, html);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
}
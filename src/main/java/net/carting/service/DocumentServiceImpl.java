package net.carting.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Leader;
import net.carting.util.DateUtil;
import net.carting.util.PdfWriter;

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

    private static final Logger LOG = LoggerFactory.getLogger(DocumentServiceImpl.class);

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
    	LOG.debug("Start addDocumentAndUpdateRacers method");
    	
        try {
            Document document = new Document();
            document.setType(documentType);
            setDocumentParametersByType(document, number, startDate, finishDate);
            boolean set = false;
            for(String racerId:racersId) {
            	if(set) {
            	    continue;
            	} 
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
        	LOG.error("Error occured in addDocumentAndUpdateRacers method",e);
        }
        LOG.debug("End addDocumentAndUpdateRacers method");
    }


    @Override
    @Transactional
    public void editDocument(Integer documentId, String number, String startDate, String finishDate, 
                             MultipartFile[] files) throws IOException {
 
        Document document = getDocumentById(documentId);
        document.setApproved(false);
        document.setChecked(false);
        document.setReason("");
        setDocumentParametersByType(document, number, startDate, finishDate);
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
        LOG.trace("Leader {} {} of team {} edited document {}",
                document.getTeamOwner().getLeader().getFirstName(),
                document.getTeamOwner().getLeader().getLastName(),
                document.getTeamOwner().getName(),
                Document.getStringDocumentType(documentType));
    }


    @Override
    public void setDocumentParametersByType(Document document, String number, String startDate, String finishDate) {
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
    }


    @Override
    @Transactional
    public List<Document> gelAllUncheckedDocuments() {
        return documentDAO.gelAllUncheckedDocuments();
    }

    @Override
    public void createStartStatement(String html) {
    	LOG.debug("Start createStartStatement method");
        try {
            File dir = new File(this.context.getRealPath("") + DocumentService.DOCUMENTS_UPLOAD_DIR);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            String path = dir.getAbsolutePath() + "/start.pdf";
            PdfWriter.createStartStatement(path, html);
        } catch (IOException e) {
        	LOG.error("Error occured in createStartStatement method",e);
        } catch (DocumentException e) {
        	LOG.error("Error occured in createStartStatement method",e);
        }
        LOG.debug("End createStartStatement method");
    }
}
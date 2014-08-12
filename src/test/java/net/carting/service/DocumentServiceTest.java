package net.carting.service;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.util.DateUtil;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.mock.web.MockHttpServletRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static junit.framework.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class DocumentServiceTest {
    @InjectMocks
    DocumentServiceImpl documentService;

    @Mock
    private FileService fileService;

    @Mock
    private RacerService racerService;

    @Mock
    private DocumentDAO documentDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllDocuments() {
        List<Document> documentList = new ArrayList<Document>();
        documentList.add(new Document());
        documentList.add(new Document());
        when(documentDAO.getAllDocuments()).thenReturn(documentList);
        assertEquals("Expected 2 documentss", 2, documentService
                .getAllDocuments().size());
    }

    @Test
    public void testGetDocumentById() {
        int id = 1;
        Document document = new Document();
        document.setId(id);
        when(documentDAO.getDocumentById(id)).thenReturn(document);
        document = documentService.getDocumentById(id);
        assertNotNull("Document was not found", document);
        assertEquals("Expected " + id, id, document.getId());
    }

    @Test
    public void testAddDocument() {
        Document document = new Document();
        documentService.addDocument(document);
        verify(documentDAO, times(1)).addDocument(document);
    }

    @Test
    public void testUpdateDocument() {
        Document document = new Document();
        documentService.updateDocument(document);
        verify(documentDAO, times(1)).updateDocument(document);
    }

    @Test
    public void testDeleteDocumentFromRacerByRacerIdAndDocumentId() {
        int documentId = 1;
        int racerId = 2;
        documentService.deleteDocumentFromRacerByRacerIdAndDocumentId(documentId, racerId);
        verify(documentDAO, times(1)).deleteDocumentFromRacerByRacerIdAndDocumentId(documentId, racerId);
    }

    @Test
    public void testDeleteDocument() {
        Document document = new Document();
        documentService.deleteDocument(document);
        verify(documentDAO, times(1)).deleteDocument(document);
    }

    @Test
    public void testIsRacerOwnerOfDocument() {
        int id = 1;
        Document document = new Document();
        document.setId(id);
        Set<Racer> racers = new HashSet<Racer>();
        Racer racer = new Racer();
        racers.add(racer);
        document.setRacers(racers);
        when(documentDAO.isRacerOwnerOfDocument(id)).thenReturn(true);
        assertEquals("Expected " + true, true,
                documentService.isRacerOwnerOfDocument(id));
    }
    
    @Test
    public void testGelAllUncheckedDocuments() {
        List<Document> documentList = new ArrayList<Document>();
        Document firstDocument = new Document();
        firstDocument.setChecked(false);
        documentList.add(firstDocument);
        Document secondDocument = new Document();
        secondDocument.setChecked(false);
        documentList.add(secondDocument);
        when(documentDAO.gelAllUncheckedDocuments()).thenReturn(documentList);
        assertEquals("Expected 2 documents", 2, documentService.gelAllUncheckedDocuments().size());
    } 

    @Test
    public void testSetDocumentParametersByType() {
        
        Map<String, Object> documentParameters = new HashMap<String, Object>(); 
        
        documentParameters.put("number", "FG1234");
        documentParameters.put("start_date", "2012-12-12");
        documentParameters.put("finish_date", "2014-12-12");

        // Create a document "Racer licence" and check if the settings of
        // document are set correctly
        Document racerLicence = new Document();
        racerLicence.setType(Document.TYPE_RACER_LICENCE);
        racerLicence = documentService.setDocumentParametersByType(racerLicence, documentParameters);
        System.out.println(racerLicence.getName());
        assertEquals("Expected 'FG1234'", "FG1234", racerLicence.getName());

        // Create a document "Racer insurance" and check if the settings of
        // document are set correctly
        Document racerInsurance = new Document();
        racerInsurance.setType(Document.TYPE_RACER_INSURANCE);
        racerInsurance = documentService.setDocumentParametersByType(racerInsurance, documentParameters);
        assertEquals("Expected 'FG1234'", "FG1234", racerInsurance.getName());
        assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(documentParameters.get("finish_date").toString()), racerInsurance.getFinishDate());

        // Create a document "Racer medical certificate" and check if the
        // settings of document are set correctly
        Document racerMedicalCertificate = new Document();
        racerMedicalCertificate.setType(Document.TYPE_RACER_MEDICAL_CERTIFICATE);
        racerMedicalCertificate = documentService.setDocumentParametersByType(racerMedicalCertificate, documentParameters);
        assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(documentParameters.get("finish_date").toString()),racerMedicalCertificate.getFinishDate());

        // Create a document "Racer perental permissions" and check if the
        // settings of document are set correctly
        Document racerPerentalPermissions = new Document();
        racerPerentalPermissions.setType(Document.TYPE_RACER_PERENTAL_PERMISSIONS);
        racerPerentalPermissions = documentService.setDocumentParametersByType(racerPerentalPermissions, documentParameters);
        assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(documentParameters.get("start_date").toString()),racerPerentalPermissions.getStartDate());
    }

}

package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.mock.web.MockHttpServletRequest;

import net.carting.dao.DocumentDAO;
import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.util.DateUtil;

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
	public void testSetDocumentParametersFromRequestAcordingToType() {
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setParameter("number", "FG1234");
		request.setParameter("start_date", "2012-12-12");
		request.setParameter("finish_date", "2014-12-12");

		// Create a document "Racer licence" and check if the settings of
		// document are set correctly
		Document racerLicence = new Document();
		racerLicence.setType(Document.TYPE_RACER_LICENCE);
		racerLicence = documentService
				.setDocumentParametersFromRequestAcordingToType(racerLicence,
						request);
		assertEquals("Expected 'FG1234'", "FG1234", racerLicence.getName());

		// Create a document "Racer insurance" and check if the settings of
		// document are set correctly
		Document racerInsurance = new Document();
		racerInsurance.setType(Document.TYPE_RACER_INSURANCE);
		racerInsurance = documentService
				.setDocumentParametersFromRequestAcordingToType(racerInsurance,
						request);
		assertEquals("Expected 'FG1234'", "FG1234", racerInsurance.getName());
		assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(request
				.getParameter("finish_date").toString()),
				racerInsurance.getFinishDate());

		// Create a document "Racer medical certificate" and check if the
		// settings of document are set correctly
		Document racerMedicalCertificate = new Document();
		racerMedicalCertificate
				.setType(Document.TYPE_RACER_MEDICAL_CERTIFICATE);
		racerMedicalCertificate = documentService
				.setDocumentParametersFromRequestAcordingToType(
						racerMedicalCertificate, request);
		assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(request
				.getParameter("finish_date").toString()),
				racerMedicalCertificate.getFinishDate());

		// Create a document "Racer perental permissions" and check if the
		// settings of document are set correctly
		Document racerPerentalPermissions = new Document();
		racerPerentalPermissions
				.setType(Document.TYPE_RACER_PERENTAL_PERMISSIONS);
		racerPerentalPermissions = documentService
				.setDocumentParametersFromRequestAcordingToType(
						racerPerentalPermissions, request);
		assertEquals("Expected 'FG1234'", DateUtil.getDateFromString(request
				.getParameter("start_date").toString()),
				racerPerentalPermissions.getStartDate());
	}

}

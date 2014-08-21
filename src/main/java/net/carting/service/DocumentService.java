package net.carting.service;

import java.io.IOException;
import java.util.List;

import net.carting.domain.Document;
import net.carting.domain.Leader;

import org.springframework.web.multipart.MultipartFile;

public interface DocumentService {

    public static final String DOCUMENTS_UPLOAD_DIR = "/resources/documents";

    public static final String START_STATEMENT_PATH = "/Carting" + DOCUMENTS_UPLOAD_DIR + "/start.pdf";

    public List<Document> getAllDocuments();

    public Document getDocumentById(int id);

    public void addDocument(Document document);

    public void updateDocument(Document document);

    public void deleteDocument(Document document);

    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
                                                              int racerId);

    /**
     * <p/>
     * Implementation of this method checks if at least one racer is owner of
     * document
     *
     * @param documentId - id of document
     * @return <code>true</code> if present racer which is owner of this
     * document, <code>false</code> otherwise
     * @author Volodymyr Semaniv
     * @see net.carting.domain.Document
     * @see net.carting.domain.Racer
     * @see net.carting.dao.DocumentDAOImpl
     */
    public boolean isRacerOwnerOfDocument(int documentId);

    /**
     * <p/>
     * Implementation of this method sets parameters to the document according
     * to type of document
     * <p/>
     * <p/>
     * <b>Attention!</b> The document must have set a document type, otherwise
     * the parameters will not be set
     *
     * @param document - the document in which parameters will be set
     * @param request  - the request which was sent from the form of document_add.jsp
     * @return the document with some new parameters*
     * @author Volodymyr Semaniv
     * @see net.carting.domain.Document
     */
    public Document setDocumentParametersByType(Document document, String number, String startDate, String finishDate);

    /**
     * <p/>
     * Implementation of this method uploads files(instances of
     * {@link java.io.File File}) to server and get paths of these files,
     * creates instance of {@link net.carting.domain.Document Document}, creates
     * instances of {@link net.carting.domain.File File} relates instance of
     * {@link net.carting.domain.Document Document} to instance of
     * {@link net.carting.domain.File File} and to racers (instances of
     * {@link net.carting.domain.Racer Racer}) and updates racers
     *
     * @param document - the document in which parameters will be set
     * @param request  - the request which was sent from the form of document_add.jsp
     * @author Volodymyr Semaniv
     * @see net.carting.domain.Document
     * @see net.carting.domain.File
     */
    public void addDocumentAndUpdateRacers(Integer documentType, String[] racersId, String number, 
                                           String startDate, String finishDate, MultipartFile[] files, Leader leader) throws IOException;

    /**
     * <p/>
     * Implementation of this method uploads files (instances of
     * {@link java.io.File File}) to server and get paths of these files,
     * creates instances of {@link net.carting.domain.File File} set them paths,
     * relates instance of Document to instance of
     * {@link net.carting.domain.File File} and updates document
     *
     * @param document - the document in which parameters will be set
     * @param request  - the request which was sent from the form of document_add.jsp
     * @author Volodymyr Semaniv
     * @see net.carting.domain.Document
     * @see net.carting.domain.File
     */
    public void editDocument(Integer documentId, String number, String startDate, String finishDate, 
                             MultipartFile[] files) throws IOException;


    /**
     * <p/>
     * Implementation of this method returns list of all unchecked documents (instances of
     * {@link java.io.Document Document})
     *
     * @param fileAbsolutePath - the relative path of the document which is saved in database
     * @return <code>List<Document></code> of all unchecked documents
     * @author Volodymyr Semaniv
     * @see net.carting.domain.File
     * @see net.carting.domain.Document
     */
    public List<Document> gelAllUncheckedDocuments();

    public void createStartStatement(String html);

}
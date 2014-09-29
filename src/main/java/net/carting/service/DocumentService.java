package net.carting.service;

import net.carting.domain.Document;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface DocumentService {

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
     * @param documentId id of document
     * @return <code>true</code> if present racer which is owner of this
     * document, <code>false</code> otherwise
     * @see net.carting.domain.Document
     * @see net.carting.domain.Racer
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
     * @param document the document in which parameters will be set
     * @param number  the document type id
     * @param startDate  the document start date
     * @param finishDate  the document finish date
     * @see net.carting.domain.Document
     */
    public void setDocumentParametersByType(Document document, String number, String startDate, String finishDate);

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
     * @param documentType  the document type
     * @param racersId array of racers id to whom the documents belong
     * @param number  the document type
     * @param startDate  the document start date
     * @param finishDate  the document finish date
     * @param files  array of file bytes
     * @param fileExtensions  array of file extensions
     * @see net.carting.domain.Document
     * @see net.carting.domain.File
     */
    public void addDocumentAndUpdateRacers(Integer documentType, String[] racersId, String number,
                                           String startDate, String finishDate, MultipartFile[] files, String[] fileExtensions);

    /**
     * <p/>
     * Implementation of this method uploads files (instances of
     * {@link java.io.File File}) to server and get paths of these files,
     * creates instances of {@link net.carting.domain.File File} set them paths,
     * relates instance of Document to instance of
     * {@link net.carting.domain.File File} and updates document
     *
     * @param documentId the document id in which parameters will be set
     * @param number  the document type
     * @param startDate  the document start date
     * @param finishDate  the document finish date
     * @param files  array of file bytes
     * @param fileExtensions  array of file extensions
     * @see net.carting.domain.Document
     * @see net.carting.domain.File
     */
    public void editDocument(Integer documentId, String number, String startDate, String finishDate, 
                             MultipartFile[] files, String[] fileExtensions) throws IOException;


    /**
     * <p/>
     * Implementation of this method returns list of all unchecked documents
     *
     * @return <code>List<Document></code> of all unchecked documents
     * @see net.carting.domain.File
     * @see net.carting.domain.Document
     */
    public List<Document> gelAllUncheckedDocuments();

}
package net.carting.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import net.carting.domain.Document;
import net.carting.domain.Leader;

public interface DocumentService {

	public List<Document> getAllDocuments();

	public Document getDocumentById(int id);

	public void addDocument(Document document);

	public void updateDocument(Document document);

	public void deleteDocument(Document document);

	public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
			int racerId);

	/**
	 * <p>
	 * Implementation of this method checks if at least one racer is owner of
	 * document
	 * 
	 * @param documentId
	 *            - id of document
	 * 
	 * @return <code>true</code> if present racer which is owner of this
	 *         document, <code>false</code> otherwise
	 * 
	 * @see net.carting.domain.Document
	 * @see net.carting.domain.Racer
	 * @see net.carting.dao.DocumentDAOImpl
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public boolean isRacerOwnerOfDocument(int documentId);

	/**
	 * <p>
	 * Implementation of this method writes files to server and returns their
	 * paths
	 * 
	 * @param files
	 *            - array of files that were given from document_add.jsp
	 * @param documentType
	 *            - the type of document
	 * @param leaderId
	 *            - id of team's leader
	 * 
	 * @return List<String> of generated names of the files
	 * @see net.carting.domain.Document
	 * @see net.carting.domain.File
	 * @see java.io.BufferedOutputStream
	 * @see java.io.File
	 * @see java.io.FileOutputStream
	 * 
	 * @throws IOException
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public List<String> getPathsAndWriteFilesToServer(MultipartFile[] files,
			int documentType, int leaderId) throws IOException;

	/**
	 * <p>
	 * Implementation of this method sets parameters to the document according
	 * to type of document
	 * 
	 * <p>
	 * <b>Attention!</b> The document must have set a document type, otherwise
	 * the parameters will not be set
	 * 
	 * @param document
	 *            - the document in which parameters will be set
	 * @param request
	 *            - the request which was sent from the form of document_add.jsp
	 * @return the document with some new parameters*
	 * @see net.carting.domain.Document
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public Document setDocumentParametersFromRequestAcordingToType(
			Document document, HttpServletRequest request);

	/**
	 * <p>
	 * Implementation of this method uploads files(instances of
	 * {@link java.io.File File}) to server and get paths of these files,
	 * creates instance of {@link net.carting.domain.Document Document}, creates
	 * instances of {@link net.carting.domain.File File} relates instance of
	 * {@link net.carting.domain.Document Document} to instance of
	 * {@link net.carting.domain.File File} and to racers (instances of
	 * {@link net.carting.domain.Racer Racer}) and updates racers
	 * 
	 * @param document
	 *            - the document in which parameters will be set
	 * @param request
	 *            - the request which was sent from the form of document_add.jsp
	 * 
	 * @see net.carting.domain.Document
	 * @see net.carting.domain.File
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public void addDocumentAndUpdateRacers(HttpServletRequest request,
			MultipartFile[] files, String[] racersId, Leader leader)
			throws IOException;

	/**
	 * <p>
	 * Implementation of this method uploads files (instances of
	 * {@link java.io.File File}) to server and get paths of these files,
	 * creates instances of {@link net.carting.domain.File File} set them paths,
	 * relates instance of Document to instance of
	 * {@link net.carting.domain.File File} and updates document
	 * 
	 * @param document
	 *            - the document in which parameters will be set
	 * @param request
	 *            - the request which was sent from the form of document_add.jsp
	 * 
	 * @see net.carting.domain.Document
	 * @see net.carting.domain.File
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public void editDocument(int documentId, HttpServletRequest request,
			MultipartFile[] files) throws IOException;

	/**
	 * <p>
	 * Implementation of this creates directory on the server for files saving
	 * and returns absolute path to the directory
	 * 
	 * @return absolute path to the directory
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public String createDirectoryForFilesAndGetAbsolutePath();

	/**
	 * <p>
	 * Implementation of this method deletes file (instances of
	 * {@link java.io.File File}) from server
	 * 
	 * @param fileAbsolutePath
	 *            - the relative path of the document which is saved in database	 
	 * 
	 * @return <code>true</code> if file was deleted successfully,
	 *         <code>false</code> otherwise*
	 * 
	 * @see net.carting.domain.File
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public boolean deleteFileFromServer(String fileAbsolutePath);
	
	/**
	 * <p>
	 * Implementation of this method returns list of all unchecked documents (instances of
	 * {@link java.io.Document Document})
	 * 
	 * @param fileAbsolutePath
	 *            - the relative path of the document which is saved in database
	 * @see net.carting.domain.File
	 * 
	 * @return <code>List<Document></code> of all unchecked documents
	 * @see net.carting.domain.Document
	 * 
	 * @author Volodymyr Semaniv
	 * */
	public List<Document> gelAllUncheckedDocuments();

}
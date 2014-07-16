package net.carting.service;

import java.util.List;

import net.carting.domain.Document;
import net.carting.domain.File;

public interface FileService {

	public List<File> getAllFiles();

	public File getFileById(int id);

	public void addFile(File file);

	public void updateFile(File file);

	public void deleteFile(File file);

	/**
	 * <p>
	 * Adds files to document
	 *  
	 * @param document
	 * @param paths
	 *            - list of names of files
	 *
	 * @see net.carting.domain.File
	 * @see net.carting.domain.Document
	 * 
	 * */
	public void addFilesToDocument(Document document, List<String> paths);

}
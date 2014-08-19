package net.carting.service;

import net.carting.domain.Document;
import net.carting.domain.File;

import java.util.List;

public interface FileService {

    public List<File> getAllFiles();

    public File getFileById(int id);

    public void addFile(File file);

    public void updateFile(File file);

    public void deleteFile(File file);

    /**
     * <p/>
     * Adds files to document
     *
     * @param document
     * @param files    - list of names of files
     * @see net.carting.domain.File
     * @see net.carting.domain.Document
     */
    public void addFilesToDocument(Document document, List<byte[]> files);

}
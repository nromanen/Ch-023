package net.carting.service;

import net.carting.dao.FileDAO;
import net.carting.domain.Document;
import net.carting.domain.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileDAO fileDAO;

    @Override
    @Transactional
    public List<File> getAllFiles() {
        return fileDAO.getAllFiles();
    }

    @Override
    @Transactional
    public File getFileById(int id) {
        return fileDAO.getFileById(id);
    }

    @Override
    @Transactional
    public void addFile(File file) {
        fileDAO.addFile(file);
    }

    @Override
    @Transactional
    public void updateFile(File file) {
        fileDAO.updateFile(file);
    }

    @Override
    @Transactional
    public void deleteFile(File file) {
        fileDAO.deleteFile(file);
    }

    @Override
    @Transactional
    public void addFilesToDocument(Document document, List<byte[]> files) {
        for (byte[] data : files) {
            File pushedFile = new File();
            pushedFile.setDocument(document);
            pushedFile.setFile(data);
            String fileName = Document.getStringDocumentType(document.getType())
                    .replace(" ", "_")
                    + Calendar.getInstance().getTimeInMillis();
            pushedFile.setName(fileName);
            addFile(pushedFile);
        }
    }

}

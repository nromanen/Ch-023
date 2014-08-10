package net.carting.service;

import net.carting.dao.FilesDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletContext;
import java.io.File;

/**
 * Carting
 * Created by manson on 8/10/14.
 */
@Service
public class FilesServiceImpl implements FilesService {

    @Autowired
    private FilesDAO filesDAO;

    @Autowired
    ServletContext context;

    @Override
    @Transactional
    public void uploadAll(String path) {
        filesDAO.uploadAll(path);
    }

    public String createDirectoryForFilesAndGetAbsolutePath() {
        File dir = new File(this.context.getRealPath("") + DocumentService.DOCUMENTS_UPLOAD_DIR);
        if (!dir.exists())
            dir.mkdirs();
        return dir.getAbsolutePath();
    }

    @Override
    @Transactional
    public void downloadAll(String path) {
        filesDAO.downloadAll(path);
    }

    @Override
    @Transactional
    public void uploadAll() {
        uploadAll(createDirectoryForFilesAndGetAbsolutePath());
    }

    @Override
    @Transactional
    public void downloadAll() {
        downloadAll(createDirectoryForFilesAndGetAbsolutePath());
    }
}

package net.carting.dao;

import net.carting.domain.Files;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.io.*;
import java.util.List;

/**
 * Carting
 * Created by manson on 8/10/14.
 */
@Repository
public class FilesDAOImpl implements FilesDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    private Files getFiles(String path) {
        File file = new File(path);
        byte[] fileBytes = new byte[(int) file.length()];
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        //convert file into array of bytes
        try {
            fileInputStream.read(fileBytes);
            fileInputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Files files = new Files();
        files.setFile(fileBytes);
        files.setFileName(file.getName());
        return  files;
    }

    private void saveFile(byte[] bytes, String path, String name) {
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(path + "/" + name);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        try {
            fos.write(bytes);
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void uploadAll(String path) {
        File folder = new File(path);
        File[] listOfFiles = folder.listFiles();
        if (listOfFiles != null) {
            for (File file : listOfFiles) {
                if (file.isFile()) {

                    Files doc = getFiles(file.getAbsolutePath());

                    Query query = entityManager.createQuery("from Files f where f.fileName = :name");
                    query.setParameter("name", doc.getFileName());
                    Files tmpFile = null;
                    try {
                        tmpFile = (Files) query.getSingleResult();
                    } catch (NoResultException e) {
                        System.out.println("Found new file");
                    }
                    if (tmpFile != null) {
                        // duplicate file - merging
                        entityManager.merge(tmpFile);
                    } else {
                        // new file
                        entityManager.persist(doc);
                    }
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public void downloadAll(String path) {
        List<Files> filesList = (List<Files>) entityManager.createQuery("from Files").getResultList();
        for (Files f : filesList) {
            saveFile(f.getFile(), path, f.getFileName());
        }
    }
}
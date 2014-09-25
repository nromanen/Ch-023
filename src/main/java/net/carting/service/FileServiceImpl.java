package net.carting.service;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.FileDAO;
import net.carting.domain.Document;
import net.carting.domain.File;
import net.carting.util.DataBaseDumperUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

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
    public void addFilesToDocument(Document document, List<byte[]> files, String[] fileExtension) {
        int i = 0;
        for (byte[] data : files) {
            File pushedFile = new File();
            pushedFile.setDocument(document);
            pushedFile.setFile(data);
            String fileName = Document.getStringDocumentType(document.getType())
                    .replace(" ", "_")
                    + Calendar.getInstance().getTimeInMillis() +
                    fileExtension[i++];
            pushedFile.setName(fileName);
            addFile(pushedFile);
        }
    }

    @Override
    @Transactional
    public boolean downloadAllFiles(String path) {
        boolean result = true;
        try {
            java.io.File dir = new java.io.File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            for (File file : getAllFiles()) {
                FileOutputStream fos = new FileOutputStream(dir.getAbsoluteFile() + java.io.File.separator + file.getName());
                fos.write(file.getFileBytes());
                fos.close();
            }
        } catch (Exception e) {
            result = false;
        }
        return result;
    }

    @Override
    @Transactional
    public boolean createDbDump(String path) {
        boolean result = true;
        Properties props = new Properties();
        try {
            props.load(this.getClass().getClassLoader().getResourceAsStream("jdbc.properties"));
            java.io.File dir = new java.io.File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            PrintWriter writer = new PrintWriter(dir.getAbsoluteFile() + java.io.File.separator + "dump.sql", "UTF-8");
            writer.println(DataBaseDumperUtil.dumpDB(props));
            writer.close();
        } catch (Exception e) {
            result = false;
        }
        return result;
    }

    @Autowired
    private AdminSettingsDAO adminSettingsDAO;

    @Override
    @Transactional
    public boolean uploadDbDump(String path) {
        boolean result;
        try {
            String everything = "";
            BufferedReader br = new BufferedReader(new FileReader(path));
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            everything = sb.toString();
            result = adminSettingsDAO.uploadDbDump(everything);
        } catch (Exception e) {
            result = false;
        }
        return result;
    }

}

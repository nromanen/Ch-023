package net.carting.dao;

import net.carting.domain.File;

import java.util.List;

public interface FileDAO {

    public List<File> getAllFiles();

    public File getFileById(int id);

    public void addFile(File file);

    public void updateFile(File file);

    public void deleteFile(File file);

}
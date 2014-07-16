package net.carting.dao;

import java.util.List;

import net.carting.domain.File;

public interface FileDAO {

	public List<File> getAllFiles();

	public File getFileById(int id);

	public void addFile(File file);

	public void updateFile(File file);

	public void deleteFile(File file);

}
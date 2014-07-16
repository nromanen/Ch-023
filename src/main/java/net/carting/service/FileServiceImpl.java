package net.carting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.carting.dao.FileDAO;
import net.carting.domain.Document;
import net.carting.domain.File;

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
	public void addFilesToDocument(Document document, List<String> paths) {
		for (int i = 0; i < paths.size(); i++) {
			File pushedFile = new File();
			pushedFile.setDocument(document);
			pushedFile.setPath(paths.get(i));
			addFile(pushedFile);
		}		
	}

}

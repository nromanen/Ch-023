package net.carting.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.File;

@Repository
public class FileDAOImpl implements FileDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<File> getAllFiles() {
		return sessionFactory.getCurrentSession().createQuery("from File")
				.list();
	}

	@Override
	public File getFileById(int id) {
		return (File) sessionFactory.getCurrentSession().get(File.class, id);
	}

	@Override
	public void addFile(File file) {
		sessionFactory.getCurrentSession().save(file);
	}

	@Override
	public void updateFile(File file) {
		sessionFactory.getCurrentSession().merge(file);
	}

	@Override
	public void deleteFile(File file) {
		sessionFactory.getCurrentSession().delete(file);
	}

}

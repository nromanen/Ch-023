package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class FileDAOImpl implements FileDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(FileDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<File> getAllFiles() {
    	LOG.debug("Get all files");
        return entityManager
                .createQuery("from File")
                .getResultList();
    }

    @Override
    public File getFileById(int id) {
    	LOG.debug("Get file with id = {}", id);
        return (File) entityManager
                .createQuery("from File where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addFile(File file) {
        entityManager.persist(file);
    	LOG.debug("Added file {}", file);

    }

    @Override
    public void updateFile(File file) {
        entityManager.merge(file);
    	LOG.debug("Updated file with id = {}", file.getId());

    }

    @Override
    public void deleteFile(File file) {
        Query query = entityManager.createQuery(
                "DELETE FROM File c WHERE c.id = :id");
        query.setParameter("id", file.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted file with id = {}", file.getId());
        } else {
        	LOG.warn("Tried to delete file with id = {}", file.getId());
        }
    }
}

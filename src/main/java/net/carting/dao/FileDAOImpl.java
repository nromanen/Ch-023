package net.carting.dao;

import net.carting.domain.File;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class FileDAOImpl implements FileDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<File> getAllFiles() {
        List<File> files = entityManager
                .createQuery("from File")
                .getResultList();

        return files;
    }

    @Override
    public File getFileById(int id) {
        File file = (File) entityManager
                .createQuery("from File where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);

        return file;
    }

    @Override
    public void addFile(File file) {
        entityManager.persist(file);

    }

    @Override
    public void updateFile(File file) {
        entityManager.merge(file);

    }

    @Override
    public void deleteFile(File file) {
        entityManager.remove(file);

    }

}

package net.carting.dao;

import net.carting.domain.File;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class FileDAOImpl implements FileDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<File> getAllFiles() {
        return entityManager
                .createQuery("from File")
                .getResultList();
    }

    @Override
    public File getFileById(int id) {
        return (File) entityManager
                .createQuery("from File where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
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
        Query query = entityManager.createQuery(
                "DELETE FROM File c WHERE c.id = :id");
        query.setParameter("id", file.getId());
        query.executeUpdate();
    }

}

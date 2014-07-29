package net.carting.dao;

import net.carting.domain.Document;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class DocumentDAOImpl implements DocumentDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> getAllDocuments() {
        return entityManager.createQuery("from Document").getResultList();
    }

    @Override
    public Document getDocumentById(int id) {
        return (Document) entityManager
                .createQuery("from Document where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    @Override
    public void addDocument(Document document) {
        entityManager.persist(document);
    }

    @Override
    public void updateDocument(Document document) {
        entityManager.merge(document);
    }

    @Override
    public void deleteDocument(Document document) {
        Query query = entityManager.createQuery(
                "DELETE FROM Document c WHERE c.id = :id");
        query.setParameter("id", document.getId());
        query.executeUpdate();
    }

    @Override
    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
                                                              int racerId) {
        String sql = "DELETE FROM racer_document WHERE document_id= :documentId AND racer_id= :racerId";
        Query query = entityManager.createQuery(sql)
                .setParameter("documentId", documentId)
                .setParameter("racerId", racerId);
        query.executeUpdate();
    }

    @Override
    public boolean isRacerOwnerOfDocument(int documentId) {
        String sql = "SELECT racer_id FROM racer_document WHERE document_id= :documentId  ";
        Query query = entityManager.createQuery(sql).setParameter("documentId", documentId);
        boolean emptyList = query.getResultList().isEmpty();
        return !emptyList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> gelAllUncheckedDocuments() {
        return entityManager.
                createQuery("from Document where checked= :checked").
                setParameter("checked", false).getResultList();
    }

}
